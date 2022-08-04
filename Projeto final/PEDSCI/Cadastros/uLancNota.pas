unit uLancNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCadastroPEDSCI, Vcl.ComCtrls,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin, uUtilPEDSCI, udmDadosPEDSCI,
  Data.DB, Datasnap.DBClient, uCadItens;

type
  TfrLancNota = class(TfrFormPadraoCadastroPEDSCI)
    lbCodigoNota: TLabel;
    lbData: TLabel;
    lbCliente: TLabel;
    lbCodEmpresa: TLabel;
    edCodigoNota: TEdit;
    edCodCliente: TEdit;
    edCodEmpresa: TEdit;
    dtpData: TDateTimePicker;
    lbAliquota: TLabel;
    edAliquota: TEdit;
    lbAviso: TLabel;
    btItens: TButton;
    rbErro: TRadioButton;
    procedure btOkClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pColetaDados();
    procedure pLimpaDados();
    procedure edCodigoNotaExit(Sender: TObject);
    procedure btItensClick(Sender: TObject);
  private
    { Private declarations }
    // VARIÁVEIS GLOBAIS
    wTNota : TNota;

    // FUNÇÕES
    function fVerificaCodigoNota()    : Boolean;
    function fVerificaCodigoCliente() : Boolean;
    function fVerificaCodigoEmpresa() : Boolean;
    function fVerificaAliquota()      : Boolean;
  public
    { Public declarations }
    // VARIÁVEIS GLOBAIS
    wTotal : Currency;

    //FUNÇÕES
    function setTabela                : TClientDataSet; override;
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
  // CRIA A MOSTRA UMA TELA DE CONSULTA DE NOTAS FISCAIS
  TfrConsNota.Create(edCodigoNota);
end;

procedure TfrLancNota.btExcluirClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS DADOS SÃO VÁLIDOS
  wPasse := True;
  if not(fVerificaCodigoNota)         then
     wPasse := False
  else if not(fVerificaCodigoCliente) then
     wPasse := False
  else if not(fVerificaCodigoEmpresa) then
     wPasse := False
  else if not(fVerificaAliquota)      then
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
            edCodigoNota.SetFocus;
            lbAviso.Caption := '';
            rbErro.Checked := False;
          end
       else
          ShowMessage('Falha ao deletar');
     end;

end;

procedure TfrLancNota.btItensClick(Sender: TObject);
var
  wCadItens : TfrCadItens;
  wPasse    : Boolean;
begin
  inherited;

  // CADASTRA OS VALORES DA NOTA
  btOk.Click;

  // SE NÃO OCORRERAM ERROS, UMA TELA DE CADASTRO DE ITENS DA NOTA SERÁ ABERTA
  if (lbAviso.Caption = '') then
     begin
       wCadItens := TfrCadItens.Create(nil);
       wCadItens.Show;
       wCadItens.wCodNota := StrToInt(edCodigoNota.Text);
       wCadItens.wCodEmp := StrToInt(edCodEmpresa.Text);
       wCadItens.wCodCliente := StrToInt(edCodCliente.Text);
       wCadItens.wAliq := StrToCurr(edAliquota.Text);
       wCadItens.wData := dtpData.Date;
       wCadItens.pPullBanco;

       // FECHA A TELA ATUAL
       Self.Close;
     end;
end;

procedure TfrLancNota.btOkClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS DADOS SÃO VÁLIDOS
  wPasse := True;
  if not(fVerificaCodigoNota)         then
     wPasse := False
  else if not(fVerificaCodigoCliente) then
     wPasse := False
  else if not(fVerificaCodigoEmpresa) then
     wPasse := False
  else if not(fVerificaAliquota)      then
     wPasse := False;

  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // ENVIA PARA O BANCO
       if (wTNota.fInserirNota) then
          begin
            pLimpaDados;
            lbAviso.Caption := '';
            rbErro.Checked := False;
          end
       else
          ShowMessage('Falha ao inserir dados');
     end;
end;

