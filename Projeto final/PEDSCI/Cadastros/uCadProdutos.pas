unit uCadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCadastroPEDSCI,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, uUtilPEDSCI,
  Data.DB, Datasnap.DBClient, udmDadosPEDSCI;

type
  TfrCadProduto = class(TfrFormPadraoCadastroPEDSCI)
    lbDescricao: TLabel;
    lbCodigo: TLabel;
    lbNCM: TLabel;
    mDescricao: TMemo;
    edCodigo: TEdit;
    edNCM: TEdit;
    lbAviso: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btConsultarClick(Sender: TObject);
    procedure pLimpaDados();
    procedure pColetaDados();
    procedure edCodigoExit(Sender: TObject);
  private
    { Private declarations }
    wTProduto : TProduto;
    function fVerificaCodigo() : Boolean;
    function fVerificaNCM() : Boolean;
    function fVerificaDescricao() : Boolean;
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frCadProduto: TfrCadProduto;

implementation

uses uConsProdutos;

{$R *.dfm}


{ TfrCadProduto }

procedure TfrCadProduto.btConsultarClick(Sender: TObject);
begin
  inherited;
  TfrConsProduto.Create(edCodigo);
end;

procedure TfrCadProduto.btExcluirClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS CAMPOS EST�O CORRETOS
  wPasse := True;
  if not(fVerificaCodigo) then
     wPasse := False
  else if not(fVerificaNCM) then
     wPasse := False
  else if not(fVerificaDescricao) then
     wPasse := False;

  // EXECUTA A A��O SE TUDO ESTIVER CERTO
  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // TENTA DELETAR OS DADOS
       if (wTProduto.fDeletarProduto) then
          begin
            ShowMessage('Deletado com sucesso');
            setLimpaCampos;
          end
       else
          ShowMessage('Falha ao deletar');
     end;

end;

procedure TfrCadProduto.btOkClick(Sender: TObject);
var
  wPasse : Boolean;
begin
  inherited;

  // VERIFICA SE OS CAMPOS EST�O CORRETOS
  wPasse := True;
  if not(fVerificaCodigo) then
     wPasse := False
  else if not(fVerificaNCM) then
     wPasse := False
  else if not(fVerificaDescricao) then
     wPasse := False;

  // TENTA INSERIR CASO OS DADOS PASSEM PELA VERIFICA��O
  if (wPasse) then
     begin
       // COLETA OS DADOS
       pColetaDados;

       // ENVIA PARA O BANCO
       if (wTProduto.fInserirProduto) then
          ShowMessage('Dados inseridos')
       else
          ShowMessage('Falha ao inserir dados');
     end;

end;

procedure TfrCadProduto.edCodigoExit(Sender: TObject);
begin
  inherited;
  try
    // COLOCA FOCO NO CAMPO DE C�DIGO
    dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';

    // VERIFICA SE J� EXISTE ALGUM DADO NO BANCO
    if dmDadosPEDSCI.tbProdutos.FindKey([StrToInt(Trim(edCodigo.Text))]) then
       begin
         // INSERE OS DADOS DO BANCO NOS COMPONENTES
         edCodigo.Text := dmDadosPEDSCI.tbProdutos.FieldByName('BDCODPROD').AsString;
         mDescricao.Text := dmDadosPEDSCI.tbProdutos.FieldByName('BDDESCRICAO').AsString;
         edNCM.Text := dmDadosPEDSCI.tbProdutos.FieldByName('BDNCM').AsString;
       end;
  except
  end;

end;

procedure TfrCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  // CRIA A VARI�VEL
  wTProduto := TProduto.Create;

  // LIMPA OS CAMPOS
  setLimpaCampos;
  pLimpaDados;

  // PREPARA O LABEL DE AVISO
  lbAviso.Font.Color := clRed;
  lbAviso.Caption := '';
end;

function TfrCadProduto.fVerificaCodigo: Boolean;
var
  temp : Integer;
begin
  try
    temp := StrToInt(edCodigo.Text);
    Result := True;
  except
    lbAviso.Caption := 'C�digo inv�lido';
    edCodigo.SetFocus;
    Result := False;
  end;
end;

function TfrCadProduto.fVerificaDescricao: Boolean;
begin
  if (mDescricao.Text = '') then
     begin
       lbAviso.Caption := 'Descri��o inv�lida';
       mDescricao.SetFocus;
       Result := False;
     end
  else if (Length(mDescricao.Text) > 500) then
     begin
       lbAviso.Caption := 'Descri��o muito grande';
       mDescricao.SetFocus;
       Result := False;
     end
  else
     Result := True;
end;

function TfrCadProduto.fVerificaNCM: Boolean;
var
  temp : Integer;
begin
  try
    temp := StrToInt(edNCM.Text);
    Result := True;
  except
    lbAviso.Caption := 'NCM inv�lido';
    edNCM.SetFocus;
    Result := False;
  end;
end;

procedure TfrCadProduto.pColetaDados;
begin
  // COLETA OS DADOS NA TELA
  wTProduto.wCod := StrToInt(edCodigo.Text);
  wTProduto.wDescricao := mDescricao.Text;
  wTProduto.wNCM := StrToInt(edNCM.Text);
end;

procedure TfrCadProduto.pLimpaDados;
begin
  // REMOVE OS DADOS DA CLASSE TPRODUTO
  wTProduto.wCod := 0;
  wTProduto.wDescricao := '';
  wTProduto.wNCM := 0;
end;

function TfrCadProduto.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbProdutos;
end;

end.
