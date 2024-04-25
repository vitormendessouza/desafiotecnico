unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, CEPClient, Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.ComCtrls, System.UITypes, IniFiles;

type
  TfrmPrincipal = class(TForm)
    CEPClient: TCEPClient;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edtEndereco: TDBEdit;
    edtComplemento: TDBEdit;
    edtBairro: TDBEdit;
    edtCidade: TDBEdit;
    edtUF: TDBEdit;
    edtCEP: TDBEdit;
    grdDados: TDBGrid;
    pnlConsultaCEP: TPanel;
    Label1: TLabel;
    edtCEPConsulta: TEdit;
    btnConsultarCEP: TButton;
    pnlConsultaEndereco: TPanel;
    Label10: TLabel;
    edtUFConsulta: TEdit;
    Label12: TLabel;
    edtCidadeConsulta: TEdit;
    Label13: TLabel;
    edtEnderecoConsulta: TEdit;
    btnConsultarEndereco: TButton;
    Label2: TLabel;
    Label14: TLabel;
    pnlTipoConsulta: TPanel;
    rdbJSON: TRadioButton;
    rdbXML: TRadioButton;
    Label4: TLabel;
    dsDados: TDataSource;
    ConexaoBD: TFDConnection;
    sqlDados: TFDQuery;
    StatusBar1: TStatusBar;
    procedure btnConsultarCEPClick(Sender: TObject);
    procedure edtCEPConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarEnderecoClick(Sender: TObject);
  private
    procedure InserirOuAtualizarRegistroBD(const Data: TArray<TCEPData>);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnConsultarCEPClick(Sender: TObject);
var
  Requisicao: TCEPResponse;
  CEP: string;
begin
  CEP := edtCEPConsulta.Text;

  if Length(Trim(CEP)) < 8 then
  begin
    ShowMessage('Informe o CEP corretamente, com 8 números e sem hífen ou traço.');
    edtCEPConsulta.SetFocus;
    Exit;
  end;

  if sqlDados.Locate('CEP', CEP, []) then
  begin
    if MessageDlg('CEP encontrado na base de dados.' + #13#10 +
                  'Deseja efetuar uma nova consulta atualizando as informações existentes?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;

    sqlDados.Edit;
  end;

  Requisicao := CEPClient.ConsultarCEP(CEP);
  if Requisicao.Sucesso then
  begin
    InserirOuAtualizarRegistroBD(Requisicao.Dados);
    sqlDados.Locate('CEP', CEP, []);

    ShowMessage('CEP encontrado e cadastrado com sucesso.');
  end
  else
    ShowMessage('Não foi possível encontrar este CEP.');

end;

procedure TfrmPrincipal.btnConsultarEnderecoClick(Sender: TObject);
var
  UF, Cidade, Endereco: string;
  Requisicao: TCEPResponse;
begin
  UF := Trim(edtUFConsulta.Text);
  Cidade := Trim(edtCidadeConsulta.Text);
  Endereco := Trim(edtEnderecoConsulta.Text);

  if Length(UF) < 2 then
  begin
    ShowMessage('Preencha corretamente o campo de UF, deve conter 2 caracteres.');
    edtUFConsulta.SetFocus;
    Exit;
  end;

  if Length(Cidade) < 3  then
  begin
    ShowMessage('Preencha corretamente o campo de Cidade, deve conter no mínimo 3 caracteres.');
    edtCidadeConsulta.SetFocus;
    Exit;
  end;

  if Length(Endereco) < 3  then
  begin
    ShowMessage('Preencha corretamente o campo de Endereço, deve conter no mínimo 3 caracteres.');
    edtEnderecoConsulta.SetFocus;
    Exit;
  end;

  if sqlDados.Locate('UF;Cidade;Endereco', VarArrayOf([UF,Cidade,Endereco]), []) then
  begin
    if MessageDlg('Endereço completo encontrado na base de dados.' + #13#10 +
                  'Deseja efetuar uma nova consulta atualizando as informações existentes?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;

    sqlDados.Edit;
  end;

  Requisicao := CEPClient.ConsultarEndereco(UF, Cidade, Endereco);
  if Requisicao.Sucesso then
  begin
    InserirOuAtualizarRegistroBD(Requisicao.Dados);
    sqlDados.Locate('UF;Cidade;Endereco', VarArrayOf([UF,Cidade,Endereco]), []);

    ShowMessage('Endereço completo encontrado e cadastrado com sucesso.');
  end
  else
    ShowMessage('Endereço completo não encontrado.');

end;

procedure TfrmPrincipal.edtCEPConsultaKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, #10]) then
    Key := #0;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  ArquivoIni: TIniFile;
  ArquivoIniPath: string;
begin
  try
    ConexaoBD.Connected := False;
    ArquivoIniPath := ExtractFilePath(Application.ExeName) + 'softplan.ini';
    if FileExists(ArquivoIniPath) then
    begin
      ArquivoIni := TIniFile.Create(ArquivoIniPath);
      try
        ConexaoBD.Params.Clear;
        ConexaoBD.Params.Add('DriverID=' + ArquivoIni.ReadString('BASE', 'DriverID', 'PG'));
        ConexaoBD.Params.Add('User_Name=' + ArquivoIni.ReadString('BASE', 'User_Name', 'postgres'));
        ConexaoBD.Params.Add('Server=' + ArquivoIni.ReadString('BASE', 'Server', ''));
        ConexaoBD.Params.Add('Port=' + ArquivoIni.ReadString('BASE', 'Port', '5432'));
        ConexaoBD.Params.Add('Password=' + ArquivoIni.ReadString('BASE', 'Password', 'vitor'));
        ConexaoBD.Params.Add('Database=' + ArquivoIni.ReadString('BASE', 'Database', 'softplan'));
        ConexaoBD.Connected := True;

        sqlDados.Close;
        sqlDados.Open;
        rdbJSON.Checked := True;
        edtCEPConsulta.SetFocus;
      finally
        ArquivoIni.Free;
      end;
    end
    else
    begin
      ShowMessage('Arquivo softplan.ini não encontrado. Por favor, verifique no diretório junto ao executável do projeto');
      Application.Terminate;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao conectar ao banco de dados.' + sLineBreak + E.Message);
      Abort;
    end;
  end;
end;


procedure TfrmPrincipal.InserirOuAtualizarRegistroBD(const Data: TArray<TCEPData>);
var
  Registro: TCEPData;
begin
  for Registro in Data do
  begin
    try
      if not (sqlDados.State = dsEdit) then
        sqlDados.Append;
      sqlDados.FieldByName('CEP').AsString         := StringReplace(Registro.CEP, '-', '', []);
      sqlDados.FieldByName('ENDERECO').AsString    := Registro.Endereco;
      sqlDados.FieldByName('COMPLEMENTO').AsString := Registro.Complemento;
      sqlDados.FieldByName('BAIRRO').AsString      := Registro.Bairro;
      sqlDados.FieldByName('CIDADE').AsString      := Registro.Cidade;
      sqlDados.FieldByName('UF').AsString          := Registro.UF;
      sqlDados.Post;
    except
      sqlDados.Cancel;
      raise;
    end;
  end;

  sqlDados.Close;
  sqlDados.Open;
end;

end.
