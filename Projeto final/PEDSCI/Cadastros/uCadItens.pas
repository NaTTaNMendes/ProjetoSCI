unit uCadItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCadastroPEDSCI,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, udmDadosPEDSCI,
  Data.DB, Datasnap.DBClient, System.Generics.Collections, uUtilPEDSCI;

type
  TfrCadItens = class(TfrFormPadraoCadastroPEDSCI)
    lbProduto: TLabel;
    cbProduto: TComboBox;
    lbQuantidade: TLabel;
    edQuantidade: TEdit;
    btAdicionar: TButton;
    btRemover: TButton;
    mMemo: TMemo;
    lbAviso: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btAdicionarClick(Sender: TObject);
    procedure btRemoverClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    { Private declarations }
    wDicionario : TDictionary<String, Integer>;
    wItens : TList<TItemNota>;
    function fVerificaQuantidade() : Boolean;
    procedure pConstruirMemo();
  public
    { Public declarations }
    wCodNota : Integer;
    wCodEmp : Integer;
    function setTabela: TClientDataSet; override;
  end;

var
  frCadItens: TfrCadItens;

implementation

{$R *.dfm}

procedure TfrCadItens.btAdicionarClick(Sender: TObject);
var
  wI : Integer;
  wQtdTemp : Integer;
  wPasse : Boolean;
  wKey : String;
begin
  inherited;

  wPasse := True;

  if not(fVerificaQuantidade) then
     wPasse := False;

  if (wPasse) then
     begin
       // CRIA UM DICION�RIO CONTENDO TODOS OS ITENS ESCOLHIDOS PELO USU�RIO
       if (wDicionario.ContainsKey(cbProduto.Text)) then
          wDicionario.Items[cbProduto.Text] := wDicionario.Items[cbProduto.Text] + StrToInt(edQuantidade.Text)
       else
          wDicionario.Add(cbProduto.Text, StrToInt(edQuantidade.Text));

       // REMOVE UM ITEM SE A QUANTIDADE DELE FOR MENOR OU IGUAL A ZERO
       for wKey in wDicionario.Keys do
         begin
           if (wDicionario.Items[wKey] <= 0) then
              wDicionario.Remove(wKey);
         end;

       pConstruirMemo;
     end;

end;

procedure TfrCadItens.btOkClick(Sender: TObject);
var
  wItem : TItemNota;
  wKey : String;
  wCodItem : Integer;
  wI : Integer;
begin
  inherited;

  // VERIFICA SE EXISTEM ITENS PARA ADICIONAR
  if (wDicionario.Count = 0) then
     lbAviso.Caption := 'Nenhum item adicionado'
  else
     lbAviso.Caption := '';

  // CRIA O OBJETO WITEM
  wItem := TItemNota.Create;

  // SETA O C�DIGO DO ITEM DENTRO DA NOTA FISCAL
  wCodItem := 0;

  // PESQUISA O PRODUTO PELO NOME NO BANCO
  dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDDESCRICAO';
  dmDadosPEDSCI.tbProdutos.First;

  // PERCORRE CADA ITEM ADICIONADO NO DICIONARIO, ADICIONA EM UMA LISTA E DEPOIS INSERE NO BANCO
  for wKey in wDicionario.Keys do
    begin

      while not(dmDadosPEDSCI.tbProdutos.Eof) do
        begin
          if (dmDadosPEDSCI.tbProdutos.FieldByName('BDDESCRICAO').AsString = wKey) then
             begin
               // COLETA OS DADOS J� PASSADOS PELA TELA PAI
               wItem.wCodNota := wCodNota;
               // INCREMENTA O C�DIGO DO ITEM DENTRO DA NOTA FISCAL
               wItem.wCodItem := wCodItem + 1;
               // COMPLETA OS DADOS NECESS�RIOS PARA A TABELA TITENSNOTA
               wItem.wCodProd := dmDadosPEDSCI.tbProdutos.FieldByName('BDCODPROD').AsInteger;
               wItem.wQuantidade := wDicionario[wKey];
               wItem.wCodEmp := wCodEmp;
               wItem.wVlrUnit := dmDadosPEDSCI.tbProdutos.FieldByName('BDVALOR').AsCurrency;
               wItem.wVlrTotal := wItem.wVlrUnit * wItem.wQuantidade;

               // ADICIONA O OBJETO COMPLETO NA LISTA
               wItens.Add(wItem);
             end;

          dmDadosPEDSCI.tbProdutos.Next;
        end;

    end;

    // INSERE CADA ITEM NO BANCO
    for wI := 0 to wItens.Count -1  do
      begin
        wItens[wI].fInserirItem;
      end;

    ShowMessage('Dados inseridos');

