unit uRelEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoRelatorioPEDSCI, Data.FMTBcd,
  Data.DB, Data.SqlExpr, frxClass, frxDBSet, frxExportCSV, frxExportDOCX,
  frxExportXLSX, frxExportBaseDialog, frxExportPDF, frxDesgn, System.ImageList,
  Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.ExtCtrls, udmDadosPEDSCI;

type
  TfrRelatorio = class(TfrFormPadraoRelatorioPEDSCI)
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
    cbUF: TComboBox;
    lbFiltroEstado: TLabel;
    lbAviso: TLabel;
    rbErro: TRadioButton;
    procedure btVisualizarClick(Sender: TObject);
    procedure rgCodigoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function fVerificaCodEntre : Boolean;
    function fVerificaCodMaior : Boolean;
    function fVerificaCodMenor : Boolean;
  public
    { Public declarations }
  end;

var
  frRelatorio: TfrRelatorio;

implementation

{$R *.dfm}

procedure TfrRelatorio.btVisualizarClick(Sender: TObject);
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
       rbErro.Checked := False;
       lbAviso.Caption := '';
       // FECHA O ANTIGO QUERY QUE ESTAVA NO COMPONENTE
       SQLQueryPadrao.Close;
       // LIMPA O ANTIGO QUERY
       SQLQueryPadrao.SQL.Clear;
       // INFORMA A NOVA QUERY QUE ELE DEVE REALIZAR
       SQLQueryPadrao.SQL.Add('select emp.*, uf.BDSIGLAUF from TEMPRESA as emp inner join TUF as uf on (emp.BDCODUF = uf.BDCODUF)');

       if (rgCodigo.ItemIndex <> 0) or (cbUF.ItemIndex <> 0) then
          begin
            SQLQueryPadrao.SQL.Add('WHERE (');

            if (rgCodigo.ItemIndex <> 0) then
               begin
                 case rgCodigo.ItemIndex of
                   1: SQLQueryPadrao.SQL.Add('emp.BDCODEMP >= ' + edCodInicial.Text + 'AND emp.BDCODEMP <= ' + edCodFinal.Text);
                   2: SQLQueryPadrao.SQL.Add('emp.BDCODEMP > ' + edCodMaior.Text);
                   3: SQLQueryPadrao.SQL.Add('emp.BDCODEMP < ' + edCodMenor.Text);
                 end;

                 if (cbUF.ItemIndex <> 0) then
                    SQLQueryPadrao.SQL.Add('AND');
               end;

            if (cbUF.ItemIndex <> 0) then
               begin
                 SQLQueryPadrao.SQL.Add('emp.BDCODUF = ' + IntToStr(cbUF.ItemIndex));
               end;

            SQLQueryPadrao.SQL.Add(')');
          end;

       SQLQueryPadrao.SQL.Add('order by BDCODEMP');
       // EXECUTA A QUERY (OPEN PARA SELECT, EXEC PARA INSERCAO OU DELECAO DE DADOS)
       SQLQueryPadrao.Open;
     end;

end;

procedure TfrRelatorio.FormShow(Sender: TObject);
begin
  inherited;
  edCodInicial.Enabled  := False;
  edCodFinal.Enabled    := False;
  edCodMaior.Enabled    := False;
  edCodMenor.Enabled    := False;
end;

function TfrRelatorio.fVerificaCodEntre: Boolean;
var
  wNumeroInicial : Integer;
  wNumeroFinal : Integer;
begin
  try
    wNumeroInicial := StrToInt(edCodInicial.Text);
    wNumeroFinal := StrToInt(edCodFinal.Text);

    if (wNumeroInicial > wNumeroFinal) then
       begin
         lbAviso.Caption := 'Código inicial maior que o final';
         rbErro.Checked := True;
         edCodInicial.SetFocus;
         Result := False;
         Exit;
       end;

    dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
    dmDadosPEDSCI.tbEmpresas.Filtered := False;
    dmDadosPEDSCI.tbEmpresas.Filter := '(BDCODEMP >= ' + edCodInicial.Text + ' AND BDCODEMP <= ' + edCodFinal.Text + ')';
    dmDadosPEDSCI.tbEmpresas.Filtered := True;

    if (dmDadosPEDSCI.tbEmpresas.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Empresa não existe';
         rbErro.Checked := True;
         edCodInicial.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'Códigos inválidos';
    rbErro.Checked := True;
    edCodInicial.SetFocus;
    Result := False;
  end;
end;

function TfrRelatorio.fVerificaCodMaior: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodMaior.Text);

    dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
    dmDadosPEDSCI.tbEmpresas.Filtered := False;
    dmDadosPEDSCI.tbEmpresas.Filter := '(BDCODEMP > ' + edCodMaior.Text + ')';
    dmDadosPEDSCI.tbEmpresas.Filtered := True;

    if (dmDadosPEDSCI.tbEmpresas.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Empresa não existe';
         rbErro.Checked := True;
         edCodMaior.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'Código inválido';
    rbErro.Checked := True;
    edCodInicial.SetFocus;
    Result := False;
  end;
end;

function TfrRelatorio.fVerificaCodMenor: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodMenor.Text);

    dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
    dmDadosPEDSCI.tbEmpresas.Filtered := False;
    dmDadosPEDSCI.tbEmpresas.Filter := '(BDCODEMP < ' + edCodMenor.Text + ')';
    dmDadosPEDSCI.tbEmpresas.Filtered := True;

    if (dmDadosPEDSCI.tbEmpresas.RecordCount = 0) then
       begin
         lbAviso.Caption := 'Empresa não existe';
         rbErro.Checked := True;
         edCodMenor.SetFocus;
         Result := False;
         Exit;
       end;

    Result := True;

  except
    lbAviso.Caption := 'Código inválido';
    rbErro.Checked := True;
    edCodInicial.SetFocus;
    Result := False;
  end;
end;

procedure TfrRelatorio.rgCodigoClick(Sender: TObject);
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
