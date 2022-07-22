unit uConsNotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoConsultaPEDSCI, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ToolWin, udmDadosPEDSCI, Datasnap.DBClient, Vcl.StdCtrls;

type
  TfrConsNota = class(TfrFormPadraoConsultaPEDSCI)
    lbFiltrar: TLabel;
    cbFiltro: TComboBox;
    edFiltro: TEdit;
    dtpFiltro: TDateTimePicker;
    procedure cbFiltroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFiltrarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pFiltraNota();
    procedure pFiltraCliente();
    procedure pFiltraEmpresa();
    procedure pFiltraProduto();
    procedure pFiltraData();
    procedure pFiltraQuantidade();
    procedure pFiltraTotal();
    procedure pFiltraBCICMS();
    procedure pFiltraAliquota();
    procedure pFiltraValorICMS();
    procedure pVerificaGrid();
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frConsNota: TfrConsNota;

implementation

{$R *.dfm}

{ TfrConsNota }

procedure TfrConsNota.btFiltrarClick(Sender: TObject);
begin
  inherited;
  case cbFiltro.ItemIndex of
    1: pFiltraNota;
    2: pFiltraCliente;
    3: pFiltraEmpresa;
    4: pFiltraProduto;
    5: pFiltraData;
    6: pFiltraQuantidade;
    7: pFiltraTotal;
    8: pFiltraBCICMS;
    9: pFiltraAliquota;
    10: pFiltraValorICMS;
  end;
  if (cbFiltro.ItemIndex = 0) then
     begin
       dmDadosPEDSCI.tbNotas.Filtered := False;
       edFiltro.Text := '';
     end;
end;

procedure TfrConsNota.cbFiltroChange(Sender: TObject);
begin
  inherited;
  if (cbFiltro.ItemIndex = 5) then
     begin
       edFiltro.Text := '';
       edFiltro.Enabled := False;
       dtpFiltro.Enabled := True;
     end
  else
     begin
       edFiltro.Enabled := True;
       dtpFiltro.Enabled := False;
     end;

end;

procedure TfrConsNota.FormShow(Sender: TObject);
begin
  inherited;
  // DESABILITA A ESCOLHA DE DATA NO INICIO
  dtpFiltro.Enabled := False;
end;

procedure TfrConsNota.pFiltraAliquota;
var
  wtemp : Currency;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDALIQICMS = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Al�quota inv�lida');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraBCICMS;
var
  wtemp : Currency;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDBCICMS = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('ICMS inv�lido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraCliente;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDCODCLI = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Cliente inv�lido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraData;
begin
  dmDadosPEDSCI.tbNotas.Filtered := False;
  dmDadosPEDSCI.tbNotas.Filter := 'BDDATAEMISSAO = ' + QuotedStr(DateToStr(dtpFiltro.Date));
  dmDadosPEDSCI.tbNotas.Filtered := True;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraEmpresa;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDCODEMP = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Empresa inv�lida');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraNota;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDCODNOTA = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Nota inv�lida');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraProduto;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDCODPROD = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Produto inv�lido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraQuantidade;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDQTD = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Quantidade inv�lida');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraTotal;
var
  wtemp : Currency;
begin
  try
    wTemp := StrToCurr(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDVLRNOTA = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Total inv�lido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pFiltraValorICMS;
var
  wtemp : Currency;
begin
  try
    wTemp := StrToCurr(edFiltro.Text);
    dmDadosPEDSCI.tbNotas.Filtered := False;
    dmDadosPEDSCI.tbNotas.Filter := '(BDVLRICMS = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbNotas.Filtered := True;
  except
    ShowMessage('Valor inv�lido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsNota.pVerificaGrid;
begin
  if (dmDadosPEDSCI.tbNotas.RecordCount = 0) then
     begin
       ShowMessage('Nenhum dado encontrado');
       dmDadosPEDSCI.tbNotas.Filtered := False;
     end;
end;

function TfrConsNota.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbNotas;
end;

end.