procedure TfrLancNota.edCodigoNotaExit(Sender: TObject);
begin
  inherited;

  // COLETA OS DADOS DA NOTA NO BANCO SE ELA JÁ EXISTIR, CASO O CÓDIGO SEJA INVÁLIDO NADA ACONTECERÁ
  try
    // COLOCA FOCO NO CAMPO DE CÓDIGO
    dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODNOTA';

    // VERIFICA SE JÁ EXISTE ALGUM DADO NO BANCO
    if dmDadosPEDSCI.tbNotas.FindKey([StrToInt(Trim(edCodigoNota.Text))]) then
       begin
         // INSERE OS DADOS DO BANCO NOS COMPONENTES
         edCodigoNota.Text  := dmDadosPEDSCI.tbNotas.FieldByName('BDCODNOTA').AsString;
         edCodCliente.Text  := dmDadosPEDSCI.tbNotas.FieldByName('BDCODCLI').AsString;
         edCodEmpresa.Text  := dmDadosPEDSCI.tbNotas.FieldByName('BDCODEMP').AsString;
         dtpData.DateTime   := dmDadosPEDSCI.tbNotas.FieldByName('BDDATAEMISSAO').AsDateTime;
         edAliquota.Text    := dmDadosPEDSCI.tbNotas.FieldByName('BDALIQICMS').AsString;
       end;
  except
  end;
end;

procedure TfrLancNota.FormShow(Sender: TObject);
begin
  // CRIA O OBJETO NOTA
  wTNota := TNota.Create;

  // LIMPA OS CAMPOS
  pLimpaDados;
  setLimpaCampos;

  // CONFIGURA O LABEL DE AVISO
  lbAviso.Font.Color := clRed;
  lbAviso.Caption := '';
  rbErro.Checked := False;
end;

function TfrLancNota.fVerificaAliquota: Boolean;
var
  wTemp : Currency;
begin
  // TENTA CONVERTER A STRING PARA CURRENCY
  try
    wTemp := StrToCurr(edAliquota.Text);
    // VERIFICA SE O VALOR NÃO É ABSURDO
    if (wTemp > 100) or (wTemp < 0) then
       begin
         lbAviso.Caption := 'Alíquota inválida';
         rbErro.Checked := True;
         edAliquota.SetFocus;
         Result := False;
         Exit;
       end
    else
       Result := True;
  except
    lbAviso.Caption := 'Alíquota inválida';
    rbErro.Checked := True;
    edAliquota.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoCliente: Boolean;
var
  wTemp : Integer;
begin
  // TENTA CONVERTER A STRING PARA INTEIRO
  try
    wTemp := StrToInt(edCodCliente.Text);
    // VERIFICA SE O CLIENTE EXISTE
    dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
    if (dmDadosPEDSCI.tbClientes.FindKey([wTemp])) then
       Result := True
    else
       begin
         lbAviso.Caption := 'Cliente não existe';
         rbErro.Checked := True;
         edCodCliente.SetFocus;
         Result := False;
       end;
  except
    lbAviso.Caption := 'Código de cliente inválido';
    rbErro.Checked := True;
    edCodCliente.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoEmpresa: Boolean;
var
  wTemp : Integer;
begin
  // TENTA CONVERTER A STRING PARA INTEIRO
  try
    wTemp := StrToInt(edCodEmpresa.Text);
    // VERIFICA SE A EMRPESA EXISTE
    dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
    if (dmDadosPEDSCI.tbEmpresas.FindKey([wTemp])) then
       Result := True
    else
       begin
         lbAviso.Caption := 'Empresa não existe';
         rbErro.Checked := True;
         edCodEmpresa.SetFocus;
         Result := False;
       end;

  except
    lbAviso.Caption := 'Código de empresa inválido';
    rbErro.Checked := True;
    edCodEmpresa.SetFocus;
    Result := False;
  end;
end;

function TfrLancNota.fVerificaCodigoNota: Boolean;
var
  wTemp : Integer;
begin
  // TENTA CONVERTER A STRING PARA INTEIRO
  try
    wTemp := StrToInt(edCodigoNota.Text);
    Result := True;
  except
    lbAviso.Caption := 'Código inválido';
    rbErro.Checked := True;
    edCodigoNota.SetFocus;
    Result := False;
  end;
end;

procedure TfrLancNota.pColetaDados;
begin
  // COLETA OS DADOS
  wTNota.wCod       := StrToInt(edCodigoNota.Text);
  wTNota.wCodCli    := StrToInt(edCodCliente.Text);
  wTNota.wCodEmp    := StrToInt(edCodEmpresa.Text);
  wTNota.wData      := dtpData.Date;
  wTNota.wAliquota  := StrToCurr(edAliquota.Text);
  wTNota.wValor     := wTotal;
end;

procedure TfrLancNota.pLimpaDados;
begin
  // LIMPA A CLASSE TNOTA
  wTNota.wCod       := 0;
  wTNota.wCodCli    := 0;
  wTNota.wCodEmp    := 0;
  wTNota.wData      := 0;
  wTNota.wAliquota  := 0;
  wTNota.wValor     := 0;
  wTotal            := 0;
end;

function TfrLancNota.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbNotas;
end;

end.
