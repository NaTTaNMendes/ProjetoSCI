inherited frConsCliente: TfrConsCliente
  Caption = 'Consulta Cliente'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbFerramentas: TToolBar
    List = True
    inherited btFiltrar: TToolButton
      OnClick = btFiltrarClick
    end
    object lbFiltrar: TLabel
      Left = 140
      Top = 0
      Width = 63
      Height = 30
      Alignment = taCenter
      Caption = '    Filtrar por:'
      Layout = tlCenter
    end
  end
  inherited grConsulta: TDBGrid
    OnTitleClick = grConsultaTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'BDCODCLI'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDNOMECLI'
        Title.Caption = 'Nome'
        Width = 139
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDCODUF'
        Title.Caption = 'UF'
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDCNPJCPF'
        Title.Caption = 'CPF'
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BDTELEFONE'
        Title.Caption = 'TELEFONE'
        Width = 353
        Visible = True
      end>
  end
  object cbFiltro: TComboBox [2]
    Left = 209
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
      'UF'
      'CPF')
  end
  object edFiltro: TEdit [3]
    Left = 363
    Top = 4
    Width = 182
    Height = 21
    TabOrder = 3
    TextHint = 'Insira o filtro aqui'
  end
  inherited dsConsulta: TDataSource
    DataSet = dmDadosPEDSCI.tbClientes
  end
end
