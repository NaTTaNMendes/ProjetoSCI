inherited frRelatorio: TfrRelatorio
  Caption = 'Relat'#243'rio de empresa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited frxReportLayout: TfrxReport
    ScriptText.Strings = ()
  end
  inherited frxDBDatasetPadrao: TfrxDBDataset
    DataSet = SQLQueryPadrao
  end
end
