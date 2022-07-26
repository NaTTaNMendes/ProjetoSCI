unit uPEDSCI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, uCadEmpresas, uConsEmpresas, uConsCliente, uCadCliente,
  uCadProdutos, uConsProdutos, uConsNotas, uLancNota, Vcl.Imaging.pngimage, uRelEmpresa, uRelNota, uRelCliente, uRelProduto;

type
  TfrPEDSCI = class(TForm)
    mmPED: TMainMenu;
    mmAjuda: TMenuItem;
    mmSobre: TMenuItem;
    mmCadastros: TMenuItem;
    mmConsultas: TMenuItem;
    mmCadEmpresas: TMenuItem;
    imFundo: TImage;
    mmConsEmpresas: TMenuItem;
    mmCadCliente: TMenuItem;
    mmConsCliente: TMenuItem;
    mmLancamentos: TMenuItem;
    mmLancNota: TMenuItem;
    mmProduto: TMenuItem;
    mProduto: TMenuItem;
    mmNotas: TMenuItem;
    mmRelatorios: TMenuItem;
    mmRelatorioEmpresa: TMenuItem;
    mmRelatorioNotas: TMenuItem;
    mmRelatorioClientes: TMenuItem;
    mmRelatorioProduto: TMenuItem;
    procedure mmSobreClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mmCadEmpresasClick(Sender: TObject);
    procedure mmConsEmpresasClick(Sender: TObject);
    procedure mmCadClienteClick(Sender: TObject);
    procedure mmConsClienteClick(Sender: TObject);
    procedure mmProdutoClick(Sender: TObject);
    procedure mProdutoClick(Sender: TObject);
    procedure mmNotasClick(Sender: TObject);
    procedure mmLancNotaClick(Sender: TObject);
    procedure mmRelatorioEmpresaClick(Sender: TObject);
    procedure mmRelatorioNotasClick(Sender: TObject);
    procedure mmRelatorioClientesClick(Sender: TObject);
    procedure mmRelatorioProdutoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPEDSCI: TfrPEDSCI;

implementation

{$R *.dfm}

procedure TfrPEDSCI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (MessageDlg('Deseja realmente sair do "' + Application.Title + '"?', mtInformation, [mbYes,mbNo], 0) = mrYes) then
     Application.Terminate;
end;

procedure TfrPEDSCI.mmCadEmpresasClick(Sender: TObject);
var
  wCadEmpresa : TfrCadEmpresas;
begin
  // INSTANCIA E MOSTRA A TELA DE CADASTRO DE EMPRESAS
  wCadEmpresa := TfrCadEmpresas.Create(Self);
  wCadEmpresa.Show;

end;

procedure TfrPEDSCI.mmCadClienteClick(Sender: TObject);
var
  wCadCliente : TfrCadCliente;
begin
  // INSTANCIA E MOSTRA A TELA DE CADASTRO DE CLIENTES
  wCadCliente := TfrCadCliente.Create(Self);
  wCadCliente.Show;

end;

procedure TfrPEDSCI.mmConsClienteClick(Sender: TObject);
var
  wConsCliente : TfrConsCliente;
begin
  // INSTANCIA E MOSTRA A TELA DE CONSULTA DE CLIENTES
  wConsCliente := TfrConsCliente.Create(Self);
  wConsCliente.Show;

end;

procedure TfrPEDSCI.mmConsEmpresasClick(Sender: TObject);
var
  wConsEmpresa : TfrConsEmpresas;
begin
  // INSTANCIA E MOSTRA A TELA DE CONSULTA DE EMPRESAS
  wConsEmpresa := TfrConsEmpresas.Create(Self);
  wConsEmpresa.Show;

end;

procedure TfrPEDSCI.mmLancNotaClick(Sender: TObject);
var
  wLancNota : TfrLancNota;
begin
  // INSTANCIA E MOSTRA A TELA DE LAN�AMENTO DE NOTAS FISCAIS
  wLancNota := TfrLancNota.Create(Self);
  wLancNota.Show;

end;

procedure TfrPEDSCI.mmNotasClick(Sender: TObject);
var
  wConsNota : TfrConsNota;
begin
  // INSTANCIA E MOSTRA A TELA DE CONSULTA DE NOTAS FISCAIS
  wConsNota := TfrConsNota.Create(Self);
  wConsNota.Show;

end;

procedure TfrPEDSCI.mmProdutoClick(Sender: TObject);
var
  wCadProduto : TfrCadProduto;
begin
  // INSTANCIA E MOSTRA A TELA DE CADASTRO DE PRODUTO
  wCadProduto := TfrCadProduto.Create(Self);
  wCadProduto.Show;

end;

procedure TfrPEDSCI.mmRelatorioClientesClick(Sender: TObject);
var
  wRelatorio : TfrRelatorioCliente;
begin
  // INSTANCIA E MOSTRA A TELA DE RELAT�RIO DE CLIENTE
  wRelatorio := TfrRelatorioCliente.Create(Self);
  wRelatorio.Show;
end;

procedure TfrPEDSCI.mmRelatorioEmpresaClick(Sender: TObject);
var
  wRelatorio : TfrRelatorio;
begin
  // INSTANCIA E MOSTRA A TELA DE RELAT�RIO DE EMPRESAS
  wRelatorio := TfrRelatorio.Create(Self);
  wRelatorio.Show;

end;

procedure TfrPEDSCI.mmRelatorioNotasClick(Sender: TObject);
var
  wRelatorio : TfrRelatorioNota;
begin
  // INSTANCIA E MOSTRA A TELA DE RELAT�RIO DE NOTAS FISCAIS
  wRelatorio := TfrRelatorioNota.Create(Self);
  wRelatorio.Show;

end;

procedure TfrPEDSCI.mmRelatorioProdutoClick(Sender: TObject);
var
  wRelatorioProduto : TfrRelatorioProduto;
begin
  //INSTANCIA E MOSTRA A TELA DE RELAT�RIO DE PRODUTOS
  wRelatorioProduto := TfrRelatorioProduto.Create(Self);
  wRelatorioProduto.Show;
end;

procedure TfrPEDSCI.mmSobreClick(Sender: TObject);
begin
  // INFORMATIVO SOBRE O SISTEMA
  MessageDlg('PED-Projeto Estagio Desenvolvedor.' +#13#13 + 'Desenvolvido por Nattan Mendes Tinonin.', mtInformation, [mbOK], 0);

end;

procedure TfrPEDSCI.mProdutoClick(Sender: TObject);
var
  wConsProduto : TfrConsProduto;
begin
  // INSTANCIA E MOSTRA A TELA DE CONSULTA DE PRODUTO
  wConsProduto := TfrConsProduto.Create(Self);
  wConsProduto.Show;

end;

end.
