unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCadastroPEDSCI,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, uUtilPEDSCI,
  Data.DB, Datasnap.DBClient, Vcl.Mask;

type
  TfrCadCliente = class(TfrFormPadraoCadastroPEDSCI)
    lbCodigo: TLabel;
    lbCPF: TLabel;
    lbNome: TLabel;
    lbUF: TLabel;
    lbTelefone: TLabel;
    edCodigo: TEdit;
    edCPF: TEdit;
    edNome: TEdit;
    cbUF: TComboBox;
    lbAviso: TLabel;
    mskTelefone: TMaskEdit;
    procedure btOkClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure pLimpaDados();
    procedure pColetaDados();
    procedure FormShow(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
  private
    { Private declarations }
    wTCliente : TCliente;
    function fVerificaCodigo() : Boolean;
    function fVerificaCPF() : Boolean;
    function fVerificaNome() : Boolean;
    function fVerificaTelefone() : Boolean;
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frCadCliente: TfrCadCliente;

implementation

uses udmDadosPEDSCI, uConsCliente;

{$R *.dfm}

procedure TfrCadCliente.btConsultarClick(Sender: TObject);
begin
  inherited;
  TfrConsCliente.Create(edCodigo);
end;

procedure TfrCadCliente.btExcluirClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // Verifica os campos
  wPasse := True;
  if not(fVerificaCodigo) then
     wPasse := False
  else if not(fVerificaCPF) then
     wPasse := False
  else if not(fVerificaNome) then
     wPasse := False
  else if not(fVerificaTelefone) then
     wPasse := False;

  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // TENTA DELETAR OS DADOS
       if (wTCliente.fDeletarCliente) then
          begin
            ShowMessage('Deletado com sucesso');
            setLimpaCampos;
          end
       else
          ShowMessage('Falha ao deletar');
     end;

end;

procedure TfrCadCliente.btOkClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;
  // Verifica os campos
  wPasse := True;
  if not(fVerificaCodigo) then
     wPasse := False
  else if not(fVerificaCPF) then
     wPasse := False
  else if not(fVerificaNome) then
     wPasse := False
  else if not(fVerificaTelefone) then
     wPasse := False;

  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // ENVIA PARA O BANCO
       if (wTCliente.fInserirCliente) then
          begin
            ShowMessage('Dados inseridos');
            lbAviso.Caption := '';
            pLimpaDados;
            setLimpaCampos;
          end
       else
          ShowMessage('Falha ao inserir dados');
     end;

end;

procedure TfrCadCliente.edCodigoExit(Sender: TObject);
begin
  inherited;
  // COLOCA FOCO NO CAMPO DE C�DIGO
  dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';

  // VERIFICA SE J� EXISTE ALGUM DADO NO BANCO
  if dmDadosPEDSCI.tbClientes.FindKey([StrToInt(edCodigo.Text)]) then
  begin
    // INSERE OS DADOS DO BANCO NOS COMPONENTES
    edCodigo.Text := dmDadosPEDSCI.tbClientes.FieldByName('BDCODCLI').AsString;
    edNome.Text := dmDadosPEDSCI.tbClientes.FieldByName('BDNOMECLI').AsString;
    edCPF.Text := dmDadosPEDSCI.tbClientes.FieldByName('BDCNPJCPF').AsString;
    mskTelefone.Text := dmDadosPEDSCI.tbClientes.FieldByName('BDTELEFONE').AsString;
    cbUF.ItemIndex := (dmDadosPEDSCI.tbClientes.FieldByName('BDCODUF').AsInteger) - 1;
  end;
end;

procedure TfrCadCliente.FormShow(Sender: TObject);
begin
  inherited;
  // CRIA A VARI�VEL
  wTCliente := TCliente.Create;

  // LIMPA OS CAMPOS
  setLimpaCampos;
  pLimpaDados;

  // PREPARA O LABEL DE AVISO
  lbAviso.Font.Color := clRed;
  lbAviso.Caption := '';
end;

function TfrCadCliente.fVerificaCodigo: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edCodigo.Text);
    Result := True;
  except
    lbAviso.Caption := 'C�digo inv�lido';
    edCodigo.SetFocus;
    Result := False;
  end;
