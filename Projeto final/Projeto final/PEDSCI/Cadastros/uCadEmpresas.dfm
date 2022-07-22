inherited frCadEmpresas: TfrCadEmpresas
  Caption = 'Cadastro de empresas'
  ClientHeight = 257
  ClientWidth = 381
  OnShow = FormShow
  ExplicitWidth = 397
  ExplicitHeight = 296
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 65
    Top = 59
    Width = 37
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lbCNPJ: TLabel [1]
    Left = 73
    Top = 91
    Width = 29
    Height = 13
    Caption = 'CNPJ:'
  end
  object lbNome: TLabel [2]
    Left = 71
    Top = 123
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object lbUF: TLabel [3]
    Left = 65
    Top = 155
    Width = 37
    Height = 13
    Caption = 'Estado:'
  end
  object lbTelefone: TLabel [4]
    Left = 56
    Top = 187
    Width = 46
    Height = 13
    Caption = 'Telefone:'
  end
  object lbAviso: TLabel [5]
    Left = 8
    Top = 232
    Width = 4
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited tbFerramentas: TToolBar
    Width = 381
    ExplicitWidth = 381
    inherited btConsultar: TToolButton
      OnClick = btConsultarClick
    end
  end
  object edCodigo: TEdit [7]
    Left = 139
    Top = 56
    Width = 158
    Height = 21
    TabOrder = 1
    TextHint = 'Insira o c'#243'digo'
    OnExit = edCodigoExit
  end
  object edCNPJ: TEdit [8]
    Left = 139
    Top = 88
    Width = 158
    Height = 21
    TabOrder = 2
    TextHint = 'Insira o CNPJ'
  end
  object edNome: TEdit [9]
    Left = 139
    Top = 120
    Width = 158
    Height = 21
    TabOrder = 3
    TextHint = 'Insira o nome'
  end
  object cbUF: TComboBox [10]
    Left = 139
    Top = 152
    Width = 158
    Height = 21
    ItemIndex = 0
    TabOrder = 4
    Text = 'ACRE'
    Items.Strings = (
      'ACRE'
      'ALAGOAS'
      'AMAZONAS'
      'AMAP'#193
      'BAHIA'
      'CEAR'#193
      'DISTRITO FEDERAL'
      'ESP'#205'RITO SANTO'
      'GOI'#193'S'
      'MARANH'#195'O'
      'MINAS GERAIS'
      'MATO GROSSO DO SUL'
      'MATO GROSSO'
      'PAR'#193
      'PARA'#205'BA'
      'PERNAMBUCO'
      'PIAU'#205
      'PARAN'#193
      'RIO DE JANEIRO'
      'RIO GRANDE DO NORTE'
      'ROND'#212'NIA'
      'RORAIMA'
      'RIO GRANDE DO SUL'
      'SANTA CATARINA'
      'SERGIPE'
      'S'#195'O PAULO'
      'TOCANTINS'
      'ZONA FRANCA'
      'EXTERIOR')
  end
  object mskTelefone: TMaskEdit [11]
    Left = 139
    Top = 179
    Width = 124
    Height = 21
    EditMask = '!\(99\)9999-9999;1;_'
    MaxLength = 13
    TabOrder = 5
    Text = '(  )    -    '
    TextHint = 'Informe o telefone'
  end
end
