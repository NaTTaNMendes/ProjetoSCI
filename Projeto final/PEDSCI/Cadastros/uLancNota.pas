unit uLancNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCadastroPEDSCI, Vcl.ComCtrls,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin, uUtilPEDSCI, udmDadosPEDSCI,
  Data.DB, Datasnap.DBClient;

type
  TfrLancNota = class(TfrFormPadraoCadastroPEDSCI)
    lbCodigoNota: TLabel;
    lbData: TLabel;
    lbCliente: TLabel;
    lbCodEmpresa: TLabel;
    lbCodProd: TLabel;
    lbQuantidade: TLabel;
    edCodigoNota: TEdit;
    edCodCliente: TEdit;
    edCodEmpresa: TEdit;
    edCodProd: TEdit;
    dtpData: TDateTimePicker;
    edQuantidade: TEdit;
    lbVaor: TLabel;
    edValor: TEdit;
    lbAliquota: TLabel;
    edAliquota: TEdit;
    lbAviso: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pColetaDados();
    procedure pLimpaDados();
    procedure edCodigoNotaExit(Sender: TObject);
  private
    { Private declarations }
    wTNota : TNota;
    function fVerificaCodigoNota() : Boolean;
    function fVerificaCodigoCliente() : Boolean;
    function fVerificaCodigoEmpresa() : Boolean;
    function fVerificaCodigoProduto() : Boolean;
    function fVerificaValor() : Boolean;
    function fVerificaAliquota() : Boolean;
    function fVerificaQuantidade : Boolean;
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frLancNota: TfrLancNota;

implementation

uses uConsNotas;
{$R *.dfm}

{ TfrLancNota }

procedure TfrLancNota.btConsultarClick(Sender: TObject);
begin
  inherited;
  TfrConsNota.Create(edCodigoNota);
end;

procedure TfrLancNota.btExcluirClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS DADOS S�O V�LIDOS
  wPasse := True;
  if not(fVerificaCodigoNota) then
     wPasse := False
  else if not(fVerificaCodigoCliente) then
     wPasse := False
  else if not(fVerificaCodigoEmpresa) then
     wPasse := False
  else if not(fVerificaCodigoProduto) then
     wPasse := False
  else if not(fVerificaValor) then
     wPasse := False
  else if not(fVerificaAliquota) then
     wPasse := False
  else if not(fVerificaQuantidade) then
     wPasse := False;

  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // TENTA DELETAR OS DADOS
       if (wTNota.fDeletarNota) then
          begin
            ShowMessage('Deletado com sucesso');
            setLimpaCampos;
          end
       else
          ShowMessage('Falha ao deletar');
     end;

end;

procedure TfrLancNota.btOkClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS DADOS S�O V�LIDOS
  wPasse := True;
  if not(fVerificaCodigoNota) then
     wPasse := False
  else if not(fVerificaCodigoCliente) then
     wPasse := False
  else if not(fVerificaCodigoEmpresa) then
     wPasse := False
  else if not(fVerificaCodigoProduto) then
     wPasse := False
  else if not(fVerificaValor) then
     wPasse := False
  else if not(fVerificaAliquota) then
     wPasse := False
  else if not(fVerificaQuantidade) then
     wPasse := False;

  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // ENVIA PARA O BANCO
       if (wTNota.fInserirNota) then
          ShowMessage('Dados inseridos')
       else
          ShowMessage('Falha ao inserir dados');
     end;
end;

procedure TfrLancNota.edCodigoNotaExit(Sender: TObject);
begin
  inherited;

  if (fVerificaCodigoNota) then
     begin
       // COLOCA FOCO NO CAMPO DE C�DIGO
       dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODNOTA';

       // VERIFICA SE J� EXISTE ALGUM DADO NO BANCO
       if dmDadosPEDSCI.tbNotas.FindKey([StrToInt(Trim(edCodigoNota.Text))]) then
          begin
            // INSERE OS DADOS DO BANCO NOS COMPONENTES
            edCodigoNota.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDCODNOTA').AsString;
            edCodCliente.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDCODCLI').AsString;
            edCodEmpresa.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDCODEMP').AsString;
            edCodProd.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDCODPROD').AsString;
            edQuantidade.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDQTD').AsString;
            dtpData.DateTime := dmDadosPEDSCI.tbNotas.FieldByName('BDDATAEMISSAO').AsDateTime;
            edValor.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDVLRNOTA').AsString;
            edAliquota.Text := dmDadosPEDSCI.tbNotas.FieldByName('BDALIQICMS').AsString;
          end;
     end;