end;

function TfrCadCliente.fVerificaCPF: Boolean;
var
  wReduzido, wPasse : Boolean;
  wTemp, wValorCalculado : String;
begin
  wReduzido := True;
  if (Length(edCPF.Text) <> 11) and (Length(edCPF.Text) <> 14) then
     begin
       lbAviso.Caption := 'CPF inv�lido';
       edCPF.SetFocus;
       Result := False;
       Exit;
     end
  else if (Length(edCPF.Text) = 14) then
     begin
        wPasse := False;
        wReduzido := False;
        if (Copy(edCPF.Text, 4, 1) <> '.') then
           wPasse := True
        else if (Copy(edCPF.Text, 8, 1) <> '.') then
           wPasse := True
        else if (Copy(edCPF.Text, 12, 1) <> '-') then
           wPasse := True;
        if (wPasse) then
           begin
             lbAviso.Caption := 'CPF inv�lido';
             edCPF.SetFocus;
             Result := False;
             Exit;
           end;
     end;

  if not(wReduzido) then
     begin
       wTemp := Copy(edCPF.Text, 1, 3);
       wTemp := wTemp + Copy(edCPF.Text, 5, 3);
       wTemp := wTemp + Copy(edCPF.Text, 9, 3);
       wTemp := wTemp + Copy(edCPF.Text, 13, 2);
       edCPF.Text := wTemp;
     end;

  wValorCalculado := Copy(edCPF.Text, 1,9);
  wValorCalculado := wValorCalculado + IntToStr(wTCliente.fCalculaCPF(wValorCalculado));
  wValorCalculado := wValorCalculado + IntToStr(wTCliente.fCalculaCPF(wValorCalculado));
  if (wValorCalculado = edCPF.Text) then
     Result := True
  else
     begin
       lbAviso.Caption := 'CPF inv�lido';
       edCPF.SetFocus;
       Result := False;
       Exit;
     end;

end;

function TfrCadCliente.fVerificaNome: Boolean;
var
  wTemp : String;
begin

  // VERIFICA SE O NOME N�O � APENAS ESPA�OS EM BRANCO E CORTA OS ESPA�OS IN�TEIS
  wTemp := edNome.Text;
  wTemp := StringReplace(wTemp, ' ', EmptyStr, [rfReplaceAll]);
  edNome.Text := TrimLeft(edNome.Text);
  edNome.Text := TrimRight(edNome.Text);

  if (edNome.Text = '') or (wTemp = '') then
     begin
       lbAviso.Caption := 'Nome inv�lido';
       edNome.SetFocus;
       Result := False;
     end
  else if ((Length(edNome.Text)) > 200) then
     begin
       lbAviso.Caption := 'Nome muito grande';
       edNome.SetFocus;
       Result := False;
     end
  else
     Result := True;
end;

function TfrCadCliente.fVerificaTelefone: Boolean;
var
  wQTD, wI : Integer;
begin

  wQTD := 0;
  for wI := 0 to Length(mskTelefone.Text) do
    begin
      if (mskTelefone.Text[wI] = ' ') then
         wQTD := wQTD + 1;
    end;

  if (wQTD > 0) then
     begin
       lbAviso.Caption := 'Telefone inv�lido';
       mskTelefone.SetFocus;
       Result := False;
       exit;
     end
  else
     Result := True;
end;

procedure TfrCadCliente.pColetaDados;
begin
  // COLETA TODOS OS CAMPOS DA TELA
  wTCliente.wCod := StrToInt(edCodigo.Text);
  wTCliente.wCPF := edCPF.Text;
  wTCliente.wNome := edNome.Text;
  wTCliente.wCodUF := cbUF.ItemIndex;
  wTCliente.wTelefone := mskTelefone.Text;
end;

procedure TfrCadCliente.pLimpaDados;
begin
  // LIMPA TODOS OS DADOS DA CLASSE CLIENTE
  wTCliente.wCod := 0;
  wTCliente.wCPF := '';
  wTCliente.wNome := '';
  wTCliente.wCodUF := 0;
  wTCliente.wTelefone := '';
end;

function TfrCadCliente.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbClientes;
end;
end.