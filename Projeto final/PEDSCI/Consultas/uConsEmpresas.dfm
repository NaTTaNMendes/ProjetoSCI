inherited frConsEmpresas: TfrConsEmpresas
  Caption = 'Consulta de empresas'
  ClientWidth = 632
  OnShow = FormShow
  ExplicitWidth = 648
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbFerramentas: TToolBar
    Width = 632
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
    Width = 632
    OnTitleClick = grConsultaTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'BDCODEMP'
        Title.Caption = 'C'#243'digo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDNOMEEMP'
        Title.Caption = 'Nome'
        Width = 119
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDCNPJCPF'
        Title.Caption = 'CNPJ'
        Width = 207
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDCODUF'
        Title.Caption = 'UF'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDTELEFONE'
        Title.Caption = 'Telefone'
        Width = 214
        Visible = True
      end>
  end
  object cbFiltro: TComboBox [2]
    Left = 215
    Top = 5
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'TODOS'
    Items.Strings = (
      'TODOS'
      'C'#211'DIGO'
      'NOME'
      'CNPJ'
      'UF'
      'TELEFONE')
  end
  object edFiltro: TEdit [3]
    Left = 374
    Top = 5
    Width = 182
    Height = 21
    TabOrder = 3
    TextHint = 'Insira o filtro aqui'
  end
  inherited dsConsulta: TDataSource
    DataSet = dmDadosPEDSCI.tbEmpresas
  end
end
