unit CEPClient;

interface

uses
  System.SysUtils, System.Classes, IdHTTP, System.Generics.Collections,
  System.JSON, Xml.XMLDoc, xml.XMLIntf, IdURI;

type
  TCEPFormatoResponse = (frJSON, frXML);

  TCEPData = record
    CEP,
    Endereco,
    Complemento,
    Bairro,
    Cidade,
    UF: string;
  end;

  TCEPResponse = record
    Sucesso: Boolean;
    HTTPCodigo: Integer;
    Dados: TArray<TCEPData>;
  end;

  ICEPClient = interface
    ['{B07E0FA2-5745-4E14-B53B-39E84DB6D64B}']
    function ConsultarCEP(const CEP: string): TCEPResponse;
    function ConsultarEndereco(const UF, Cidade, Endereco: string): TCEPResponse;
  end;

  TCEPClient = class(TComponent, ICEPClient)
  private
    FFormatoResponse: TCEPFormatoResponse;
    function MontarURLRequisicao(const DadosConsulta: string): string;
    function RealizarRequisicao(const URLRequisicao: string): TCEPResponse;
    function FormatarRespostaJSON(const Response: TStringStream): TArray<TCEPData>;
    function FormatarRespostaXML(const Response: TStringStream): TArray<TCEPData>;
    function ProcessarResposta(const Response: TStringStream): TArray<TCEPData>;
    procedure PreencherCEPData(var Data: TCEPData; JSONObject: TJSONObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ConsultarCEP(const CEP: string): TCEPResponse;
    function ConsultarEndereco(const UF, Cidade, Endereco: string): TCEPResponse;
  published
    property FormatoResponse: TCEPFormatoResponse read FFormatoResponse write FFormatoResponse;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TCEPClient]);
end;


{ ConsultaCEP }

function TCEPClient.ConsultarCEP(const CEP: string): TCEPResponse;
begin
  Result := RealizarRequisicao(MontarURLRequisicao(CEP));
end;

function TCEPClient.ConsultarEndereco(const UF, Cidade, Endereco: string): TCEPResponse;
var
  EnderecoCompleto: string;
begin
  EnderecoCompleto := UF + '/' + Cidade + '/' + Endereco;
  Result := RealizarRequisicao(MontarURLRequisicao(EnderecoCompleto));
end;

constructor TCEPClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCEPClient.Destroy;
begin
  inherited Destroy;
end;

function TCEPClient.MontarURLRequisicao(const DadosConsulta: string): string;
const
  URL_VIACEP = 'http://viacep.com.br/ws/';
begin
  Result := URL_VIACEP + TIdURI.ParamsEncode(DadosConsulta);
  case FormatoResponse of
    frJSON: Result := Result + '/json/';
    frXML : Result := Result + '/xml/';
  end;
end;

function TCEPClient.ProcessarResposta(const Response: TStringStream): TArray<TCEPData>;
begin
  case FormatoResponse of
    frJSON: Result := FormatarRespostaJSON(Response);
    frXML : Result := FormatarRespostaXML (Response);
  end;
end;

function TCEPClient.RealizarRequisicao(const URLRequisicao: string): TCEPResponse;
var
  IdHTTP   : TIdHTTP;
  Response : TStringStream;
  CEPDataArray: TArray<TCEPData>;
  CEPResponse: TCEPResponse;
const
  HTTP_OK = 200;
begin
  IdHTTP   := TIdHTTP.Create;
  Response := TStringStream.Create('', TEncoding.UTF8);
  CEPResponse.Sucesso := False;

  try
    try
      IdHTTP.Get(URLRequisicao, Response);

      if IdHTTP.ResponseCode = HTTP_OK then
      begin
        CEPResponse.Sucesso    := True;
        CEPResponse.HTTPCodigo := HTTP_OK;

        CEPDataArray := ProcessarResposta(Response);
        if Length(CEPDataArray) > 0 then
          CEPResponse.Dados := CEPDataArray
        else
          CEPResponse.Sucesso := False;
      end
      else
      begin
        CEPResponse.HTTPCodigo := IdHTTP.ResponseCode;
        SetLength(CEPResponse.Dados, 0);
      end;

    except
      on E: Exception do
      begin
        CEPResponse.Sucesso    := False;
        CEPResponse.HTTPCodigo := -1;
        SetLength(CEPResponse.Dados, 0);
      end;
    end;
  finally
    IdHTTP.Free;
    Response.Free;
  end;

  Result := CEPResponse;
end;

function TCEPClient.FormatarRespostaJSON(const Response: TStringStream): TArray<TCEPData>;
var
  JSONValue: TJSONValue;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  i, QtdeRegistros: Integer;
const
  ERRO_VIACEP = '{'#$A'  "erro": true'#$a'}';
begin
  if Response.DataString = ERRO_VIACEP then
    Exit;

  SetLength(Result, 0);
  JSONValue := TJSONObject.ParseJSONValue(Response.DataString);
  try
      if JSONValue is TJSONArray then
      begin
        JSONArray := TJSONArray(JSONValue);

        QtdeRegistros := JSONArray.Count;
        SetLength(Result, QtdeRegistros);

        for i := 0 to QtdeRegistros -1 do
        begin
          JSONObject := JSONArray.Items[i] as TJSONObject;
          PreencherCEPData(Result[i], JSONObject);
        end;
      end
      else if JSONValue is TJSONObject then
      begin
        SetLength(Result, 1);
        JSONObject := TJSONObject(JSONValue);
        PreencherCEPData(Result[0], JSONObject);
      end;

  finally
    JSONValue.Free;
  end;
end;

procedure TCEPClient.PreencherCEPData(var Data: TCEPData; JSONObject: TJSONObject);
begin
  Data.CEP         := JSONObject.GetValue('cep').Value;
  Data.Endereco    := JSONObject.GetValue('logradouro').Value;
  Data.Complemento := JSONObject.GetValue('complemento').Value;
  Data.Bairro      := JSONObject.GetValue('bairro').Value;
  Data.Cidade      := JSONObject.GetValue('localidade').Value;
  Data.UF          := JSONObject.GetValue('uf').Value;
end;

function TCEPClient.FormatarRespostaXML(const Response: TStringStream): TArray<TCEPData>;
var
  XMLDocument: IXMLDocument;
  NodeList: IXMLNodeList;
  Node: IXMLNode;
  i, QtdeRegistros: Integer;
begin
  XMLDocument := TXMLDocument.Create(nil);
  try
    XMLDocument.LoadFromXML(Response.DataString);
    NodeList := XMLDocument.DocumentElement.ChildNodes;

    QtdeRegistros := NodeList.Count;
    SetLength(Result, QtdeRegistros);

    for i := 0 to QtdeRegistros -1 do
    begin
      Node := NodeList[i];
      Result[i].CEP         := Node.ChildNodes['cep'].Text;
      Result[i].Endereco    := Node.ChildNodes['logradouro'].Text;
      Result[i].Complemento := Node.ChildNodes['complemento'].Text;
      Result[i].Bairro      := Node.ChildNodes['bairro'].Text;
      Result[i].Cidade      := Node.ChildNodes['localidade'].Text;
      Result[i].UF          := Node.ChildNodes['uf'].Text;
    end;
  finally
    XMLDocument := nil;
  end;
end;

end.

