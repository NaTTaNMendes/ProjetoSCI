unit uRelCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoRelatorioPEDSCI, Data.FMTBcd,
  Data.DB, Data.SqlExpr, frxClass, frxDBSet, frxExportCSV, frxExportDOCX,
  frxExportXLSX, frxExportBaseDialog, frxExportPDF, frxDesgn, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.ExtCtrls, udmDadosPEDSCI;

type
  TfrRelatorioCliente = class(TfrFormPadraoRelatorioPEDSCI)
    lbCodigoEntre: TLabel;
    edCodInicial: TEdit;
    lbE: TLabel;
    edCodFinal: TEdit;
    lbCodMaior: TLabel;
    edCodMaior: TEdit;
    lbCodMenor: TLabel;
    edCodMenor: TEdit;
    lbNenhum: TLabel;
    rgCodigo: TRadioGroup;
    lbFiltroCodigo: TLabel;
    lbFiltros: TLabel;
    lbAviso: TLabel;
    cbUF: TComboBox;
    lbFiltroEstado: TLabel;
    rbErro: TRadioButton;
    procedure btVisualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCodigoClick(Sender: TObject);
  private
    { Private declarations }
    function fVerificaCodEntre : Boolean;
    function fVerificaCodMaior : Boolean;
    function fVerificaCodMenor : Boolean;
  public
    { Public declarations }
  end;

var
  frRelatorioCliente: TfrRelatorioCliente;

implementation

{$R *.dfm}

procedure TfrRelatorioCliente.btVisualizarClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  wPasse := True;

  case rgCodigo.ItemIndex of
    1: begin
         if not(fVerificaCodEntre) then
            wPasse := False;
       end;

    2: begin
         if not(fVerificaCodMaior) then
            wPasse := False;
       end;

    3: begin
         if not(fVerificaCodMenor) then
            wPasse := False;
       end;
  end;

  if (wPasse) then
     begin
       lbAviso.Caption := '';
       rbErro.Checked := False;

       // FECHA O ANTIGO QUERY QUE ESTAVA NO COMPONENTE
       SQLQueryPadrao.Close;

       // LIMPA O ANTIGO QUERY
       SQLQueryPadrao.SQL.Clear;

       // INFORMA A NOVA QUERY QUE ELE DEVE REALIZAR
       SQLQueryPadrao.SQL.Add('SELECT');
       SQLQueryPadrao.SQL.Add('C.BDCODCLI,');
       SQLQueryPadrao.SQL.Add('C.BDCNPJCPF,');
       SQLQueryPadrao.SQL.Add('C.BDNOMECLI,');
       SQLQueryPadrao.SQL.Add('C.BDTELEFONE,');
       SQLQueryPadrao.SQL.Add('UF.BDSIGLAUF');
       SQLQueryPadrao.SQL.Add('FROM TCLIENTE AS C');
       SQLQueryPadrao.SQL.Add('INNER JOIN TUF UF ON (UF.BDCODUF = C.BDCODUF)');

       if (rgCodigo.ItemIndex <> 0) or (cbUF.ItemIndex <> 0) then
          begin
            SQLQueryPadrao.SQL.Add('WHERE (');

            if (rgCodigo.ItemIndex <> 0) then
               begin
                 case rgCodigo.ItemIndex of
                   1: SQLQueryPadrao.SQL.Add('C.BDCODCLI >= ' + edCodInicial.Text + 'AND C.BDCODCLI <= ' + edCodFinal.Text);
                   2: SQLQueryPadrao.SQL.Add('C.BDCODCLI > ' + edCodMaior.Text);
                   3: SQLQueryPadrao.SQL.Add('C.BDCODCLI < ' + edCodMenor.Text);
                 end;

                 if (cbUF.ItemIndex <> 0) then
                    SQLQueryPadrao.SQL.Add('AND');
               end;

            if (cbUF.ItemIndex <> 0) then
               begin
                 SQLQueryPadrao.SQL.Add('C.BDCODUF = ' + IntToStr(cbUF.ItemIndex));
               end;

            SQLQueryPadrao.SQL.Add(')');
          end;

       SQLQueryPadrao.SQL.Add('ORDER BY C.BDCODCLI');
       // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
       SQLQueryPadrao.Open;
     end;
