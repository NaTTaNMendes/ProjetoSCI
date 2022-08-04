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
    edCodEmp: TEdit;
    edCodCli: TEdit;
    ckData: TCheckBox;
    dtpFim: TDateTimePicker;
    dtpInicio: TDateTimePicker;
    lbInicio: TLabel;
    lbFim: TLabel;
    lbAviso: TLabel;
    rbErro: TRadioButton;
    procedure btVisualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ckDataClick(Sender: TObject);
  private
    { Private declarations }
    // VARI�VEIS GLOBAIS
    wCodNota    : Integer;
    wCodEmp     : Integer;
    wCodCli     : Integer;
    wNomeEmp    : String;
    wNomeCli    : String;
    wDataInicio : TDate;
    wDataFim    : TDate;

    // PROCEDIMENTOS
    procedure pLimpaDados();
    procedure pColetaDados();

    // FUN��ES
    function fPossuiFiltro()                      : Boolean;
    function fVerificaCodNota()                   : Boolean;
    function fVerificaCodCli()                    : Boolean;
    function fVerificaCodEmp()                    : Boolean;
    function fVerificaData()                      : Boolean;
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
  wPasse    : Boolean;
  wVCodNota : Boolean;
  wVCodEmp  : Boolean;
  wVCodCli  : Boolean;
  wVData    : Boolean;
  wQtd      : Integer;
