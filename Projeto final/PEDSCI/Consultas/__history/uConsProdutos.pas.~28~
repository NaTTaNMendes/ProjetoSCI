unit uConsProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoConsultaPEDSCI, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ToolWin, udmDadosPEDSCI, Datasnap.DBClient, Vcl.StdCtrls;

type
  TfrConsProduto = class(TfrFormPadraoConsultaPEDSCI)
    edFiltro: TEdit;
    cbFiltro: TComboBox;
    lbFiltrar: TLabel;
    procedure btFiltrarClick(Sender: TObject);
    procedure grConsultaTitleClick(Column: TColumn);
  private
    { Private declarations }
    procedure pFiltraCodigo();
    procedure pFiltraNCM();
    procedure pFiltraDescricao();
    procedure pVerificaGrid();
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frConsProduto: TfrConsProduto;

implementation

{$R *.dfm}

{ TfrConsProduto }

procedure TfrConsProduto.btFiltrarClick(Sender: TObject);
begin
  inherited;
  if (cbFiltro.ItemIndex = 1) then
     pFiltraCodigo
  else if (cbFiltro.ItemIndex = 2) then
     pFiltraNCM
  else if (cbFiltro.ItemIndex = 3) then
     pFiltraDescricao
  else
     begin
       dmDadosPEDSCI.tbProdutos.Filtered := False;
       edFiltro.Text := '';
     end;
end;

procedure TfrConsProduto.grConsultaTitleClick(Column: TColumn);
begin
  inherited;
  if (Column.FieldName = 'BDCODPROD') then
     dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD'
  else if (Column.FieldName = 'BDDESCRICAO') then
     dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDDESCRICAO'
  else if (Column.FieldName = 'BDNCM') then
     dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDNCM';
end;

procedure TfrConsProduto.pFiltraCodigo;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDCODPROD = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;
  except
    ShowMessage('Código inválido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsProduto.pFiltraDescricao;
begin
  if (edFiltro.Text = '') then
     begin
       ShowMessage('Descrição inválida');
       edFiltro.Text := '';
       edFiltro.SetFocus;
     end
  else
     begin
       dmDadosPEDSCI.tbProdutos.Filtered := False;
       dmDadosPEDSCI.tbProdutos.Filter := 'BDESCRICAO like ' + QuotedStr('%' + edFiltro.Text + '%');
       dmDadosPEDSCI.tbProdutos.Filtered := True;
     end;

  pVerificaGrid;
end;

procedure TfrConsProduto.pFiltraNCM;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbProdutos.Filtered := False;
    dmDadosPEDSCI.tbProdutos.Filter := '(BDNCM = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbProdutos.Filtered := True;
  except
    ShowMessage('NCM inválido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsProduto.pVerificaGrid;
begin
  if (dmDadosPEDSCI.tbProdutos.RecordCount = 0) then
     begin
       ShowMessage('Nenhum dado encontrado');
       dmDadosPEDSCI.tbProdutos.Filtered := False;
     end;
end;

function TfrConsProduto.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbProdutos;
end;

end.