end;

procedure TfrRelatorioCliente.FormShow(Sender: TObject);
begin
  inherited;
  edCodInicial.Enabled  := False;
  edCodFinal.Enabled    := False;
  edCodMaior.Enabled    := False;
  edCodMenor.Enabled    := False;

  rbErro.Visible := False;
end;

function TfrRelatorioCliente.fVerificaCodEntre: Boolean;
var
  wNumeroInicial : Integer;
  wNumeroFinal : Integer;
begin
  try
    wNumeroInicial := StrToInt(edCodInicial.Text);
    wNumeroFinal := StrToInt(edCodFinal.Text);

    if (wNumeroInicial > wNumeroFinal) then
       begin
         lbAviso.Caption := 'C�digo inicial maior que o final';
         rbErro.Checked := True;
         edCodInicial.SetFocus;
         Result := False;
         Exit;
       end;

    dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
    dmDadosPEDSCI.tbClientes.Filtered := False;
    dmDadosPEDSCI.tbClientes.Filter := '(BDCODCLI >= ' + edCodInicial.Text + ' AND BDCODCLI <= ' + edCodFinal.Text + ')';
    dmDadosPEDSCI.tbClientes.Filtered := True;

    if (dmDadosPEDSCI.tbClientes.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Cliente n�o existe';
         rbErro.Checked := True;
         edCodInicial.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'C�digos inv�lidos';
    rbErro.Checked := True;
    edCodInicial.SetFocus;
    Result := False;
  end;
end;

function TfrRelatorioCliente.fVerificaCodMaior: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodMaior.Text);

    dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
    dmDadosPEDSCI.tbClientes.Filtered := False;
    dmDadosPEDSCI.tbClientes.Filter := '(BDCODCLI > ' + edCodMaior.Text + ')';
    dmDadosPEDSCI.tbClientes.Filtered := True;

    if (dmDadosPEDSCI.tbClientes.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Cliente n�o existe';
         rbErro.Checked := True;
         edCodMaior.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'C�digo inv�lido';
    rbErro.Checked := True;
    edCodMaior.SetFocus;
    Result := False;
  end;
end;

function TfrRelatorioCliente.fVerificaCodMenor: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodMenor.Text);

    dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
    dmDadosPEDSCI.tbClientes.Filtered := False;
    dmDadosPEDSCI.tbClientes.Filter := '(BDCODCLI < ' + edCodMenor.Text + ')';
    dmDadosPEDSCI.tbClientes.Filtered := True;

    if (dmDadosPEDSCI.tbClientes.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Cliente n�o existe';
         rbErro.Checked := True;
         edCodMenor.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'C�digo inv�lido';
    rbErro.Checked := True;
    edCodMenor.SetFocus;
    Result := False;
  end;
end;

procedure TfrRelatorioCliente.rgCodigoClick(Sender: TObject);
begin
  inherited;
  if (rgCodigo.ItemIndex = 0) then
     begin
       edCodInicial.Enabled := False;
       edCodFinal.Enabled   := False;
       edCodMaior.Enabled   := False;
       edCodMenor.Enabled   := False;
     end
  else if (rgCodigo.ItemIndex = 1) then
     begin
       edCodInicial.Enabled := True;
       edCodFinal.Enabled   := True;
       edCodMaior.Enabled   := False;
       edCodMenor.Enabled   := False;
       edCodInicial.SetFocus;
     end
  else if (rgCodigo.ItemIndex = 2) then
     begin
       edCodInicial.Enabled := False;
       edCodFinal.Enabled   := False;
       edCodMaior.Enabled   := True;
       edCodMenor.Enabled   := False;
       edCodMaior.SetFocus;
     end
  else if (rgCodigo.ItemIndex = 3) then
     begin
       edCodInicial.Enabled := False;
       edCodFinal.Enabled   := False;
       edCodMaior.Enabled   := False;
       edCodMenor.Enabled   := True;
       edCodMenor.SetFocus;
     end;
end;

end.
