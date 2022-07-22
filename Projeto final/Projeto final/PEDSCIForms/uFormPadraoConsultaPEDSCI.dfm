inherited frFormPadraoConsultaPEDSCI: TfrFormPadraoConsultaPEDSCI
  Caption = 'frFormPadraoConsultaPEDSCI'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbFerramentas: TToolBar
    object btOk: TToolButton
      Left = 0
      Top = 0
      Hint = 'Confirmar (Enter)'
      Caption = 'btOk'
      ImageIndex = 0
      OnClick = btOkClick
    end
    object btCancelar: TToolButton
      Left = 31
      Top = 0
      Hint = 'Cancelar (Esc)'
      Caption = 'btCancelar'
      ImageIndex = 1
      OnClick = btCancelarClick
    end
    object ToolButton3: TToolButton
      Left = 62
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btFiltrar: TToolButton
      Left = 70
      Top = 0
      Caption = 'btFiltrar'
      ImageIndex = 7
    end
    object ToolButton1: TToolButton
      Left = 101
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btExcluir: TToolButton
      Left = 109
      Top = 0
      Hint = 'Excluir (Delete)'
      Caption = 'btExcluir'
      ImageIndex = 3
      OnClick = btExcluirClick
    end
  end
  object grConsulta: TDBGrid [1]
    Left = 0
    Top = 30
    Width = 635
    Height = 269
    Align = alClient
    DataSource = dsConsulta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsConsulta: TDataSource
    Left = 576
    Top = 184
  end
end
