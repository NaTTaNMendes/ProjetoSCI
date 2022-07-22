inherited frFormPadraoCadastroPEDSCI: TfrFormPadraoCadastroPEDSCI
  Caption = 'frFormPadraoCadastroPEDSCI'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbFerramentas: TToolBar
    object btOk: TToolButton
      Left = 0
      Top = 0
      Hint = 'Confirmar (PgDown)'
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
    object ToolButton2: TToolButton
      Left = 62
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object btExcluir: TToolButton
      Left = 70
      Top = 0
      Hint = 'Excluir'
      Caption = 'btExcluir'
      ImageIndex = 3
      OnClick = btExcluirClick
    end
    object ToolButton4: TToolButton
      Left = 101
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object btConsultar: TToolButton
      Left = 109
      Top = 0
      Hint = 'Consultar'
      Caption = 'btConsultar'
      ImageIndex = 2
    end
  end
end
