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
    procedure pColetaDados();
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
         // VERIFICA SE O CLIENTE EXISTE NA TABELA DE NOTAS
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
var
  wTemp : Integer;
begin
  if (Length(edCodEmp.Text) <> 0) then
     begin
       try
         wTemp := StrToInt(edCodEmp.Text);
         // VERIFICA SE A EMPRESA EXISTE NA TABELA DE NOTAS
         dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODEMP';
         if (dmDadosPEDSCI.tbNotas.FindKey([wTemp])) then
            Result := True
         else
            begin
              lbAviso.Caption := 'Empresa n�o possui nota';
              Result := False;
            end;
       except
         lbAviso.Caption := 'C�digo de empresa inv�lido';
         edCodEmp.SetFocus;
         Result := False;
       end;
     end;

end;

function TfrRelatorioNota.fVerificaCodNota: Boolean;
var
  wTemp : Integer;
begin
  if (Length(edCodNota.Text) <> 0) then
     begin
       try
         wTemp := StrToInt(edCodNota.Text);
         // VERIFICA SE A NOTA EXISTE NA TABELA DE NOTAS
         dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODNOTA';
         if (dmDadosPEDSCI.tbNotas.FindKey([wTemp])) then
            Result := True
         else
            begin
              lbAviso.Caption := 'Nota n�o existe';
              Result := False;
            end;
       except
         lbAviso.Caption := 'C�digo de nota inv�lido';
         edCodNota.SetFocus;
         Result := False;
       end;
     end;

end;

function TfrRelatorioNota.fVerificaData: Boolean;
begin
  if (dtpFim.DateTime < dtpInicio.DateTime) then
     begin
       lbAviso.Caption := 'Datas inv�lidas';
       dtpInicio.SetFocus;
       Result := False;
     end
  else
     Result := True;

end;

function TfrRelatorioNota.fVerificaNomeCli: Boolean;
var
  wTemp : String;
  wNumeroCli : Integer;
begin
  wTemp := edNomeCli.Text;
  wTemp := StringReplace(wTemp, ' ', EmptyStr, [rfReplaceAll]);

  if (Length(wTemp) <> 0) then
     begin
       // VERIFICA SE O NOME DO CLIENTE EXISTE NA TABELA DE NOTAS
       dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDNOMECLI';
       if (dmDadosPEDSCI.tbClientes.FindKey([edNomeCli.Text])) then
          begin
            wNumeroCli := dmDadosPEDSCI.tbClientes.FieldByName('BDCODCLI').AsInteger;

            dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODCLI';
            if (dmDadosPEDSCI.tbNotas.FindKey([wNumeroCli])) then
               begin
                 Result := True;
                 Exit;
               end
            else
               begin
                 lbAviso.Caption := 'Cliente n�o possui nota';
                 edNomeCli.SetFocus;
                 Result := False;
                 Exit;
               end;
          end
       else
          begin
            lbAviso.Caption := 'Cliente n�o existe';
            edNomeCli.SetFocus;
            Result := False;
            Exit;
          end;
     end;
end;

function TfrRelatorioNota.fVerificaNomeEmp: Boolean;
var
  wTemp : String;
  wNumeroEmp : Integer;
begin
  wTemp := edNomeEmp.Text;
  wTemp := StringReplace(wTemp, ' ', EmptyStr, [rfReplaceAll]);

  if (Length(wTemp) <> 0) then
     begin
       // VERIFICA SE O NOME DA EMPRESA EXISTE NA TABELA DE EMPRESAS
       dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDNOMEEMP';
       if (dmDadosPEDSCI.tbEmpresas.FindKey([edNomeEmp.Text])) then
          begin
            wNumeroEmp := dmDadosPEDSCI.tbEmpresas.FieldByName('BDCODEMP').AsInteger;

            dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODEMP';
            if (dmDadosPEDSCI.tbNotas.FindKey([wNumeroEmp])) then
               begin
                 Result := True;
                 Exit;
               end
            else
               begin
                 lbAviso.Caption := 'Empresa n�o possui nota';
                 edNomeEmp.SetFocus;
                 Result := False;
                 Exit;
               end;
          end
       else
          begin
            lbAviso.Caption := 'Empresa n�o existe';
            edNomeEmp.SetFocus;
            Result := False;
            Exit;
          end;
     end;
end;

procedure TfrRelatorioNota.pColetaDados;
begin
  if (Length(edCodNota.Text) <> 0) then
     begin
       wCodNota := StrToInt(edCodNota.Text);
     end;
  if (Length(edCodEmp.Text) <> 0) then
     begin
       wCodEmp := StrToInt(edCodEmp.Text);
     end;
  if (Length(edCodCli.Text) <> 0) then
     begin
       wCodCli := StrToInt(edCodCli.Text);
     end;
  if (Length(ed)) then


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