begin

  // VERIFICA SE OS CAMPOS EST�O CORRETOS
  wPasse := True;
  if not(fVerificaCodNota)      then
     wPasse := False
  else if not(fVerificaCodCli)  then
     wPasse := False
  else if not(fVerificaCodEmp)  then
     wPasse := False
  else if not(fVerificaData)    then
     wPasse := False;

  // CASO OS CAMPOS ESTEJAM CORRETOS
  if (wPasse) then
     begin
       inherited;
       lbAviso.Caption := '';
       rbErro.Checked := False;
       // FECHA O ANTIGO QUERY QUE ESTAVA NO COMPONENTE
       SQLQueryPadrao.Close;

       // LIMPA O ANTIGO QUERY
       SQLQueryPadrao.SQL.Clear;

       // INFORMA A NOVA QUERY QUE ELE DEVE REALIZAR
       SQLQueryPadrao.SQL.Add('SELECT');
       SQLQueryPadrao.SQL.Add('NOTA.BDCODNOTA AS CODNOTA,');
       SQLQueryPadrao.SQL.Add('NOTA.BDCODCLI AS CODCLI,');
       SQLQueryPadrao.SQL.Add('NOTA.BDCODEMP AS CODEMP,');
       SQLQueryPadrao.SQL.Add('NOTA.BDDATAEMISSAO AS DATAEMISSAO,');
       SQLQueryPadrao.SQL.Add('NOTA.BDVLRNOTA AS VLRNOTA,');
       SQLQueryPadrao.SQL.Add('NOTA.BDBCICMS AS BCIMS,');
       SQLQueryPadrao.SQL.Add('NOTA.BDALIQICMS AS ALIQICMS,');
       SQLQueryPadrao.SQL.Add('NOTA.BDVLRICMS AS VLRICMS,');
       SQLQueryPadrao.SQL.Add('EMP.BDCNPJCPF AS CNPJ,');
       SQLQueryPadrao.SQL.Add('EMP.BDNOMEEMP AS NOMEEMP,');
       SQLQueryPadrao.SQL.Add('EMP.BDTELEFONE AS TELEFONEEMP,');
       SQLQueryPadrao.SQL.Add('CLI.BDCNPJCPF AS CPF,');
       SQLQueryPadrao.SQL.Add('CLI.BDNOMECLI AS NOMECLI,');
       SQLQueryPadrao.SQL.Add('CLI.BDTELEFONE AS TELEFONECLI,');
       SQLQueryPadrao.SQL.Add('UFEMP.BDSIGLAUF AS ESTADOEMP,');
       SQLQueryPadrao.SQL.Add('UFCLI.BDSIGLAUF AS ESTADOCLI,');
       SQLQueryPadrao.SQL.Add('ITENS.BDCODITEM AS CODITEM,');
       SQLQueryPadrao.SQL.Add('ITENS.BDQUANTIDADE AS QUANTIDADE,');
       SQLQueryPadrao.SQL.Add('ITENS.BDVLRUNITARIO AS VLRUNITARIO,');
       SQLQueryPadrao.SQL.Add('ITENS.BDVLRTOTAL AS VLRTOTAL,');
       SQLQueryPadrao.SQL.Add('PROD.BDCODPROD AS CODPROD,');
       SQLQueryPadrao.SQL.Add('PROD.BDDESCRICAO AS DESCRICAO,');
       SQLQueryPadrao.SQL.Add('PROD.BDVALOR AS VLRPROD,');
       SQLQueryPadrao.SQL.Add('PROD.BDNCM AS NCM');
       SQLQueryPadrao.SQL.Add('FROM TLANCNOTA AS NOTA');
       SQLQueryPadrao.SQL.Add('INNER JOIN TEMPRESA EMP ON (EMP.BDCODEMP = NOTA.BDCODEMP)');
       SQLQueryPadrao.SQL.Add('INNER JOIN TCLIENTE CLI ON (CLI.BDCODCLI = NOTA.BDCODCLI)');
       SQLQueryPadrao.SQL.Add('INNER JOIN TUF UFEMP ON (UFEMP.BDCODUF = EMP.BDCODUF)');
       SQLQueryPadrao.SQL.Add('INNER JOIN TUF UFCLI ON (UFCLI.BDCODUF = CLI.BDCODUF)');
       SQLQueryPadrao.SQL.Add('INNER JOIN TITENSNOTA ITENS ON (ITENS.BDCODNOTA = NOTA.BDCODNOTA AND ITENS.BDCODEMP = NOTA.BDCODEMP)');
       SQLQueryPadrao.SQL.Add('INNER JOIN TCADPRODUTO PROD ON (PROD.BDCODPROD = ITENS.BDCODPROD)');

       // COLETA OS DADOS EXISTENTES NOS CAMPOS
       pColetaDados;

       // VERIFICA SE EXISTEM FILTROS NA TELA DE RELAT�RIO
       if (fPossuiFiltro) then
          begin
            // GUARDA A QUANTIDADE DE FILTROS
            wQtd := 0;

            // VERIFICA SE O C�DIGO DE NOTA TEM FILTRO
            if (wCodNota <> 0) then
               begin
                 wVCodNota := True;
                 Inc(wQtd);
               end
            else
               wVCodNota := False;
               
            // VERIFICA SE O C�DIGO DE EMPRESA TEM FILTRO
            if (wCodEmp <> 0) then
               begin
                 wVCodEmp := True;
                 Inc(wQtd);
               end
            else
               wVCodEmp := False;

            // VERIFICA SE O C�DIGO DE CLIENTE TEM FILTRO
            if (wCodCli <> 0) then
               begin
                 wVCodCli := True;
                 Inc(wQtd);
               end
            else
               wVCodCli := False;

            // VERIFICA SE AS DATAS TEM FILTRO
            if (ckData.Checked = True) then
               wVData := True
            else
               wVData := False;

            // INICIA O TEXTO DOS FILTROS
            SQLQueryPadrao.SQL.Add('WHERE (');

            // FILTRA O C�DIGO DE NOTA
            if (wVCodNota) then
               begin
                 SQLQueryPadrao.SQL.Add('NOTA.BDCODNOTA = ' + IntToStr(wCodNota));
                 wQtd := fAdicionaAnd(wQtd);
               end;

            // FILTRA O C�DIGO DE EMPRESA
            if (wVCodEmp) then
               begin
                 SQLQueryPadrao.SQL.Add('NOTA.BDCODEMP = ' + IntToStr(wCodEmp));
                 wQtd := fAdicionaAnd(wQtd);
               end;

            // FILTRA O C�DIGO DE CLIENTE
            if (wVCodCli) then
               begin
                 SQLQueryPadrao.SQL.Add('NOTA.BDCODCLI = ' + IntToStr(wCodCli));
                 wQtd := fAdicionaAnd(wQtd);
               end;

            // FILTRA AS DATAS
            if (wVData) then
               begin
                 SQLQueryPadrao.SQL.Add('NOTA.BDDATAEMISSAO BETWEEN ' + QuotedStr(Copy(DateToStr(wDataInicio), 7, 4) + '-' + Copy(DateToStr(wDataInicio), 4, 2) + '-' + Copy(DateToStr(wDataInicio), 1, 2)));
                 SQLQueryPadrao.SQL.Add(' AND ');
                 SQLQueryPadrao.SQL.Add(QuotedStr(Copy(DateToStr(wDataFim), 7, 4) + '-' + Copy(DateToStr(wDataFim), 4, 2) + '-' + Copy(DateToStr(wDataFim), 1, 2)));
               end;

            // FECHA O WHERE
            SQLQueryPadrao.SQL.Add(')');

          end;

       // ORDERNA OS ITENS DA NOTA
       SQLQueryPadrao.SQL.Add('ORDER BY ITENS.BDCODITEM');

       // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
       SQLQueryPadrao.Open;
     end;
  pLimpaDados;
end;

procedure TfrRelatorioNota.ckDataClick(Sender: TObject);
begin
  inherited;
  // L�GICA PARA ATIVAR OU DESATIVAR OS CAMPOS DE DATAS DE ACORDO COM O CHECKBOX
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
  // COLOCA OS 'AND' ENTRE CADA ELEMENTO DO WHERE
  if (prQuantidade > 1) then
     begin
       SQLQueryPadrao.SQL.Add('AND');
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
  ckData.Checked    := False;
  dtpInicio.Enabled := False;
  dtpFim.Enabled    := False;

  // CONFIGURA A LABEL DE AVISO
  lbAviso.Color   := clRed;
  lbAviso.Caption := '';
  rbErro.Checked := False;

end;

function TfrRelatorioNota.fPossuiFiltro: Boolean;
var
  wSaida : Boolean;