end;

procedure TfrLancNota.FormShow(Sender: TObject);
begin
  // CRIA A CLASSE
  wTNota := TNota.Create;

  // LIMPA OS CAMPOS
  pLimpaDados;
  setLimpaCampos;

  // CONFIGURA O LABEL DE AVISO
  lbAviso.Font.Color := clRed;
  lbAviso.Caption := '';
end;

function TfrLancNota.fVerificaAliquota: Boolean;
var
  wTemp : Currency;
begin
  try
    wTemp := StrToCurr(edAliquota.Text);
    if (wTemp > 100) or (wTemp < 0) then
       begin
         lbAviso.Caption := 'Al�quota inv�lida';
         edAliquota.SetFocus;
         Result := False;
         Exit;
       end
    else
       Result := True;
  except
    lbAviso.Caption := 'Al�quota inv�lida';
    edAliquota.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoCliente: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodCliente.Text);
    // VERIFICA SE O CLIENTE EXISTE
    dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
    if (dmDadosPEDSCI.tbClientes.FindKey([wTemp])) then
       Result := True
    else
       begin
         lbAviso.Caption := 'Cliente n�o existe';
         Result := False;
       end;
  except
    lbAviso.Caption := 'C�digo de cliente inv�lido';
    edCodCliente.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoEmpresa: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodEmpresa.Text);
    // VERIFICA SE A EMRPESA EXISTE
    dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
    if (dmDadosPEDSCI.tbEmpresas.FindKey([wTemp])) then
       Result := True
    else
       begin
         lbAviso.Caption := 'Empresa n�o existe';
         Result := False;
       end;

  except
    lbAviso.Caption := 'C�digo de empresa inv�lido';
    edCodEmpresa.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoNota: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodigoNota.Text);
    Result := True;
  except
    lbAviso.Caption := 'C�digo inv�lido';
    edCodigoNota.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoProduto: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodProd.Text);
    // VERIFICA SE O PRODUTO EXISTE
    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';
    if (dmDadosPEDSCI.tbProdutos.FindKey([wTemp])) then
       Result := True
    else
       begin
         lbAviso.Caption := 'Produto n�o existe';
         Result := False;
       end;
  except
    lbAviso.Caption := 'C�digo de produto inv�lido';
    edCodProd.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaQuantidade: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edQuantidade.Text);
    Result := True;
  except
    lbAviso.Caption := 'Quantidade inv�lida';
    edQuantidade.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaValor: Boolean;
var
  wTemp : Currency;
begin
  try
    wTemp := StrToCurr(edValor.Text);
    if (wTemp < 0) then
       begin
         lbAviso.Caption := 'Valor inv�lido';
         edValor.SetFocus;
         Result := False;
         Exit;
       end
    else
       Result := True;
  except
    lbAviso.Caption := 'Valor inv�lido';
    edValor.SetFocus;
    Result := False;
  end;
end;

procedure TfrLancNota.pColetaDados;
begin
  // COLETA OS DADOS
  wTNota.wCod := StrToInt(edCodigoNota.Text);
  wTNota.wCodCli := StrToInt(edCodCliente.Text);
  wTNota.wCodEmp := StrToInt(edCodEmpresa.Text);
  wTNota.wCodProd := StrToInt(edCodProd.Text);
  wTNota.wData := dtpData.Date;
  wTNota.wQuantidade := StrToInt(edQuantidade.Text);
  wTNota.wAliquota := StrToCurr(edAliquota.Text);
  wTNota.wValor := StrToCurr(edValor.Text);
end;

procedure TfrLancNota.pLimpaDados;
begin
  // LIMPA A CLASSE TNOTA
  wTNota.wCod := 0;
  wTNota.wCodCli := 0;
  wTNota.wCodEmp := 0;
  wTNota.wCodProd := 0;
  wTNota.wData := 0;
  wTNota.wQuantidade := 0;
  wTNota.wAliquota := 0;
  wTNota.wValor := 0;
end;

function TfrLancNota.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbNotas;
end;

end.