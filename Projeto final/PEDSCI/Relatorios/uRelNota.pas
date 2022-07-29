unit uRelNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoRelatorioPEDSCI, Data.FMTBcd,
  Data.DB, Data.SqlExpr, frxClass, frxDBSet, frxExportCSV, frxExportDOCX,
  frxExportXLSX, frxExportBaseDialog, frxExportPDF, frxDesgn, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, frxBarcode, Vcl.StdCtrls, udmDadosPEDSCI;

type
  TfrRelatorioNota = class(TfrFormPadraoRelatorioPEDSCI)
    frxBarCodeObject1: TfrxBarCodeObject;
    lbCodNota: TLabel;
    lbCodEmp: TLabel;
    lbCodCliente: TLabel;
    edCodNota: TEdit;
    edNomeEmp: TEdit;
    edCodEmp: TEdit;
    edCodCli: TEdit;
    edNomeCli: TEdit;
    ckData: TCheckBox;
    dtpFim: TDateTimePicker;
    dtpInicio: TDateTimePicker;
    lbInicio: TLabel;
    lbFim: TLabel;
    lbAviso: TLabel;
    procedure btVisualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    wCodNota : Integer;
    wCodEmp : Integer;
    wCodCli : Integer;
    wNomeEmp : String;
    wNomeCli : String;
    wDataInicio : TDate;
    wDataFim : TDate;
    procedure pLimpaDados();
    function fVerificaCodNota() : Boolean;
    function fVerificaCodCli() : Boolean;
    function fVerificaCodEmp() : Boolean;
    function fVerificaNomeCli() : Boolean;
    function fVerificaNomeEmp() : Boolean;
    function fVerificaData() : Boolean;
  public
    { Public declarations }
  end;

var
  frRelatorioNota: TfrRelatorioNota;

implementation

{$R *.dfm}

procedure TfrRelatorioNota.btVisualizarClick(Sender: TObject);
begin
  inherited;
  // FECHA O ANTIGO QUERY QUE ESTAVA NO COMPONENTE
  SQLQueryPadrao.Close;
  // LIMPA O ANTIGO QUERY
  SQLQueryPadrao.SQL.Clear;
  // INFORMA A NOVA QUERY QUE ELE DEVE REALIZAR
  SQLQueryPadrao.SQL.Add('select nota.*, emp.BDNOMEEMP, emp.BDCNPJCPF, emp.BDTELEFONE, cli.BDNOMECLI, cli.BDCNPJCPF, cli.BDTELEFONE, UFcli.BDSIGLAUF as ufcli, UFemp.BDSIGLAUF as ufemp, prod.BDDESCRICAO, prod.BDNCM from TLANCNOTA as nota');
  SQLQueryPadrao.SQL.Add('inner join TEMPRESA as emp on (emp.BDCODEMP = nota.BDCODEMP)');
  SQLQueryPadrao.SQL.Add('inner join TCLIENTE as cli on (cli.BDCODCLI = nota.BDCODCLI)');
  SQLQueryPadrao.SQL.Add('inner join TCADPRODUTO as prod on (prod.BDCODPROD = nota.BDCODPROD)');
  SQLQueryPadrao.SQL.Add('inner join TUF as UFcli on (UFcli.BDCODUF = cli.BDCODUF)');
  SQLQueryPadrao.SQL.Add('inner join TUF as UFemp on (UFemp.BDCODUF = emp.BDCODUF)');
  SQLQueryPadrao.SQL.Add('order by nota.BDCODNOTA');
  // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
  SQLQueryPadrao.Open;
end;

procedure TfrRelatorioNota.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaDados;

  // DESABILITA AS DATAS E O CK
  ckData.Checked := False;
  dtpInicio.Enabled := False;
  dtpFim.Enabled := False;

  // CONFIGURA A LABEL DE AVISO
  lbAviso.Color := clRed;
  lbAviso.Caption := '';

end;

function TfrRelatorioNota.fVerificaCodCli: Boolean;
var
  wTemp : Integer;
begin
  if (Length(edCodCli.Text) <> 0) then
     begin
       try
         wTemp := StrToInt(edCodCli.Text);
         // VERIFICA SE O PRODUTO EXISTE
         dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODCLI';
         if (dmDadosPEDSCI.tbNotas.FindKey([wTemp])) then
            Result := True
         else
            begin
              lbAviso.Caption := 'Cliente n�o possui nota';
              Result := False;
            end;

       except
         lbAviso.Caption := 'C�digo de cliente inv�lido';
         edCodCli.SetFocus;
         Result := False;
       end;
     end;

end;

function TfrRelatorioNota.fVerificaCodEmp: Boolean;
begin

end;

function TfrRelatorioNota.fVerificaCodNota: Boolean;
begin

end;

function TfrRelatorioNota.fVerificaData: Boolean;
begin

end;

function TfrRelatorioNota.fVerificaNomeCli: Boolean;
begin

end;

function TfrRelatorioNota.fVerificaNomeEmp: Boolean;
begin

end;

procedure TfrRelatorioNota.pLimpaDados;
begin
  wCodNota := 0;
  wCodEmp := 0;
  wCodCli := 0;
  wNomeEmp := '';
  wNomeCli := '';
  wDataInicio := Now;
  wDataFim := Now;
end;

end.