begin

  wSaida := False;
  // VERIFICA SE EXISTE ALGUM FILTRO NA TELA
  if (wCodNota <> 0)              then
     wSaida := True
  else if (wCodEmp <> 0)          then
     wSaida := True
  else if (wCodCli <> 0)          then
     wSaida := True
  else if (wNomeEmp <> '')        then
     wSaida := True
  else if (wNomeCli <> '')        then
     wSaida := True
  else if (ckData.Checked = True) then
     wSaida := True;

  Result := wSaida; 
     
end;

function TfrRelatorioNota.fVerificaCodCli: Boolean;
var
  wTemp : Integer;
begin
  // SE O CAMPO FOR VAZIO NADA � EXECUTADO
  if (Length(edCodCli.Text) <> 0) then
     begin
       // TENTA CONVERTER A STRING PARA INTEIRO
       try
         wTemp := StrToInt(edCodCli.Text);

         // VERIFICA SE O CLIENTE EXISTE NA TABELA DE NOTAS
         dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODCLI';
         if (dmDadosPEDSCI.tbNotas.FindKey([wTemp])) then
            Result := True
         else
            begin
              lbAviso.Caption := 'Cliente n�o possui nota';
              rbErro.Checked := True;
              Result := False;
            end;

       except
         lbAviso.Caption := 'C�digo de cliente inv�lido';
         rbErro.Checked := True;
         edCodCli.SetFocus;
         Result := False;
       end;
     end;

end;

function TfrRelatorioNota.fVerificaCodEmp: Boolean;
var
  wTemp : Integer;
begin
  // SE O CAMPO ESTIVER VAZIO NADA � EXECUTADO
  if (Length(edCodEmp.Text) <> 0) then
     begin
       // TENTA CONVERTER A STRING PARA INTEIRO
       try
         wTemp := StrToInt(edCodEmp.Text);

         // VERIFICA SE A EMPRESA EXISTE NA TABELA DE NOTAS
         dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODEMP';
         if (dmDadosPEDSCI.tbNotas.FindKey([wTemp])) then
            Result := True
         else
            begin
              lbAviso.Caption := 'Empresa n�o possui nota';
              rbErro.Checked := True;
              Result := False;
            end;
       except
         lbAviso.Caption := 'C�digo de empresa inv�lido';
         rbErro.Checked := True;
         edCodEmp.SetFocus;
         Result := False;
       end;
     end;

end;

function TfrRelatorioNota.fVerificaCodNota: Boolean;
var
  wTemp : Integer;
begin
  // SE O CAMPO ESTIVER VAZIO NADA � EXECUTADDO
  if (Length(edCodNota.Text) <> 0) then
     begin
       // TENTA CONVERTER A STRING PARA INTEIRO
       try
         wTemp := StrToInt(edCodNota.Text);

         // VERIFICA SE A NOTA EXISTE NA TABELA DE NOTAS
         dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODNOTA';
         if (dmDadosPEDSCI.tbNotas.FindKey([wTemp])) then
            Result := True
         else
            begin
              lbAviso.Caption := 'Nota n�o existe';
              rbErro.Checked := True;
              Result := False;
              exit;
            end;
       except
         lbAviso.Caption := 'C�digo de nota inv�lido';
         rbErro.Checked := True;
         edCodNota.SetFocus;
         Result := False;
       end;
     end
  else
     Result := True;

end;

function TfrRelatorioNota.fVerificaData: Boolean;
begin
  // VERIFICA SE O CHECKBOX EST� ATIVADO, CASO CONTR�RIO NADA � EXECUTADO
  if (ckData.Checked = True) then
     begin
       // VERIFICA SE A DATA FINAL N�O � MENOR QUE A INICIAL
       if (dtpFim.DateTime < dtpInicio.DateTime) then
          begin
            lbAviso.Caption := 'Datas inv�lidas';
            rbErro.Checked := True;
            dtpInicio.SetFocus;
            Result := False;
          end
       else
          Result := True;
     end;

end;

procedure TfrRelatorioNota.pColetaDados;
begin
  // COLETA DOS DADOS DOS CAMPOS DE FILTRO
  if (Length(edCodNota.Text) <> 0)    then
     wCodNota := StrToInt(edCodNota.Text);
  if (Length(edCodEmp.Text) <> 0)     then
     wCodEmp := StrToInt(edCodEmp.Text);
  if (Length(edCodCli.Text) <> 0)     then
     wCodCli := StrToInt(edCodCli.Text);

  if (ckData.Checked = True) then
     begin
       wDataInicio := dtpInicio.Date;
       wDataFim := dtpFim.Date;
     end;

end;

procedure TfrRelatorioNota.pLimpaDados;
begin
  // LIMPA OS DADOS DE TODAS AS VARI�VEIS GLOBAIS
  wCodNota    := 0;
  wCodEmp     := 0;
  wCodCli     := 0;
  wNomeEmp    := '';
  wNomeCli    := '';
  wDataInicio := Now;
  wDataFim    := Now;
end;

end.
