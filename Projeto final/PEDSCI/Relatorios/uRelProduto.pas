unit uRelProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoRelatorioPEDSCI, Data.FMTBcd,
  Data.DB, Data.SqlExpr, frxClass, frxDBSet, frxExportCSV, frxExportDOCX,
  frxExportXLSX, frxExportBaseDialog, frxExportPDF, frxDesgn, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.ExtCtrls, udmDadosPEDSCI;

type
  TfrRelatorioProduto = class(TfrFormPadraoRelatorioPEDSCI)
    lbCodigoEntre: TLabel;
    edCodInicial: TEdit;
    lbE: TLabel;
    edCodFinal: TEdit;
    lbCodMaior: TLabel;
    edCodMaior: TEdit;
    lbCodMenor: TLabel;
    edCodMenor: TEdit;
    lbFiltros: TLabel;
    lbNenhum: TLabel;
    Label1: TLabel;
    edValorIncial: TEdit;
    Label2: TLabel;
    edValorFinal: TEdit;
    lbValorMaior: TLabel;
    edValorMaior: TEdit;
    lbValorMenor: TLabel;
    edValorMenor: TEdit;
    Label3: TLabel;
    lbAviso: TLabel;
    rgCodigo: TRadioGroup;
    rgValor: TRadioGroup;
    lbFiltroCodigo: TLabel;
    lbFiltroValor: TLabel;
    rbErro: TRadioButton;
    procedure btVisualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCodigoClick(Sender: TObject);
    procedure rgValorClick(Sender: TObject);
  private
    { Private declarations }
    function fVerificaCodEntre : Boolean;
    function fVerificaCodMaior : Boolean;
    function fVerificaCodMenor : Boolean;
    function fVerificaVlrEntre : Boolean;
    function fVerificaVlrMaior : Boolean;
    function fVerificaVlrMenor : Boolean;
  public
    { Public declarations }
  end;

var
  frRelatorioProduto: TfrRelatorioProduto;

implementation

{$R *.dfm}

procedure TfrRelatorioProduto.btVisualizarClick(Sender: TObject);
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

  case rgValor.ItemIndex of
    1: begin
         if not(fVerificaVlrEntre) then
            wPasse := False;
       end;

    2: begin
         if not(fVerificaVlrMaior) then
            wPasse := False;
       end;

    3: begin
         if not(fVerificaVlrMenor) then
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
       SQLQueryPadrao.SQL.Add('P.BDCODPROD,');
       SQLQueryPadrao.SQL.Add('P.BDDESCRICAO,');
       SQLQueryPadrao.SQL.Add('P.BDNCM,');
       SQLQueryPadrao.SQL.Add('P.BDVALOR');
       SQLQueryPadrao.SQL.Add('FROM TCADPRODUTO AS P');

       if (rgCodigo.ItemIndex <> 0) or (rgValor.ItemIndex <> 0) then
          begin
            SQLQueryPadrao.SQL.Add('WHERE (');

            if (rgCodigo.ItemIndex <> 0) then
               begin
                 case rgCodigo.ItemIndex of
                   1: SQLQueryPadrao.SQL.Add('P.BDCODPROD >= ' + edCodInicial.Text + 'AND P.BDCODPROD <= ' + edCodFinal.Text);
                   2: SQLQueryPadrao.SQL.Add('P.BDCODPROD > ' + edCodMaior.Text);
                   3: SQLQueryPadrao.SQL.Add('P.BDCODPROD < ' + edCodMenor.Text);
                 end;

                 if (rgValor.ItemIndex <> 0) then
                    SQLQueryPadrao.SQL.Add('AND');
               end;

            if (rgValor.ItemIndex <> 0) then
               begin
                 case rgValor.ItemIndex of
                   1: SQLQueryPadrao.SQL.Add('P.BDVALOR >= ' + edValorIncial.Text + 'AND P.BDVALOR <= ' + edValorFinal.Text);
                   2: SQLQueryPadrao.SQL.Add('P.BDVALOR > ' + edValorMaior.Text);
                   3: SQLQueryPadrao.SQL.Add('P.BDVALOR > ' + edValorMenor.Text);
                 end;
               end;

            SQLQueryPadrao.SQL.Add(')');
          end;

       SQLQueryPadrao.SQL.Add('ORDER BY P.BDCODPROD');
       // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
       SQLQueryPadrao.Open;
     end;

