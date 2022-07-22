unit uConsCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoConsultaPEDSCI, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ToolWin, uUtilPEDSCI, Datasnap.DBClient, Vcl.StdCtrls;

type
  TfrConsCliente = class(TfrFormPadraoConsultaPEDSCI)
    lbFiltrar: TLabel;
    cbFiltro: TComboBox;
    edFiltro: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btFiltrarClick(Sender: TObject);
    procedure grConsultaTitleClick(Column: TColumn);
  private
    { Private declarations }
    wTCliente : TCliente;
    procedure pFiltraNome();
    procedure pFiltraCodigo();
    procedure pFiltraCPF();
    procedure pFiltraUF();
    procedure pVerificaGrid();
  public
    { Public declarations }
    function setTabela: TClientDataSet; override;
  end;

var
  frConsCliente: TfrConsCliente;

implementation

uses udmDadosPEDSCI;

{$R *.dfm}

procedure TfrConsCliente.btFiltrarClick(Sender: TObject);
begin
  inherited;
  if (cbFiltro.ItemIndex = 1) then
     pFiltraCodigo
  else if (cbFiltro.ItemIndex = 2) then
     pFiltraNome
  else if (cbFiltro.ItemIndex = 3) then
     pFiltraUF
  else if (cbFiltro.ItemIndex = 4) then
     pFiltraCPF
  else
     begin
       dmDadosPEDSCI.tbClientes.Filtered := False;
       edFiltro.Text := '';
     end;
end;

procedure TfrConsCliente.FormShow(Sender: TObject);
begin
  inherited;
  // CRIA A VARI�VEL CLIENTE
  wTCliente := TCliente.Create;
end;

procedure TfrConsCliente.grConsultaTitleClick(Column: TColumn);
begin
  inherited;
  if (Column.FieldName = 'BDCODCLI') then
     dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI'
  else if (Column.FieldName = 'BDCNPJCPF') then
     dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCNPJCPF'
  else if (Column.FieldName = 'BDNOMECLI') then
     dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDNOMECLI'
  else if (Column.FieldName = 'BDCODUF') then
     dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODUF'
  else if (Column.FieldName = 'BDTELEFONE') then
     dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDTELEFONE';
end;

procedure TfrConsCliente.pFiltraCodigo;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbClientes.Filtered := False;
    dmDadosPEDSCI.tbClientes.Filter := '(BDCODCLI = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbClientes.Filtered := True;
  except
    ShowMessage('C�digo inv�lido');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsCliente.pFiltraCPF;
begin
  if (edFiltro.Text = '') then
     begin
       ShowMessage('CPF inv�lido');
       edFiltro.Text := '';
       edFiltro.SetFocus;
     end
  else
     begin
       dmDadosPEDSCI.tbClientes.Filtered := False;
       dmDadosPEDSCI.tbClientes.Filter := 'BDCNPJCPF like ' + QuotedStr('%' + edFiltro.Text + '%');
       dmDadosPEDSCI.tbClientes.Filtered := True;
     end;

  pVerificaGrid;

end;

procedure TfrConsCliente.pFiltraNome;
begin
  if (edFiltro.Text = '') then
     begin
       ShowMessage('Nome inv�lido');
       edFiltro.Text := '';
       edFiltro.SetFocus;
     end
  else
     begin
       dmDadosPEDSCI.tbClientes.Filtered := False;
       dmDadosPEDSCI.tbClientes.Filter := 'BDNOMECLI like ' + QuotedStr('%' + edFiltro.Text + '%');
       dmDadosPEDSCI.tbClientes.Filtered := True;
     end;

  pVerificaGrid;
end;

procedure TfrConsCliente.pFiltraUF;
var
  wtemp : Integer;
begin
  try
    wTemp := StrToInt(edFiltro.Text);
    dmDadosPEDSCI.tbClientes.Filtered := False;
    dmDadosPEDSCI.tbClientes.Filter := '(BDCODUF = ' + edFiltro.Text + ')';
    dmDadosPEDSCI.tbClientes.Filtered := True;
  except
    ShowMessage('UF inv�lida');
    edFiltro.Text := '';
    edFiltro.SetFocus;
  end;

  pVerificaGrid;
end;

procedure TfrConsCliente.pVerificaGrid;
begin
  if (dmDadosPEDSCI.tbClientes.RecordCount = 0) then
     begin
       ShowMessage('Nenhum dado encontrado');
       dmDadosPEDSCI.tbClientes.Filtered := False;
     end;
end;

function TfrConsCliente.setTabela: TClientDataSet;
begin
  Result := dmDadosPEDSCI.tbClientes;
end;

end.
