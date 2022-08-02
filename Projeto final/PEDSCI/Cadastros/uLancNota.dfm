inherited frLancNota: TfrLancNota
  Caption = 'Lan'#231'amento de Nota Fiscal'
  ClientHeight = 257
  ClientWidth = 559
  OnShow = FormShow
  ExplicitWidth = 575
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
    Left = 283
    Top = 122
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
  object lbAliquota: TLabel [4]
    Left = 53
    Top = 120
    Width = 71
    Height = 13
    Caption = 'Al'#237'quota ICMS:'
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
    Width = 559
    TabOrder = 5
    ExplicitWidth = 559
    inherited btConsultar: TToolButton
      OnClick = btConsultarClick
    end
  end
  object edCodigoNota: TEdit [7]
    Left = 130
    Top = 54
    Width = 55
    Height = 21
    TabOrder = 0
    OnExit = edCodigoNotaExit
  end
  object edCodCliente: TEdit [8]
    Left = 283
    Top = 54
    Width = 55
    Height = 21
    TabOrder = 1
  end
  object edCodEmpresa: TEdit [9]
    Left = 442
    Top = 54
    Width = 55
    Height = 21
    TabOrder = 2
  end
  object dtpData: TDateTimePicker [10]
    Left = 320
    Top = 115
    Width = 186
    Height = 23
    Date = 44760.000000000000000000
    Time = 0.639012939813255800
    TabOrder = 4
  end
  object edAliquota: TEdit [11]
    Left = 130
    Top = 117
    Width = 127
    Height = 21
    TabOrder = 3
    TextHint = 'Informe a al'#237'quota'
    OnExit = edCodigoNotaExit
  end
  object btItens: TButton [12]
    Left = 212
    Top = 171
    Width = 115
    Height = 25
    Caption = 'Inserir itens'
    TabOrder = 6
    OnClick = btItensClick
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