end;

procedure TfrRelatorioProduto.FormShow(Sender: TObject);
begin
  inherited;
  edCodInicial.Enabled  := False;
  edCodFinal.Enabled    := False;
  edCodMaior.Enabled    := False;
  edCodMenor.Enabled    := False;
  edValorIncial.Enabled := False;
  edValorFinal.Enabled  := False;
  edValorMaior.Enabled  := False;
  edValorMenor.Enabled  := False;

  rbErro.Visible := False;
end;

function TfrRelatorioProduto.fVerificaCodEntre: Boolean;
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

    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDCODPROD >= ' + edCodInicial.Text + ' AND BDCODPROD <= ' + edCodFinal.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;

    if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Nota n�o existe';
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

function TfrRelatorioProduto.fVerificaCodMaior: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodMaior.Text);

    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDCODPROD > ' + edCodMaior.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;

    if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Nota n�o existe';
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

function TfrRelatorioProduto.fVerificaCodMenor: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodMenor.Text);

    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDCODPROD < ' + edCodMenor.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;

    if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Nota n�o existe';
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

function TfrRelatorioProduto.fVerificaVlrEntre: Boolean;
var
  wNumeroInicial : Currency;
  wNumeroFinal : Currency;
begin
  try
    wNumeroInicial := StrToCurr(edValorIncial.Text);
    wNumeroFinal := StrToCurr(edValorFinal.Text);

    if (wNumeroInicial > wNumeroFinal) then
       begin
         lbAviso.Caption := 'Valor inicial maior que o final';
         rbErro.Checked := True;
         edValorIncial.SetFocus;
         Result := False;
         Exit;
       end;

    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDVALOR';
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDVALOR >= ' + edValorIncial.Text + ' AND BDVALOR <= ' + edValorFinal.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;

    if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Nota n�o existe';
         rbErro.Checked := True;
         edValorIncial.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'Valores inv�lidos';
    rbErro.Checked := True;
    edValorIncial.SetFocus;
    Result := False;
  end;
end;

function TfrRelatorioProduto.fVerificaVlrMaior: Boolean;
var
  wTemp : Currency;
begin
  try
    wTemp := StrToCurr(edValorMaior.Text);

    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDVALOR';
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDVALOR > ' + edValorMaior.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;

    if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Nota n�o existe';
         rbErro.Checked := True;
         edValorMaior.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'Valor inv�lido';
    rbErro.Checked := True;
    edValorMaior.SetFocus;
    Result := False;
  end;
end;

function TfrRelatorioProduto.fVerificaVlrMenor: Boolean;
var
  wTemp : Currency;
begin
  try
    wTemp := StrToCurr(edValorMenor.Text);

    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDVALOR';
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDVALOR < ' + edValorMenor.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;

    if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Nota n�o existe';
         rbErro.Checked := True;
         edValorMenor.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'Valor inv�lido';
    rbErro.Checked := True;
    edValorMenor.SetFocus;
    Result := False;
  end;
end;

procedure TfrRelatorioProduto.rgCodigoClick(Sender: TObject);
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

procedure TfrRelatorioProduto.rgValorClick(Sender: TObject);
begin
  inherited;
  if (rgValor.ItemIndex = 0) then
     begin
       edValorIncial.Enabled := False;
       edValorFinal.Enabled   := False;
       edValorMaior.Enabled   := False;
       edValorMenor.Enabled   := False;
     end
  else if (rgValor.ItemIndex = 1) then
     begin
       edValorIncial.Enabled := True;
       edValorFinal.Enabled   := True;
       edValorMaior.Enabled   := False;
       edValorMenor.Enabled   := False;
       edValorIncial.SetFocus;
     end
  else if (rgValor.ItemIndex = 2) then
     begin
       edValorIncial.Enabled := False;
       edValorFinal.Enabled   := False;
       edValorMaior.Enabled   := True;
       edValorMenor.Enabled   := False;
       edValorMaior.SetFocus;
     end
  else if (rgValor.ItemIndex = 3) then
     begin
       edValorIncial.Enabled := False;
       edValorFinal.Enabled   := False;
       edValorMaior.Enabled   := False;
       edValorMenor.Enabled   := True;
       edValorMenor.SetFocus;
     end;
end;

end.
