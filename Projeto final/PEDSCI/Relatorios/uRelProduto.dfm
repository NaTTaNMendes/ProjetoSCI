inherited frRelatorioProduto: TfrRelatorioProduto
  Caption = 'Relat'#243'rio de Produtos'
  ClientHeight = 276
  ClientWidth = 502
  OnShow = FormShow
  ExplicitWidth = 518
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigoEntre: TLabel [0]
    Left = 51
    Top = 140
    Width = 71
    Height = 13
    Caption = 'C'#243'digos entre:'
  end
  object lbE: TLabel [1]
    Left = 173
    Top = 140
    Width = 6
    Height = 13
    Caption = 'e'
  end
  object lbCodMaior: TLabel [2]
    Left = 51
    Top = 172
    Width = 87
    Height = 13
    Caption = 'C'#243'digo maior que:'
  end
  object lbCodMenor: TLabel [3]
    Left = 51
    Top = 208
    Width = 94
    Height = 13
    Caption = 'C'#243'digo menor que: '
  end
  object lbFiltros: TLabel [4]
    Left = 219
    Top = 48
    Width = 42
    Height = 13
    Caption = 'FILTROS'
  end
  object lbNenhum: TLabel [5]
    Left = 51
    Top = 112
    Width = 39
    Height = 13
    Caption = 'Nenhum'
  end
  object Label1: TLabel [6]
    Left = 301
    Top = 140
    Width = 68
    Height = 13
    Caption = 'Valores entre:'
  end
  object Label2: TLabel [7]
    Left = 427
    Top = 140
    Width = 6
    Height = 13
    Caption = 'e'
  end
  object lbValorMaior: TLabel [8]
    Left = 301
    Top = 172
    Width = 78
    Height = 13
    Caption = 'Valor maior que:'
  end
  object lbValorMenor: TLabel [9]
    Left = 301
    Top = 208
    Width = 85
    Height = 13
    Caption = 'Valor menor que: '
  end
  object Label3: TLabel [10]
    Left = 301
    Top = 109
    Width = 39
    Height = 13
    Caption = 'Nenhum'
  end
  object lbAviso: TLabel [11]
    Left = 30
    Top = 248
    Width = 3
    Height = 13
  end
  object lbFiltroCodigo: TLabel [12]
    Left = 16
    Top = 70
    Width = 68
    Height = 13
    Caption = 'Filtrar C'#243'digo:'
  end
  object lbFiltroValor: TLabel [13]
    Left = 261
    Top = 70
    Width = 59
    Height = 13
    Caption = 'Filtrar Valor:'
  end
  inherited tbFerramentas: TToolBar
    Width = 502
    ExplicitWidth = 502
  end
  object edCodInicial: TEdit [15]
    Left = 123
    Top = 137
    Width = 44
    Height = 21
    TabOrder = 1
  end
  object edCodFinal: TEdit [16]
    Left = 185
    Top = 137
    Width = 44
    Height = 21
    TabOrder = 2
  end
  object edCodMaior: TEdit [17]
    Left = 144
    Top = 169
    Width = 44
    Height = 21
    TabOrder = 3
  end
  object edCodMenor: TEdit [18]
    Left = 144
    Top = 205
    Width = 44
    Height = 21
    TabOrder = 4
  end
  object edValorIncial: TEdit [19]
    Left = 377
    Top = 137
    Width = 44
    Height = 21
    TabOrder = 5
  end
  object edValorFinal: TEdit [20]
    Left = 439
    Top = 137
    Width = 44
    Height = 21
    TabOrder = 6
  end
  object edValorMaior: TEdit [21]
    Left = 394
    Top = 169
    Width = 44
    Height = 21
    TabOrder = 7
  end
  object edValorMenor: TEdit [22]
    Left = 394
    Top = 205
    Width = 44
    Height = 21
    TabOrder = 8
  end
  object rgCodigo: TRadioGroup [23]
    Left = 16
    Top = 89
    Width = 29
    Height = 140
    Color = clBtnFace
    Ctl3D = True
    ItemIndex = 0
    Items.Strings = (
      ' '
      ' '
      ' '
      ' ')
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 9
    OnClick = rgCodigoClick
  end
  object rgValor: TRadioGroup [24]
    Left = 261
    Top = 89
    Width = 26
    Height = 140
    ItemIndex = 0
    Items.Strings = (
      ' '
      ' '
      ' '
      ' ')
    TabOrder = 10
    OnClick = rgValorClick
  end
  object rbErro: TRadioButton [25]
    Left = 381
    Top = 251
    Width = 113
    Height = 17
    Caption = 'ERRO'
    TabOrder = 11
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
  inherited frxReportLayout: TfrxReport
    ScriptText.Strings = ()
    Left = 584
    Top = 48
  end
  inherited PrintDialog1: TPrintDialog
    Left = 648
    Top = 232
  end
  inherited frxDBDatasetPadrao: TfrxDBDataset
    Left = 584
    Top = 96
  end
  inherited SQLQueryPadrao: TSQLQuery
    Left = 584
    Top = 144
  end
end
