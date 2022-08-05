inherited frConsNota: TfrConsNota
  Caption = 'Consultar Nota'
  ClientWidth = 697
  OnShow = FormShow
  ExplicitWidth = 713
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbFerramentas: TToolBar
    Width = 697
    ExplicitWidth = 697
    inherited btFiltrar: TToolButton
      OnClick = btFiltrarClick
    end
    object lbFiltrar: TLabel
      Left = 140
      Top = 0
      Width = 69
      Height = 30
      Caption = '      Filtrar por:'
      Layout = tlCenter
    end
  end
  inherited grConsulta: TDBGrid
    Width = 697
    Columns = <
      item
        Expanded = False
        FieldName = 'BDCODNOTA'
        Title.Caption = 'Nota'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDCODCLI'
        Title.Caption = 'Cliente'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDCODEMP'
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDDATAEMISSAO'
        Title.Caption = 'Data emiss'#227'o'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDVLRNOTA'
        Title.Caption = 'Total'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDBCICMS'
        Title.Caption = 'BCICMS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDALIQICMS'
        Title.Caption = 'Al'#237'quota ICMS'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDVLRICMS'
        Title.Caption = 'Valor ICMS'
        Visible = True
      end>
  end
  object cbFiltro: TComboBox [2]
    Left = 215
    Top = 3
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'TODOS'
    OnChange = cbFiltroChange
    Items.Strings = (
      'TODOS'
      'NOTA'
      'CLIENTE'
      'EMPRESA'
      'DATA'
      'TOTAL'
      'BCICMS'
      'AL'#205'QUOTA ICMS'
      'VALOR ICMS')
  end
  object edFiltro: TEdit [3]
    Left = 366
    Top = 3
    Width = 147
    Height = 21
    TabOrder = 3
    TextHint = 'Insira o filtro aqui'
  end
  object dtpFiltro: TDateTimePicker [4]
    Left = 519
    Top = 4
    Width = 170
    Height = 20
    Date = 44764.000000000000000000
    Time = 0.440129074071592200
    TabOrder = 4
  end
  inherited imBotoes: TImageList
    Left = 648
    Top = 80
  end
  inherited imBotoesSelecionados: TImageList
    Left = 648
    Top = 136
  end
  inherited imBotoesDesabilitados: TImageList
    Left = 648
    Top = 192
  end
  inherited dsConsulta: TDataSource
    DataSet = dmDadosPEDSCI.tbNotas
    Left = 656
    Top = 248
  end
end
