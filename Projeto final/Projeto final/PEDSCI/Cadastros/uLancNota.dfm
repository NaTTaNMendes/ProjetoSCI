inherited frLancNota: TfrLancNota
  Caption = 'Lan'#231'amento de Nota Fiscal'
  ClientHeight = 257
  ClientWidth = 709
  OnShow = FormShow
  ExplicitWidth = 725
  ExplicitHeight = 296
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigoNota: TLabel [0]
    Left = 57
    Top = 57
    Width = 62
    Height = 13
    Caption = 'C'#243'digo nota:'
  end
  object lbData: TLabel [1]
    Left = 88
    Top = 179
    Width = 27
    Height = 13
    Caption = 'Data:'
  end
  object lbCliente: TLabel [2]
    Left = 201
    Top = 57
    Width = 71
    Height = 13
    Caption = 'C'#243'digo cliente:'
  end
  object lbCodEmpresa: TLabel [3]
    Left = 349
    Top = 57
    Width = 81
    Height = 13
    Caption = 'C'#243'digo empresa:'
  end
  object lbCodProd: TLabel [4]
    Left = 509
    Top = 60
    Width = 78
    Height = 13
    Caption = 'C'#243'digo produto:'
  end
  object lbQuantidade: TLabel [5]
    Left = 380
    Top = 179
    Width = 60
    Height = 13
    Caption = 'Quantidade:'
  end
  object lbVaor: TLabel [6]
    Left = 83
    Top = 120
    Width = 68
    Height = 13
    Caption = 'Valor da nota:'
  end
  object lbAliquota: TLabel [7]
    Left = 383
    Top = 120
    Width = 71
    Height = 13
    Caption = 'Al'#237'quota ICMS:'
  end
  object lbAviso: TLabel [8]
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
    Width = 709
    TabOrder = 8
    ExplicitWidth = 709
    inherited btConsultar: TToolButton
      OnClick = btConsultarClick
    end
  end
  object edCodigoNota: TEdit [10]
    Left = 130
    Top = 54
    Width = 55
    Height = 21
    TabOrder = 0
    OnExit = edCodigoNotaExit
  end
  object edCodCliente: TEdit [11]
    Left = 283
    Top = 54
    Width = 55
    Height = 21
    TabOrder = 1
  end
  object edCodEmpresa: TEdit [12]
    Left = 442
    Top = 54
    Width = 55
    Height = 21
    TabOrder = 2
  end
  object edCodProd: TEdit [13]
    Left = 593
    Top = 57
    Width = 55
    Height = 21
    TabOrder = 3
  end
  object dtpData: TDateTimePicker [14]
    Left = 130
    Top = 171
    Width = 186
    Height = 21
    Date = 44760.000000000000000000
    Time = 0.639012939813255800
    TabOrder = 6
  end
  object edQuantidade: TEdit [15]
    Left = 456
    Top = 176
    Width = 121
    Height = 21
    TabOrder = 7
    TextHint = 'Insira a quantidade'
  end
  object edValor: TEdit [16]
    Left = 162
    Top = 117
    Width = 127
    Height = 21
    TabOrder = 4
    TextHint = 'Informe o valor'
    OnExit = edCodigoNotaExit
  end
  object edAliquota: TEdit [17]
    Left = 460
    Top = 117
    Width = 127
    Height = 21
    TabOrder = 5
    TextHint = 'Informe a al'#237'quota'
    OnExit = edCodigoNotaExit
  end
  inherited imBotoes: TImageList
    Left = 664
  end
  inherited imBotoesSelecionados: TImageList
    Left = 664
  end
  inherited imBotoesDesabilitados: TImageList
    Left = 664
  end
end
