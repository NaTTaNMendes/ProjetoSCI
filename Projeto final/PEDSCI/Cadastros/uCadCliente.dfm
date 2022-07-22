inherited frCadCliente: TfrCadCliente
  Caption = 'Cadastro cliente'
  ClientHeight = 271
  ClientWidth = 349
  OnShow = FormShow
  ExplicitWidth = 365
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel [0]
    Left = 49
    Top = 72
    Width = 37
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lbCPF: TLabel [1]
    Left = 63
    Top = 104
    Width = 23
    Height = 13
    Caption = 'CPF:'
  end
  object lbNome: TLabel [2]
    Left = 55
    Top = 136
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  object lbUF: TLabel [3]
    Left = 49
    Top = 168
    Width = 37
    Height = 13
    Caption = 'Estado:'
  end
  object lbTelefone: TLabel [4]
    Left = 40
    Top = 200
    Width = 46
    Height = 13
    Caption = 'Telefone:'
  end
  object lbAviso: TLabel [5]
    Left = 8
    Top = 246
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
    Width = 349
    TabOrder = 4
    ExplicitWidth = 349
    inherited btConsultar: TToolButton
      OnClick = btConsultarClick
    end
  end
  object edCodigo: TEdit [7]
    Left = 123
    Top = 69
    Width = 158
    Height = 21
    TabOrder = 0
    TextHint = 'Insira o c'#243'digo'
    OnExit = edCodigoExit
  end
  object edCPF: TEdit [8]
    Left = 123
    Top = 101
    Width = 158
    Height = 21
    TabOrder = 1
    TextHint = 'Insira o CPF'
  end
  object edNome: TEdit [9]
    Left = 123
    Top = 133
    Width = 158
    Height = 21
    TabOrder = 2
    TextHint = 'Insira o nome'
  end
  object cbUF: TComboBox [10]
    Left = 123
    Top = 165
    Width = 158
    Height = 21
    ItemIndex = 0
    TabOrder = 3
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
    Left = 123
    Top = 200
    Width = 90
    Height = 21
    EditMask = '!\(99\)9999-9999;1;_'
    MaxLength = 13
    TabOrder = 5
    Text = '(  )    -    '
    TextHint = 'Informe o telefone'
  end
end
