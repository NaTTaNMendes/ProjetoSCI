inherited frRelatorioNota: TfrRelatorioNota
  Caption = 'Relat'#243'rio de Nota'
  ClientHeight = 217
  ClientWidth = 363
  OnShow = FormShow
  ExplicitWidth = 379
  ExplicitHeight = 256
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodNota: TLabel [0]
    Left = 47
    Top = 53
    Width = 62
    Height = 13
    Caption = 'C'#243'digo nota:'
  end
  object lbCodEmp: TLabel [1]
    Left = 28
    Top = 80
    Width = 81
    Height = 13
    Caption = 'C'#243'digo empresa:'
  end
  object lbCodCliente: TLabel [2]
    Left = 38
    Top = 107
    Width = 71
    Height = 13
    Caption = 'C'#243'digo cliente:'
  end
  object lbInicio: TLabel [3]
    Left = 128
    Top = 146
    Width = 29
    Height = 13
    Caption = 'In'#237'cio:'
  end
  object lbFim: TLabel [4]
    Left = 128
    Top = 173
    Width = 20
    Height = 13
    Caption = 'Fim:'
  end
  object lbAviso: TLabel [5]
    Left = 16
    Top = 196
    Width = 33
    Height = 13
  end
  inherited tbFerramentas: TToolBar
    Width = 363
  end
  object edCodNota: TEdit [7]
    Left = 128
    Top = 50
    Width = 217
    Height = 21
    TabOrder = 1
    TextHint = 'C'#243'digo'
  end
  object edNomeEmp: TEdit [8]
    Left = 191
    Top = 77
    Width = 154
    Height = 21
    TabOrder = 2
    TextHint = 'Filtrar por empresa'
  end
  object edCodEmp: TEdit [9]
    Left = 128
    Top = 77
    Width = 57
    Height = 21
    TabOrder = 3
    TextHint = 'C'#243'digo'
  end
  object edCodCli: TEdit [10]
    Left = 128
    Top = 104
    Width = 57
    Height = 21
    TabOrder = 4
    TextHint = 'C'#243'digo'
  end
  object edNomeCli: TEdit [11]
    Left = 191
    Top = 104
    Width = 154
    Height = 21
    TabOrder = 5
    TextHint = 'Filtrar por cliente'
  end
  object ckData: TCheckBox [12]
    Left = 16
    Top = 145
    Width = 93
    Height = 17
    Caption = 'Filtrar por data'
    TabOrder = 6
  end
  object dtpFim: TDateTimePicker [13]
    Left = 176
    Top = 165
    Width = 169
    Height = 21
    Date = 44771.000000000000000000
    Time = 0.691227743052877500
    TabOrder = 7
  end
  object dtpInicio: TDateTimePicker [14]
    Left = 176
    Top = 138
    Width = 169
    Height = 21
    Date = 44771.000000000000000000
    Time = 0.691227743052877500
    TabOrder = 8
  end
  inherited imBotoes: TImageList
    Left = 640
    Top = 128
  end
  inherited imBotoesSelecionados: TImageList
    Left = 640
    Top = 184
  end
  inherited imBotoesDesabilitados: TImageList
    Left = 648
    Top = 232
  end
  inherited frxReportLayout: TfrxReport
    ScriptText.Strings = ()
    Left = 568
    Top = 40
  end
  inherited PrintDialog1: TPrintDialog
    Left = 648
    Top = 288
  end
  inherited frxDBDatasetPadrao: TfrxDBDataset
    DataSet = SQLQueryPadrao
    Left = 648
    Top = 40
  end
  inherited SQLQueryPadrao: TSQLQuery
    Left = 640
    Top = 88
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 568
    Top = 104
  end
end
