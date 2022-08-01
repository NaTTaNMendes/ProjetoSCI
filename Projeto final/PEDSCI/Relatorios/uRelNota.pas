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
    procedure ckDataClick(Sender: TObject);
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
    function fPossuiFiltro() : Boolean;
    function fVerificaCodNota() : Boolean;
    function fVerificaCodCli() : Boolean;
    function fVerificaCodEmp() : Boolean;
    function fVerificaNomeCli() : Boolean;
    function fVerificaNomeEmp() : Boolean;
    function fVerificaData() : Boolean;
    function fAdicionaAnd(prQuantidade : Integer) : Integer;
  public
    { Public declarations }
  end;

var
  frRelatorioNota: TfrRelatorioNota;

implementation

{$R *.dfm}

procedure TfrRelatorioNota.btVisualizarClick(Sender: TObject);
var
  wPasse, wVCodNota, wVCodEmp, wVCodCli, wVNomeEmp, wVNomeCli, wVData, wI : Boolean;
  wQtd : Integer;
begin

  wPasse := True;
  if not(fVerificaCodNota) then
     wPasse := False
  else if not(fVerificaCodCli) then
     wPasse := False
  else if not(fVerificaCodEmp) then
     wPasse := False
  else if not(fVerificaNomeCli) then
     wPasse := False
  else if not(fVerificaNomeEmp) then
     wPasse := False
  else if not(fVerificaData) then
     wPasse := False;

  if (wPasse) then
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

       // COLETA OS DADOS EXISTENTES NOS CAMPOS
       pColetaDados;

       if (fPossuiFiltro) then
          begin
            wQtd := 0;
            if (wCodNota <> 0) then
               begin
                 wVCodNota := True;
                 Inc(wQtd);
               end
            else
               wVCodNota := False;
               
            if (wCodEmp <> 0) then
               begin
                 wVCodEmp := True;
                 Inc(wQtd);
               end
            else
               wVCodEmp := False;

            if (wCodCli <> 0) then
               begin
                 wVCodCli := True;
                 Inc(wQtd);
               end
            else
               wVCodCli := False;

            if (wNomeEmp <> '') then
               begin
                 wVNomeEmp := True;
                 Inc(wQtd);
               end
            else
               wVNomeEmp := False;

            if (wNomeCli <> '') then
               begin
                 wVNomeCli := True;
                 Inc(wQtd);
               end
            else
               wVNomeCli := False;

            if (ckData.Checked = True) then
               wVData := True
            else
               wVData := False;
            
            wI := True;
            SQLQueryPadrao.SQL.Add('where (');
            if (wVCodNota) then
               begin
                 SQLQueryPadrao.SQL.Add('BDCODNOTA = ' + IntToStr(wCodNota));
                 wQtd := fAdicionaAnd(wQtd);
               end;
            if (wVCodEmp) then
               begin
                 SQLQueryPadrao.SQL.Add('nota.BDCODEMP = ' + IntToStr(wCodEmp));
                 wQtd := fAdicionaAnd(wQtd);
               end;
            if (wVCodCli) then
               begin
                 SQLQueryPadrao.SQL.Add('nota.BDCODCLI = ' + IntToStr(wCodCli));
                 wQtd := fAdicionaAnd(wQtd);
               end;
            {else if (wVNomeEmp) then             PRECISO ADICIONAR O JOIN EM OUTRA TABELA
               begin
                 SQLQueryPadrao.SQL.Add('()');
               end
            else if (wVNomeCli) then
               begin
                 SQLQueryPadrao.SQL.Add('()');
               end;}
            if (wVData) then
               begin
                 SQLQueryPadrao.SQL.Add('BDDATAEMISSAO between ' + QuotedStr(Copy(DateToStr(wDataInicio), 7, 4) + '-' + Copy(DateToStr(wDataInicio), 4, 2) + '-' + Copy(DateToStr(wDataInicio), 1, 2)));
                 SQLQueryPadrao.SQL.Add(' and ');
                 SQLQueryPadrao.SQL.Add(QuotedStr(Copy(DateToStr(wDataFim), 7, 4) + '-' + Copy(DateToStr(wDataFim), 4, 2) + '-' + Copy(DateToStr(wDataFim), 1, 2)));
               end;

            SQLQueryPadrao.SQL.Add(')');

          end;
       SQLQueryPadrao.SQL.Add('order by nota.BDCODNOTA');
       ShowMessage(SQLQueryPadrao.SQL.Text);
       // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
       SQLQueryPadrao.Open;
     end;
  pLimpaDados;
end;

procedure TfrRelatorioNota.ckDataClick(Sender: TObject);
begin
  inherited;
  if (ckData.Checked = True) then
     begin
       dtpInicio.Enabled := True;
       dtpFim.Enabled := True;
     end
  else
     begin
       dtpInicio.Enabled := False;
       dtpFim.Enabled := False;
     end;
end;

function TfrRelatorioNota.fAdicionaAnd(prQuantidade : Integer): Integer;
begin
  if (prQuantidade > 1) then
     begin
       SQLQueryPadrao.SQL.Add('and');
       prQuantidade := prQuantidade - 1;
     end;

  Result := prQuantidade;

end;

procedure TfrRelatorioNota.FormShow(Sender: TObject);
begin
  inherited;
  // LIMPA TODAS AS VAR�AVEIS PRESENTES NA UNIT
  pLimpaDados;

  // DESABILITA AS DATAS E O CK
  ckData.Checked := False;
  dtpInicio.Enabled := False;
  dtpFim.Enabled := False;

  // CONFIGURA A LABEL DE AVISO
  lbAviso.Color := clRed;
  lbAviso.Caption := '';

end;

function TfrRelatorioNota.fPossuiFiltro: Boolean;
var
  wSaida : Boolean;
begin

  wSaida := False;
  // VERIFICA SE EXISTE ALGUM FILTRO NA TELA
  if (wCodNota <> 0) then
     wSaida := True
  else if (wCodEmp <> 0) then
     wSaida := True
  else if (wCodCli <> 0) then
     wSaida := True
  else if (wNomeEmp <> '') then
     wSaida := True
  else if (wNomeCli <> '') then
     wSaida := True
  else if (ckData.Checked = True) then
     wSaida := True;

  Result := wSaida; 
     
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
              exit;
            end;
       except
         lbAviso.Caption := 'C�digo de nota inv�lido';
         edCodNota.SetFocus;
         Result := False;
       end;
     end
  else
     Result := True;

end;

function TfrRelatorioNota.fVerificaData: Boolean;
begin
  if (ckData.Checked = True) then
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
     wCodNota := StrToInt(edCodNota.Text);
  if (Length(edCodEmp.Text) <> 0) then
     wCodEmp := StrToInt(edCodEmp.Text);
  if (Length(edCodCli.Text) <> 0) then
     wCodCli := StrToInt(edCodCli.Text);
  if (Length(edNomeEmp.Text) <> 0) then
     wNomeEmp := edNomeEmp.Text;
  if (Length(edNomeCli.Text) <> 0) then
     wNomeCli := edNomeCli.Text;

  if (ckData.Checked = True) then
     begin
       wDataInicio := dtpInicio.Date;
       wDataFim := dtpFim.Date;
     end;

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
