unit uCadEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCadastroPEDSCI,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Datasnap.DBClient,
  Vcl.Mask, uUtilPEDSCI;

type
  TfrCadEmpresas = class(TfrFormPadraoCadastroPEDSCI)
    lbCodigo: TLabel;
    lbCNPJ: TLabel;
    lbNome: TLabel;
    lbUF: TLabel;
    lbTelefone: TLabel;
    edCodigo: TEdit;
    edNome: TEdit;
    cbUF: TComboBox;
    lbAviso: TLabel;
    mskTelefone: TMaskEdit;
    mskCNPJ: TMaskEdit;
    rbErro: TRadioButton;
    procedure btOkClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure pLimpaDados();
    procedure pColetaDados();
    procedure FormShow(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    // VARI�VEIS GLOBAIS
    wTEmpresa                     : TEmpresa;

    // FUN��ES
    function fVerificaCodigo()    : Boolean;
    function fVerificaCNPJ()      : Boolean;
    function fVerificaNome()      : Boolean;
    function fVerificaTelefone()  : Boolean;
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frCadEmpresas: TfrCadEmpresas;

implementation

{$R *.dfm}

uses udmDadosPEDSCI, uConsEmpresas;

procedure TfrCadEmpresas.btConsultarClick(Sender: TObject);
begin
  inherited;
  // CRIA E MOSTRA A TELA DE CONSULTA DE EMPRESAS
  TfrConsEmpresas.Create(edCodigo);
end;

procedure TfrCadEmpresas.btExcluirClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS DADOS NOS CAMPOS EST�O CORRETOS
  wPasse := True;
  if not(fVerificaCodigo)        then
     wPasse := False
  else if not(fVerificaCNPJ)     then
     wPasse := False
  else if not(fVerificaNome)     then
     wPasse := False
  else if not(fVerificaTelefone) then
     wPasse := False;

  // CASO OS DADOS ESTEJAM CORRETOS
  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // TENTA DELETAR OS DADOS
       if (wTEmpresa.fDeletarEmpresa) then
          begin
            ShowMessage('Deletado com sucesso');
            setLimpaCampos;
            pLimpaDados;
            edCodigo.SetFocus;
          end
       else
          ShowMessage('Falha ao deletar');
     end;

end;

procedure TfrCadEmpresas.btOkClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS DADOS NOS CAMPOS EST�O CORRETOS
  wPasse := True;
  if not(fVerificaCodigo)        then
     wPasse := False
  else if not(fVerificaCNPJ)     then
     wPasse := False
  else if not(fVerificaNome)     then
     wPasse := False
  else if not(fVerificaTelefone) then
     wPasse := False;

  // CASO OS DADOS DOS CAMPOS ESTEJAM CORRETOS
  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // ENVIA PARA O BANCO
       if (wTEmpresa.fInserirEmpresa) then
          begin
            ShowMessage('Dados inseridos');
            lbAviso.Caption := '';
            rbErro.Checked := False;
            pLimpaDados;
            setLimpaCampos;
            edCodigo.SetFocus;
          end
       else
          ShowMessage('Falha ao inserir dados');
     end;

end;

procedure TfrCadEmpresas.edCodigoExit(Sender: TObject);
begin
  inherited;
  // VERIFICA SE JA TEM UMA EMPRESA COM ESSE CODIGO CADASTRADA NO BANCO E TENTA RECUPERAR OS DADOS
  try
    // COLOCA FOCO NO CAMPO DE C�DIGO
    dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';

    // VERIFICA SE J� EXISTE ALGUM DADO NO BANCO
    if dmDadosPEDSCI.tbEmpresas.FindKey([StrToInt(edCodigo.Text)]) then
       begin
         // INSERE OS DADOS DO BANCO NOS COMPONENTES
         edCodigo.Text    := dmDadosPEDSCI.tbEmpresas.FieldByName('BDCODEMP').AsString;
         edNome.Text      := dmDadosPEDSCI.tbEmpresas.FieldByName('BDNOMEEMP').AsString;
         mskCNPJ.Text     := dmDadosPEDSCI.tbEmpresas.FieldByName('BDCNPJCPF').AsString;
         mskTelefone.Text := dmDadosPEDSCI.tbEmpresas.FieldByName('BDTELEFONE').AsString;
         cbUF.ItemIndex   := (dmDadosPEDSCI.tbEmpresas.FieldByName('BDCODUF').AsInteger) - 1;
       end;
  except
  end;

end;

procedure TfrCadEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  // CRIA O OBJETO EMPRESA
  wTEmpresa := TEmpresa.Create();

  // LIMPA OS CAMPOS
  setLimpaCampos;
  pLimpaDados;

  // PREPARA O LABEL DE AVISO
  lbAviso.Font.Color := clRed;
  lbAviso.Caption := '';
  rbErro.Checked := False;
end;

function TfrCadEmpresas.fVerificaCNPJ: Boolean;
var
  wTemp : String;
  wVlr  : String;
  wQtd  : Integer;
  wI    : Integer;
begin

  // COLETA A QUANTIDADE DE ESPA�OS EM BRANCO NO CAMPO DE CNPJ
  wQtd := 0;
  for wI := 0 to Length(mskCNPJ.Text) do
    begin
      if (mskCNPJ.Text[wI] = ' ') then
         wQtd := wQtd + 1;
    end;

  // SE HOUVEREM ESPA�OS EM BRANCO, O CAMPO � INVALIDADO
  if (wQtd > 0) then
     begin
       lbAviso.Caption := 'CNPJ inv�lido';
       rbErro.Checked := True;
       mskCNPJ.SetFocus;
       Result := False;
       Exit;
     end;

  // COLETA OS CARACTERES NECESS�RIOS
  wTemp :=         Copy(mskCNPJ.Text,  1, 2);
  wTemp := wTemp + Copy(mskCNPJ.Text,  4, 3);
  wTemp := wTemp + Copy(mskCNPJ.Text,  8, 3);
  wTemp := wTemp + Copy(mskCNPJ.Text, 12, 4);
  wTemp := wTemp + Copy(mskCNPJ.Text, 17, 2);

  // CALCULA O VALOR DOS DOIS �LTIMOS D�GITOS E OS ADICIONA NO FINAL DO CNPJ
  wVlr := Copy(wTemp, 1,12);
  wVlr := wVlr + IntToStr(wTEmpresa.fCalculaCNPJ(wVlr));
  wVlr := wVlr + IntToStr(wTEmpresa.fCalculaCNPJ(wVlr));

  // SE O VALOR DAS DUAS CNPJS FOR IGUAL ENT�O O RESULTADO � VERDADEIRO
  if (wVlr = wTemp) then
     Result := True
  else
     begin
       lbAviso.Caption := 'CNPJ inv�lido';
       rbErro.Checked := True;
       mskCNPJ.SetFocus;
       Result := False;
     end;
end;

function TfrCadEmpresas.fVerificaCodigo: Boolean;
var
  wTemp : Integer;
begin
  // TENTA CONVERTER A STRING PARA INTEIRO
  try
    wTemp := StrToInt(edCodigo.Text);
    Result := True;
  except
    // SE DER ERRO O CAMPO � INVALIDADO
    lbAviso.Caption := 'C�digo inv�lido';
    rbErro.Checked := True;
    edCodigo.SetFocus;
    Result := False;
  end;
end;

function TfrCadEmpresas.fVerificaNome: Boolean;
var
  wTemp : String;
begin

  // CORTA OS ESPA�OS IN�TEIS
  wTemp       := edNome.Text;
  wTemp       := StringReplace(wTemp, ' ', EmptyStr, [rfReplaceAll]);
  edNome.Text := TrimLeft(edNome.Text);
  edNome.Text := TrimRight(edNome.Text);

  // VERIFICA SE O CAMPO N�O � VAZIO
  if (edNome.Text = '') or (wTemp = '') then
     begin
       lbAviso.Caption := 'Nome inv�lido';
       rbErro.Checked := True;
       edNome.SetFocus;
       Result := False;
     end
  // VERIFICA SE O CAMPO N�O � MUITO GRANDE
  else if ((Length(edNome.Text)) > 500) then
     begin
       lbAviso.Caption := 'Nome muito grande';
       rbErro.Checked := True;
       edNome.SetFocus;
       Result := False;
     end
  else
     Result := True;
end;

function TfrCadEmpresas.fVerificaTelefone: Boolean;
var
  wQtd : Integer;
  wI   : Integer;
begin

  // COLETA A QUANTIDADE DE ESPA�OS EM BRANCO NO CAMPO
  wQtd := 0;
  for wI := 0 to Length(mskTelefone.Text) do
    begin
      if (mskTelefone.Text[wI] = ' ') then
         wQtd := wQtd + 1;
    end;

  // SE HOUVEREM ESPA�OS EM BRANCO, O CAMPO � INVALIDADO
  if (wQtd > 0) then
     begin
       lbAviso.Caption := 'Telefone inv�lido';
       rbErro.Checked := True;
       mskTelefone.SetFocus;
       Result := False;
       exit;
     end
  else
     Result := True;
end;

procedure TfrCadEmpresas.pColetaDados;
begin
  // COLETA OS DADOS NA TELA
  wTEmpresa.wCod      := StrToInt(edCodigo.Text);
  wTEmpresa.wCNPJ     := mskCNPJ.Text;
  wTEmpresa.wNome     := edNome.Text;
  wTEmpresa.wCodUF    := cbUF.ItemIndex;
  wTEmpresa.wTelefone := mskTelefone.Text;
end;

procedure TfrCadEmpresas.pLimpaDados;
begin
  // LIMPA OS DADOS DO OBJETO EMPRESA
  wTEmpresa.wCod      := 0;
  wTEmpresa.wCNPJ     := '';
  wTEmpresa.wNome     := '';
  wTEmpresa.wCodUF    := 0;
  wTEmpresa.wTelefone := '';
end;

function TfrCadEmpresas.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbEmpresas;
end;

end.
