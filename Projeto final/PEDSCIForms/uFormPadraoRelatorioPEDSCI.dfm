inherited frFormPadraoRelatorioPEDSCI: TfrFormPadraoRelatorioPEDSCI
  Caption = 'frFormPadraoRelatorioPEDSCI'
  ClientHeight = 378
  ClientWidth = 805
  OnCreate = FormCreate
  ExplicitLeft = -45
  ExplicitWidth = 821
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbFerramentas: TToolBar
    Width = 805
    ExplicitWidth = 528
    object btVisualizar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Visualizar'
      Caption = 'btVisualizar'
      ImageIndex = 4
      OnClick = btVisualizarClick
    end
    object btImprimir: TToolButton
      Left = 31
      Top = 0
      Hint = 'Imprimir'
      Caption = 'btImprimir'
      ImageIndex = 8
      OnClick = btVisualizarClick
    end
    object btExportar: TToolButton
      Left = 62
      Top = 0
      Hint = 'Exportar'
      Caption = 'btExportar'
      ImageIndex = 5
      OnClick = btVisualizarClick
    end
    object ToolButton1: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object btEditar: TToolButton
      Left = 101
      Top = 0
      Hint = 'Editar'
      Caption = 'btEditar'
      ImageIndex = 6
      OnClick = btVisualizarClick
    end
  end
  object frxReportLayout: TfrxReport
    Version = '2022.2.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbZoom, pbFind, pbOutline]
    PreviewOptions.Maximized = False
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.OutlineWidth = 240
    PreviewOptions.ThumbnailVisible = True
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.PictureCacheInFile = True
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44718.685621851850000000
    ReportOptions.LastChange = 44718.685621851850000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnPreview = frxReportLayoutPreview
    Left = 448
    Top = 8
  end
  object frxDesignerEditar: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    OnSaveReport = frxDesignerEditarSaveReport
    Left = 736
    Top = 280
  end
  object SaveDialog1: TSaveDialog
    Filter = 
      'Adobre Acrobat Reader (PDF)|*.pdf|Microsoft Excel (XLS)|*.xls|Mi' +
      'crosoft Word (DOC)|*.doc|Separado por v'#237'rgula (CSV)|*.csv'
    Left = 736
    Top = 232
  end
  object frxPDFExport1: TfrxPDFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 736
    Top = 40
  end
  object frxXLSXExport1: TfrxXLSXExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ChunkSize = 0
    OpenAfterExport = False
    PictureType = gpPNG
    Left = 736
    Top = 88
  end
  object frxDOCXExport1: TfrxDOCXExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PictureType = gpPNG
    ExportType = dxTable
    Left = 736
    Top = 136
  end
  object frxCSVExport1: TfrxCSVExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 736
    Top = 184
  end
  object PrintDialog1: TPrintDialog
    Copies = 1
    Left = 544
    Top = 240
  end
  object frxDBDatasetPadrao: TfrxDBDataset
    UserName = 'Dados'
    CloseDataSource = False
    BCDToCurrency = False
    DataSetOptions = []
    Left = 448
    Top = 56
  end
  object SQLQueryPadrao: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 448
    Top = 104
  end
end
