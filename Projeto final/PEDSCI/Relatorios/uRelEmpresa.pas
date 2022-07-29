unit uRelEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoRelatorioPEDSCI, Data.FMTBcd,
  Data.DB, Data.SqlExpr, frxClass, frxDBSet, frxExportCSV, frxExportDOCX,
  frxExportXLSX, frxExportBaseDialog, frxExportPDF, frxDesgn, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrRelatorio = class(TfrFormPadraoRelatorioPEDSCI)
    procedure btVisualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frRelatorio: TfrRelatorio;

implementation

{$R *.dfm}

procedure TfrRelatorio.btVisualizarClick(Sender: TObject);
begin
  inherited;
  // FECHA O ANTIGO QUERY QUE ESTAVA NO COMPONENTE
  SQLQueryPadrao.Close;
  // LIMPA O ANTIGO QUERY
  SQLQueryPadrao.SQL.Clear;
  // INFORMA A NOVA QUERY QUE ELE DEVE REALIZAR
  SQLQueryPadrao.SQL.Add('select emp.*, uf.BDSIGLAUF from TEMPRESA as emp inner join TUF as uf on (emp.BDCODUF = uf.BDCODUF) order by BDCODUF');
  // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
  SQLQueryPadrao.Open;
end;

end.