end;

procedure TfrCadItens.btRemoverClick(Sender: TObject);
var
  wI : Integer;
  wQtdTemp : Integer;
  wPasse : Boolean;
  wKey : String;
begin
  inherited;

  wPasse := True;

  if not(fVerificaQuantidade) then
     wPasse := False;

  if (wPasse) then
     begin
       // CRIA UM DICION�RIO CONTENDO TODOS OS ITENS ESCOLHIDOS PELO USU�RIO
       if (wDicionario.ContainsKey(cbProduto.Text)) then
          wDicionario.Items[cbProduto.Text] := wDicionario.Items[cbProduto.Text] - StrToInt(edQuantidade.Text);

       // REMOVE UM ITEM SE A QUANTIDADE DELE FOR MENOR OU IGUAL A ZERO
       for wKey in wDicionario.Keys do
         begin
           if (wDicionario.Items[wKey] <= 0) then
              wDicionario.Remove(wKey);
         end;

       pConstruirMemo;
     end;

end;

procedure TfrCadItens.FormShow(Sender: TObject);
begin
  inherited;
  // CRIA O DICION�RIO PARA O MEMO TEXT
  wDicionario := TDictionary<String, Integer>.Create;

  // CRIA A LISTA COM OS ITENS DA NOTA
  wItens := TList<TItemNota>.Create;

  try
    // COLOCA FOCO NO CAMPO DE C�DIGO
    dmDadosPEDSCI.tbProdutos.indexFieldNames := 'BDCODPROD';
    dmDadosPEDSCI.tbProdutos.First;

    while not(dmDadosPEDSCI.tbProdutos.Eof) do
      begin
        cbProduto.Items.Add(dmDadosPEDSCI.tbProdutos.FieldByName('BDDESCRICAO').AsString);
        dmDadosPEDSCI.tbProdutos.Next;
      end;

    cbProduto.ItemIndex := 0;

  except
    ShowMessage('N�o existem produtos cadastrados no banco');
    Self.Close;
  end;

end;

function TfrCadItens.fVerificaQuantidade: Boolean;
var
  wTemp : Integer;
begin
  try
    wTemp := StrToInt(edQuantidade.Text);
    lbAviso.Caption := '';
    if (wTemp <= 0) then
       raise Exception.Create('');
    Result := True;
  except
    lbAviso.Caption := 'Quantidade inv�lida';
    edQuantidade.SetFocus;
    Result := False;
  end;

end;

procedure TfrCadItens.pConstruirMemo;
var
  wI, wZeros : Integer;
  wKey, wLinha : String;
  wTotal : Currency;
begin
  mMemo.Clear;
  mMemo.Lines.Add('PRODUTOS ADICIONADOS');
  mMemo.Lines.Add('');
  mMemo.Lines.Add('');
  mMemo.Lines.Add('');
  mMemo.Lines.Add('Produto                            Quantidade               Subtotal');
  mMemo.Lines.Add('');

  for wKey in wDicionario.Keys do
    begin
      wLinha := wKey;
      wZeros := 35 - Length(wLinha);

      // COLOCA A QUANTIDADE DE ESPA�OS NECESS�RIA PARA ALINHAR O TEXTO
      for wI := 1 to wZeros do
        begin
          wLinha := wLinha + ' ';
        end;

      // INSERE A QUANTIDADE DISPON�VEL NA LINHA
      wLinha := wLinha + IntToStr(wDicionario[wKey]);

      // COLETA O PRE�O DO PRODUTO NO BANCO
      dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDDESCRICAO';
      if (dmDadosPEDSCI.tbProdutos.FindKey([wKey])) then
         wTotal := dmDadosPEDSCI.tbProdutos.FieldByName('BDVALOR').AsCurrency * wDicionario[wKey];

      wZeros := 60 - Length(wLinha);
      // COLOCA A QUANTIDADE DE ESPA�OS NECESS�RIA PARA ALINHAR O TEXTO
      for wI := 1 to wZeros do
        begin
          wLinha := wLinha + ' ';
        end;

      // INSERE O TOTAL DOS PRODUTOS NA LINHA
      wLinha := wLinha + CurrToStr(wTotal);

      // ADICIONA A LINHA NO MEMO
      mMemo.Lines.Add(wLinha);
      mMemo.Lines.Add('');
    end;


end;

function TfrCadItens.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbProdutos;
end;

end.
