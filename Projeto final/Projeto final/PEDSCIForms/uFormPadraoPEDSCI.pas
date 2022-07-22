unit uFormPadraoPEDSCI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.ToolWin, Vcl.ComCtrls, uUtilPEDSCI, Vcl.StdCtrls, Vcl.Mask;

type
  TfrFormPadraoPEDSCI = class(TForm)
    tbFerramentas: TToolBar;
    imBotoes: TImageList;
    imBotoesSelecionados: TImageList;
    imBotoesDesabilitados: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setLimpaCampos;
  end;

var
  frFormPadraoPEDSCI: TfrFormPadraoPEDSCI;

implementation

{$R *.dfm}

procedure TfrFormPadraoPEDSCI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrFormPadraoPEDSCI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
     Close;
end;

procedure TfrFormPadraoPEDSCI.setLimpaCampos;
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount-1 do
  begin
    if Self.Components[I] is TCustomEdit then
       TCustomEdit(Self.Components[I]).Clear
    else
    if Self.Components[I] is TCustomComboBox then
       TCustomComboBox(Self.Components[I]).ItemIndex := 0
    else
    if Self.Components[I] is TCheckBox then
       TCheckBox(Self.Components[I]).Checked := False
    else
    if Self.Components[I] is TDateTimePicker then
       TDateTimePicker(Self.Components[I]).Date := Now;
  end;
end;

end.
