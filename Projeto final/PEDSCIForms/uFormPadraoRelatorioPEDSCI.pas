unit uFormPadraoRelatorioPEDSCI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoPEDSCI, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, frxDesgn, frxClass, frxExportCSV, frxExportDOCX, frxExportXLSX, frxExportPDF, Vcl.Menus, frxDBSet, Data.FMTBcd, Data.DB, Data.SqlExpr,
  frxExportBaseDialog;

type
  TfrFormPadraoRelatorioPEDSCI = class(TfrFormPadraoPEDSCI)
    btVisualizar: TToolButton;
    btExportar: TToolButton;
    ToolButton1: TToolButton;
    btEditar: TToolButton;
    frxReportLayout: TfrxReport;
    frxDesignerEditar: TfrxDesigner;
    SaveDialog1: TSaveDialog;
    frxPDFExport1: TfrxPDFExport;
    frxXLSXExport1: TfrxXLSXExport;
    frxDOCXExport1: TfrxDOCXExport;
    frxCSVExport1: TfrxCSVExport;
    btImprimir: TToolButton;
    PrintDialog1: TPrintDialog;
    frxDBDatasetPadrao: TfrxDBDataset;
    SQLQueryPadrao: TSQLQuery;
    function frxDesignerEditarSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure ShowReportClick(Sender: TObject);
    procedure btVisualizarClick(Sender: TObject);
    procedure frxReportLayoutPreview(Sender: TObject);
  private
    { Private declarations }
    FOnShowReport: TNotifyEvent;
    procedure getAjustaVisualizacao;
  public
    { Public declarations }
  end;

var
  frFormPadraoRelatorioPEDSCI: TfrFormPadraoRelatorioPEDSCI;

implementation

{$R *.dfm}

uses udmConnectionPEDSCI;

procedure TfrFormPadraoRelatorioPEDSCI.btVisualizarClick(Sender: TObject);
begin
  inherited;
  // implementar nas heranças... não apagar essa linha
end;

procedure TfrFormPadraoRelatorioPEDSCI.FormCreate(Sender: TObject);
begin
  inherited;
  if FileExists(ExtractFilePath(Application.ExeName) + 'reports\' + Self.ClassName + '.fr3') then
     frxReportLayout.LoadFromFile(ExtractFilePath(Application.ExeName) + 'reports\' + Self.ClassName + '.fr3');


  FOnShowReport := btVisualizar.OnClick;
  btVisualizar.OnClick := ShowReportClick;
  btExportar.OnClick := ShowReportClick;
  btEditar.OnClick := ShowReportClick;
  btImprimir.OnClick := ShowReportClick;
end;

function TfrFormPadraoRelatorioPEDSCI.frxDesignerEditarSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
begin
  inherited;
  ForceDirectories(ExtractFilePath(Application.ExeName) + 'reports\');
  frxReportLayout.SaveToFile(ExtractFilePath(Application.ExeName) + 'reports\' + Self.ClassName + '.fr3');
end;

procedure TfrFormPadraoRelatorioPEDSCI.frxReportLayoutPreview(Sender: TObject);
begin
  inherited;
  getAjustaVisualizacao;
end;

procedure TfrFormPadraoRelatorioPEDSCI.getAjustaVisualizacao;
var
  I: Integer;
begin
  for I := 0 to Application.MainForm.ComponentCount-1 do
  begin
    if (Application.MainForm.Components[I] is TImage) and (TImage(Application.MainForm.Components[I]).Align = alClient) then
    begin
      frxReportLayout.PreviewForm.Top := TImage(Application.MainForm.Components[I]).Top;
      frxReportLayout.PreviewForm.Left := TImage(Application.MainForm.Components[I]).Left;
      frxReportLayout.PreviewForm.Height := TImage(Application.MainForm.Components[I]).Height-8;
      frxReportLayout.PreviewForm.Width := TImage(Application.MainForm.Components[I]).Width-8;
      Break;
    end;
  end;
end;

procedure TfrFormPadraoRelatorioPEDSCI.ShowReportClick(Sender: TObject);
begin
  if Assigned(FOnShowReport) then
  begin
    FOnShowReport(Sender);

  end;

  frxDBDatasetPadrao.DataSet := SQLQueryPadrao;

  if Sender = btEditar then
     frxReportLayout.DesignReport
  else
  if Sender = btVisualizar then
  begin
    frxReportLayout.PrepareReport;
    frxReportLayout.ShowReport;
  end
  else
  if Sender = btImprimir then
  begin
    frxReportLayout.PrepareReport;
    frxReportLayout.PrintOptions.ShowDialog := False;
    if PrintDialog1.Execute then
       frxReportLayout.Print;
  end
  else
  if Sender = btExportar then
  begin
    SaveDialog1.FileName := Caption;
    if SaveDialog1.Execute then
    begin
      if MessageDlg('Deseja abrir o arquivo exportado para visualização?', mtInformation, [mbYes,mbNo], 0) = mrYes then
      begin
        frxPDFExport1.OpenAfterExport := True;
        frxXLSXExport1.OpenAfterExport := True;
        frxDOCXExport1.OpenAfterExport := True;
        frxCSVExport1.OpenAfterExport := True;
      end
      else
      begin
        frxPDFExport1.OpenAfterExport := False;
        frxXLSXExport1.OpenAfterExport := False;
        frxDOCXExport1.OpenAfterExport := False;
        frxCSVExport1.OpenAfterExport := False;
      end;
      frxPDFExport1.FileName := StringReplace(SaveDialog1.FileName, ExtractFileExt(SaveDialog1.FileName), EmptyStr, [rfIgnoreCase]) + '.pdf';
      frxXLSXExport1.FileName := StringReplace(SaveDialog1.FileName, ExtractFileExt(SaveDialog1.FileName), EmptyStr, [rfIgnoreCase]) + '.xlsx';
      frxDOCXExport1.FileName := StringReplace(SaveDialog1.FileName, ExtractFileExt(SaveDialog1.FileName), EmptyStr, [rfIgnoreCase]) + '.docx';
      frxCSVExport1.FileName := StringReplace(SaveDialog1.FileName, ExtractFileExt(SaveDialog1.FileName), EmptyStr, [rfIgnoreCase]) + '.csv';

      frxReportLayout.PrepareReport;

      case SaveDialog1.FilterIndex of
      1: frxReportLayout.Export(frxPDFExport1);
      2: frxReportLayout.Export(frxXLSXExport1);
      3: frxReportLayout.Export(frxDOCXExport1);
      4: frxReportLayout.Export(frxCSVExport1);
      end;
    end;
  end;
end;

end.
