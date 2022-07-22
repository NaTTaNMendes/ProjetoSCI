unit uRelEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoRelatorioPEDSCI, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Data.FMTBcd, Data.DB, Data.SqlExpr, frxClass, frxDBSet, frxExportCSV, frxExportDOCX, frxExportXLSX, frxExportPDF, frxDesgn;

type
  TfrRelEmpresas = class(TfrFormPadraoRelatorioPEDSCI)
    procedure btVisualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frRelEmpresas: TfrRelEmpresas;

implementation

{$R *.dfm}

procedure TfrRelEmpresas.btVisualizarClick(Sender: TObject);
begin
  inherited;
  SQLQueryPadrao.Close;
  SQLQueryPadrao.SQL.Clear;
  SQLQueryPadrao.SQL.Add('select * from tempresas');
  SQLQueryPadrao.Open;
end;

end.
