inherited frCadProduto: TfrCadProduto
  Caption = 'Cadastro Produto'
  ClientHeight = 239
  ClientWidth = 358
  OnShow = FormShow
  ExplicitWidth = 374
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 13
  object lbDescricao: TLabel [0]
    Left = 24
    Top = 104
    Width = 50
    Height = 13
    Caption = 'Descri'#231#227'o:'
  end
  object lbCodigo: TLabel [1]
    Left = 37
    Top = 59
    Width = 37
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lbNCM: TLabel [2]
    Left = 144
    Top = 59
    Width = 26
    Height = 13
    Caption = 'NCM:'
  end
  object lbAviso: TLabel [3]
    Left = 8
    Top = 218
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
    Width = 358
    TabOrder = 2
    ExplicitWidth = 358
    inherited btConsultar: TToolButton
      OnClick = btConsultarClick
    end
  end
  object mDescricao: TMemo [5]
    Left = 88
    Top = 101
    Width = 225
    Height = 89
    TabOrder = 3
  end
  object edCodigo: TEdit [6]
    Left = 88
    Top = 56
    Width = 33
    Height = 21
    TabOrder = 0
    OnExit = edCodigoExit
  end
  object edNCM: TEdit [7]
    Left = 192
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
  end
  inherited imBotoes: TImageList
    Left = 320
    Top = 88
  end
  inherited imBotoesSelecionados: TImageList
    Left = 320
    Top = 136
  end
  inherited imBotoesDesabilitados: TImageList
    Left = 320
    Top = 184
  end
end
