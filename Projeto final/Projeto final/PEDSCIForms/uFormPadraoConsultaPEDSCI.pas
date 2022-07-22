unit uFormPadraoConsultaPEDSCI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoPEDSCI, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrFormPadraoConsultaPEDSCI = class(TfrFormPadraoPEDSCI)
    btOk: TToolButton;
    btCancelar: TToolButton;
    ToolButton3: TToolButton;
    btExcluir: TToolButton;
    grConsulta: TDBGrid;
    dsConsulta: TDataSource;
    ToolButton1: TToolButton;
    btFiltrar: TToolButton;
    procedure btExcluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExcluirClickPadrao(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FTabela: TClientDataSet;
    FOnExcluirEvent: TNotifyEvent;
    procedure setAjustaTela;
  public
    { Public declarations }
    function setTabela: TClientDataSet; virtual; abstract;
  end;

var
  frFormPadraoConsultaPEDSCI: TfrFormPadraoConsultaPEDSCI;

implementation

{$R *.dfm}

uses uUtilPEDSCI;

procedure TfrFormPadraoConsultaPEDSCI.btCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrFormPadraoConsultaPEDSCI.btExcluirClick(Sender: TObject);
begin
  inherited;
  // implementar nas filhas...
  // NÃO excluir esse comentário, pois deixará de funcionar
end;

procedure TfrFormPadraoConsultaPEDSCI.btOkClick(Sender: TObject);
begin
  inherited;
  if (Owner is TEdit) and (grConsulta.Columns.Count > 0) then
  begin
    TEdit(Owner).Text := grConsulta.Columns[0].Field.AsString;
    Close;
  end;
end;

procedure TfrFormPadraoConsultaPEDSCI.ExcluirClickPadrao(Sender: TObject);
begin
  if Assigned(FOnExcluirEvent) and TUtilPEDSCI.PodeExcluir then
  begin
    FOnExcluirEvent(btExcluir);
    if Assigned(FTabela) then
    begin
      FTabela.Delete;
      FTabela.ApplyUpdates(0);
    end;
  end;
end;

procedure TfrFormPadraoConsultaPEDSCI.FormCreate(Sender: TObject);
begin
  inherited;
  if Assigned(btExcluir.OnClick) then
  begin
    FOnExcluirEvent := btExcluir.OnClick;
    btExcluir.OnClick := ExcluirClickPadrao;
  end;

  FTabela := setTabela;
  if Assigned(FTabela) then
     dsConsulta.DataSet := FTabela;

  setAjustaTela;
end;

procedure TfrFormPadraoConsultaPEDSCI.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
     btOk.Click
  else
  if Key = VK_DELETE then
     btExcluir.Click;
end;

procedure TfrFormPadraoConsultaPEDSCI.setAjustaTela;
var
  I: Integer;
begin
  for I := 0 to Application.MainForm.ComponentCount-1 do
  begin
    if (Application.MainForm.Components[I] is TImage) and (TImage(Application.MainForm.Components[I]).Align = alClient) then
    begin
      Self.Top := TImage(Application.MainForm.Components[I]).Top;
      Self.Left := TImage(Application.MainForm.Components[I]).Left;
      Self.Height := TImage(Application.MainForm.Components[I]).Height-8;
      Self.Width := TImage(Application.MainForm.Components[I]).Width-8;
      Break;
    end;
  end;
  btOk.Enabled := Owner is TEdit;
end;

end.
