object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Consulta ViaCEP - Softplan'
  ClientHeight = 560
  ClientWidth = 757
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object Label3: TLabel
    Left = 86
    Top = 233
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 66
    Top = 261
    Width = 65
    Height = 13
    Caption = 'Complemento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 103
    Top = 288
    Width = 28
    Height = 13
    Caption = 'Bairro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 98
    Top = 316
    Width = 33
    Height = 13
    Caption = 'Cidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 118
    Top = 342
    Width = 13
    Height = 13
    Caption = 'UF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 112
    Top = 206
    Width = 19
    Height = 13
    Caption = 'CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtEndereco: TDBEdit
    Left = 137
    Top = 230
    Width = 362
    Height = 21
    TabStop = False
    DataField = 'endereco'
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
  object edtComplemento: TDBEdit
    Left = 137
    Top = 258
    Width = 362
    Height = 21
    TabStop = False
    DataField = 'complemento'
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object edtBairro: TDBEdit
    Left = 137
    Top = 285
    Width = 362
    Height = 21
    TabStop = False
    DataField = 'cep'
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object edtCidade: TDBEdit
    Left = 137
    Top = 312
    Width = 362
    Height = 23
    TabStop = False
    DataField = 'cidade'
    DataSource = dsDados
    ReadOnly = True
    TabOrder = 6
  end
  object edtUF: TDBEdit
    Left = 137
    Top = 339
    Width = 50
    Height = 21
    TabStop = False
    DataField = 'uf'
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object edtCEP: TDBEdit
    Left = 137
    Top = 203
    Width = 97
    Height = 21
    TabStop = False
    DataField = 'cep'
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object grdDados: TDBGrid
    Left = 0
    Top = 381
    Width = 757
    Height = 160
    Align = alBottom
    DataSource = dsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'cep'
        Title.Caption = 'CEP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'endereco'
        Title.Caption = 'Endere'#231'o'
        Width = 193
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'complemento'
        Title.Caption = 'Complemento'
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'bairro'
        Title.Caption = 'Bairro'
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cidade'
        Title.Caption = 'Cidade'
        Width = 198
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Title.Caption = 'UF'
        Width = 41
        Visible = True
      end>
  end
  object pnlConsultaCEP: TPanel
    Left = 0
    Top = 48
    Width = 257
    Height = 142
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 67
      Top = 57
      Width = 19
      Height = 13
      Caption = 'CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 62
      Top = 9
      Width = 136
      Height = 18
      Caption = 'Pesquisar por CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCEPConsulta: TEdit
      Left = 92
      Top = 54
      Width = 92
      Height = 21
      Hint = 'Informe o CEP que deseja consultar. Utilizar apenas n'#250'meros.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = edtCEPConsultaKeyPress
    end
    object btnConsultarCEP: TButton
      Left = 45
      Top = 98
      Width = 179
      Height = 31
      Cursor = crHandPoint
      Caption = 'Consultar &CEP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnConsultarCEPClick
    end
  end
  object pnlConsultaEndereco: TPanel
    Left = 255
    Top = 48
    Width = 500
    Height = 142
    BevelOuter = bvLowered
    TabOrder = 1
    object Label10: TLabel
      Left = 54
      Top = 44
      Width = 13
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 131
      Top = 45
      Width = 33
      Height = 13
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 22
      Top = 73
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 108
      Top = 9
      Width = 273
      Height = 18
      Caption = 'Pesquisar por UF, Cidade e Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtUFConsulta: TEdit
      Left = 71
      Top = 43
      Width = 42
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 0
    end
    object edtCidadeConsulta: TEdit
      Left = 170
      Top = 43
      Width = 289
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 1
    end
    object edtEnderecoConsulta: TEdit
      Left = 71
      Top = 70
      Width = 388
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 2
    end
    object btnConsultarEndereco: TButton
      Left = 152
      Top = 98
      Width = 179
      Height = 31
      Cursor = crHandPoint
      Caption = 'Consultar &Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnConsultarEnderecoClick
    end
  end
  object pnlTipoConsulta: TPanel
    Left = 0
    Top = 0
    Width = 757
    Height = 48
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 9
    object Label4: TLabel
      Left = 146
      Top = 15
      Width = 132
      Height = 18
      Caption = 'Tipo da Consulta: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rdbJSON: TRadioButton
      Left = 311
      Top = 16
      Width = 146
      Height = 17
      Caption = 'Consulta via JSON'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object rdbXML: TRadioButton
      Left = 470
      Top = 16
      Width = 137
      Height = 17
      Caption = 'Consulta via XML'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 541
    Width = 757
    Height = 19
    Panels = <
      item
        Text = 
          'Desafio T'#233'cnico - Vaga para Desenvolvedor Delphi S'#234'nior C'#243'd 6678' +
          ' - Softplan'
        Width = 500
      end
      item
        Text = 'Candidato: Vitor Mendes Souza'
        Width = 50
      end>
    ExplicitLeft = 536
    ExplicitTop = 360
    ExplicitWidth = 0
  end
  object CEPClient: TCEPClient
    FormatoResponse = frJSON
    Left = 690
    Top = 199
  end
  object dsDados: TDataSource
    DataSet = sqlDados
    Left = 592
    Top = 328
  end
  object ConexaoBD: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'User_Name=postgres'
      'Server=localhost'
      'Password=vitor'
      'Database=softplan')
    LoginPrompt = False
    Left = 592
    Top = 200
  end
  object sqlDados: TFDQuery
    Connection = ConexaoBD
    SQL.Strings = (
      'SELECT'
      '    CODIGO,'
      '    CEP,'
      '    ENDERECO,'
      '    COMPLEMENTO,'
      '    BAIRRO,'
      '    CIDADE,'
      '    UF'
      'FROM'
      #9'VIACEP')
    Left = 592
    Top = 264
  end
end
