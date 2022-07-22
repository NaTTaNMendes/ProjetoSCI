unit uFormPadraoCadastroPEDSCI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoPEDSCI, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Datasnap.DBClient, Vcl.StdCtrls,
  Vcl.Mask;

type
  TfrFormPadraoCadastroPEDSCI = class(TfrFormPadraoPEDSCI)
    btOk: TToolButton;
    btExcluir: TToolButton;
    btConsultar: TToolButton;
    ToolButton4: TToolButton;
    btCancelar: TToolButton;
    ToolButton2: TToolButton;
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExcluirClickPadrao(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure ConfirmarClickPadrao(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FOnExcluirEvent: TNotifyEvent;
    FOnConfirmarEvent: TNotifyEvent;
    FTabela: TClientDataSet;
  public
    { Public declarations }
    function setTabela: TClientDataSet; virtual; abstract;
  end;

var
  frFormPadraoCadastroPEDSCI: TfrFormPadraoCadastroPEDSCI;

implementation

{$R *.dfm}

uses uUtilPEDSCI;

procedure TfrFormPadraoCadastroPEDSCI.btCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrFormPadraoCadastroPEDSCI.btExcluirClick(Sender: TObject);
begin
  inherited;
  // implementar nas filhas...
  // NÃO excluir esse comentário, pois deixará de funcionar
end;

procedure TfrFormPadraoCadastroPEDSCI.btOkClick(Sender: TObject);
begin
  inherited;
  // implementar nas filhas...
  // NÃO excluir esse comentário, pois deixará de funcionar
end;

procedure TfrFormPadraoCadastroPEDSCI.ConfirmarClickPadrao(Sender: TObject);
begin
  if Assigned(FOnConfirmarEvent) then
  begin
    FOnConfirmarEvent(btOk);
    if Assigned(FTabela) then
    begin
      FTabela.ApplyUpdates(0);
      setLimpaCampos;
    end;
  end;
end;

procedure TfrFormPadraoCadastroPEDSCI.ExcluirClickPadrao(Sender: TObject);
begin
  if Assigned(FOnExcluirEvent) and TUtilPEDSCI.PodeExcluir then
  begin
    FOnExcluirEvent(btExcluir);
    if Assigned(FTabela) then
    begin
      FTabela.ApplyUpdates(0);
      setLimpaCampos;
    end;
  end;
end;

procedure TfrFormPadraoCadastroPEDSCI.FormCreate(Sender: TObject);
begin
  inherited;
  if Assigned(btExcluir.OnClick) then
  begin
    FOnExcluirEvent := btExcluir.OnClick;
    btExcluir.OnClick := ExcluirClickPadrao;
  end;

  if Assigned(btOk.OnClick) then
  begin
    FOnConfirmarEvent := btOk.OnClick;
    btOk.OnClick := ConfirmarClickPadrao;
  end;

  FTabela := setTabela;
end;

procedure TfrFormPadraoCadastroPEDSCI.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if Key = VK_NEXT then
      btOk.Click;
end;

end.
