inherited frCadItens: TfrCadItens
  Caption = 'Cadastro de itens'
  ClientHeight = 302
  ClientWidth = 517
  OnShow = FormShow
  ExplicitWidth = 533
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 13
  object lbProduto: TLabel [0]
    Left = 55
    Top = 64
    Width = 42
    Height = 13
    Caption = 'Produto:'
  end
  object lbQuantidade: TLabel [1]
    Left = 280
    Top = 64
    Width = 60
    Height = 13
    Caption = 'Quantidade:'
  end
  object lbAviso: TLabel [2]
    Left = 16
    Top = 288
    Width = 3
    Height = 13
    Color = clRed
    ParentColor = False
  end
  inherited tbFerramentas: TToolBar
    Width = 517
    ExplicitWidth = 517
  end
  object cbProduto: TComboBox [4]
    Left = 103
    Top = 61
    Width = 154
    Height = 21
    Style = csDropDownList
    TabOrder = 1
  end
  object edQuantidade: TEdit [5]
    Left = 360
    Top = 61
    Width = 81
    Height = 21
    TabOrder = 2
    TextHint = 'Quantidade'
  end
  object btAdicionar: TButton [6]
    Left = 152
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 3
    OnClick = btAdicionarClick
  end
  object btRemover: TButton [7]
    Left = 280
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Remover'
    TabOrder = 4
    OnClick = btRemoverClick
  end
  object lbProdutos: TListBox [8]
    Left = 31
    Top = 143
    Width = 450
    Height = 132
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Terminal'
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 5
  end
  object rbErro: TRadioButton [9]
    Left = 396
    Top = 281
    Width = 113
    Height = 17
    Caption = 'ERRO'
    TabOrder = 6
  end
end
