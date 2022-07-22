unit uUtilPEDSCI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, udmDadosPEDSCI;

type
  TUtilPEDSCI = class
  public
    class function PodeExcluir: Boolean;
  end;

  TEmpresa = class
  public
    wCod : Integer;
    wCNPJ : String;
    wNome : String;
    wCodUF : Integer;
    wTelefone : String;

    function fCalculaCNPJ(prEntrada : String) : Integer;
    function fDeletarEmpresa() : Boolean;
    function fInserirEmpresa() : Boolean;
  end;

  TCliente = class
  public
    wCod : Integer;
    wCPF : String;
    wNome : String;
    wCodUF : Integer;
    wTelefone : String;

    function fCalculaCPF(prEntrada : String) : Integer;
    function fDeletarCliente() : Boolean;
    function fInserirCliente() : Boolean;
  end;

  TNota = class
  public
    wCod : Integer;
    wCodCli : Integer;
    wCodEmp : Integer;
    wCodProd : Integer;
    wData : TDateTime;
    wQuantidade : Integer;
    wAliquota : Currency;
    wValor : Currency;

    function fInserirNota() : Boolean;
    function fDeletarNota() : Boolean;
  end;

  TProduto = class
  public
    wCod : Integer;
    wDescricao : String;
    wNCM : Integer;

    function fInserirProduto() : Boolean;
    function fDeletarProduto() : Boolean;
  end;
implementation

{ TUtilPEDSCI }

class function TUtilPEDSCI.PodeExcluir: Boolean;
begin
  Result := MessageDlg('Deseja realmente excluir esse registro?', mtWarning, [mbYes,mbNo], 0) = mrYes;
end;

{ TEmpresa }

function TEmpresa.fCalculaCNPJ(prEntrada: String): Integer;
var
  wIncrementador, wSoma, wCount, wNumeroTemporario, wResto : Integer;
begin
  wIncrementador := 2;
  wSoma := 0;
  for wCount := Length(prEntrada) downto 1 do
    begin
      if (wIncrementador = 10) then
         wIncrementador := 2;
      wNumeroTemporario := StrToInt(prEntrada[wCount]) * wIncrementador;
      wSoma := wSoma + wNumeroTemporario;
      wIncrementador := wIncrementador + 1;
    end;
  wResto := wSoma mod 11;
  if (wResto < 2) then
     Result := 0
  else
     Result := 11 - wResto;
end;

function TEmpresa.fDeletarEmpresa(): Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
  if dmDadosPEDSCI.tbEmpresas.FindKey([wCod]) then
     begin
       // DELETA OS DADOS
       dmDadosPEDSCI.tbEmpresas.Delete;
       // INFORMA QUE FUNCIONOU
       Result := True;
     end
  else
     // INFORMA QUE FALHOU
     Result := False;
end;

function TEmpresa.fInserirEmpresa(): Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbEmpresas.IndexFieldNames := 'BDCODEMP';
  if dmDadosPEDSCI.tbEmpresas.FindKey([wCod]) then
     dmDadosPEDSCI.tbEmpresas.Edit
  else
     dmDadosPEDSCI.tbEmpresas.Insert;

  // INSERE OS DADOS NO CDS
  dmDadosPEDSCI.tbEmpresas.FieldByName('BDCODEMP').AsInteger := wCod;
  dmDadosPEDSCI.tbEmpresas.FieldByName('BDCNPJCPF').AsString := wCNPJ;
  dmDadosPEDSCI.tbEmpresas.FieldByName('BDNOMEEMP').AsString := wNome;
  dmDadosPEDSCI.tbEmpresas.FieldByName('BDCODUF').AsInteger := wCodUF + 1;
  dmDadosPEDSCI.tbEmpresas.FieldByName('BDTELEFONE').AsString := wTelefone;

  // ENVIA PARA O BANCO
  dmDadosPEDSCI.tbEmpresas.Post;

  // INFORMA QUE DEU CERTO
  Result := True;
end;

{ TCliente }

function TCliente.fCalculaCPF(prEntrada: String): Integer;
var
  wIncrementador, wSoma, wCount, wNumeroTemporario, wResto : Integer;
begin
  wIncrementador := 2;
  wSoma := 0;
  for wCount := Length(prEntrada) downto 1 do
    begin
      wNumeroTemporario := StrToInt(prEntrada[wCount]) * wIncrementador;
      wSoma := wSoma + wNumeroTemporario;
      wIncrementador := wIncrementador + 1;
    end;
  wResto := wSoma mod 11;
  if (wResto < 2) then
     Result := 0
  else
     Result := 11 - wResto;
end;

function TCliente.fDeletarCliente: Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
  if dmDadosPEDSCI.tbClientes.FindKey([wCod]) then
     begin
       // DELETA OS DADOS
       dmDadosPEDSCI.tbClientes.Delete;
       // INFORMA QUE FUNCIONOU
       Result := True;
     end
  else
     // INFORMA QUE FALHOU
     Result := False;
end;

function TCliente.fInserirCliente: Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbClientes.IndexFieldNames := 'BDCODCLI';
  if dmDadosPEDSCI.tbClientes.FindKey([wCod]) then
     dmDadosPEDSCI.tbClientes.Edit
  else
     dmDadosPEDSCI.tbClientes.Insert;

  // INSERE OS DADOS NO CDS
  dmDadosPEDSCI.tbClientes.FieldByName('BDCODCLI').AsInteger := wCod;
  dmDadosPEDSCI.tbClientes.FieldByName('BDCNPJCPF').AsString := wCPF;
  dmDadosPEDSCI.tbClientes.FieldByName('BDNOMECLI').AsString := wNome;
  dmDadosPEDSCI.tbClientes.FieldByName('BDCODUF').AsInteger := wCodUF + 1;
  dmDadosPEDSCI.tbClientes.FieldByName('BDTELEFONE').AsString := wTelefone;

  // ENVIA PARA O BANCO
  dmDadosPEDSCI.tbClientes.Post;

  // INFORMA QUE DEU CERTO
  Result := True;
end;

{ TProduto }

function TProduto.fDeletarProduto: Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';
  if dmDadosPEDSCI.tbProdutos.FindKey([wCod]) then
     begin
       // DELETA OS DADOS
       dmDadosPEDSCI.tbProdutos.Delete;
       // INFORMA QUE FUNCIONOU
       Result := True;
     end
  else
     // INFORMA QUE FALHOU
     Result := False;
end;

function TProduto.fInserirProduto: Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbProdutos.IndexFieldNames := 'BDCODPROD';
  if dmDadosPEDSCI.tbProdutos.FindKey([wCod]) then
     dmDadosPEDSCI.tbProdutos.Edit
  else
     dmDadosPEDSCI.tbProdutos.Insert;

  // INSERE OS DADOS NO CDS
  dmDadosPEDSCI.tbProdutos.FieldByName('BDCODPROD').AsInteger := wCod;
  dmDadosPEDSCI.tbProdutos.FieldByName('BDDESCRICAO').AsString := wDescricao;
  dmDadosPEDSCI.tbProdutos.FieldByName('BDNCM').AsInteger := wNCM;

  // ENVIA PARA O BANCO
  dmDadosPEDSCI.tbProdutos.Post;

  // INFORMA QUE DEU CERTO
  Result := True;
end;

{ TNota }

function TNota.fDeletarNota: Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODNOTA';
  if dmDadosPEDSCI.tbNotas.FindKey([wCod]) then
     begin
       // DELETA OS DADOS
       dmDadosPEDSCI.tbNotas.Delete;
       // INFORMA QUE FUNCIONOU
       Result := True;
     end
  else
     // INFORMA QUE FALHOU
     Result := False;
end;

function TNota.fInserirNota: Boolean;
begin
  // SETA O CAMPO QUE IREMOS PESQUISAR
  dmDadosPEDSCI.tbNotas.IndexFieldNames := 'BDCODNOTA';
  if dmDadosPEDSCI.tbNotas.FindKey([wCod]) then
     dmDadosPEDSCI.tbNotas.Edit
  else
     dmDadosPEDSCI.tbNotas.Insert;

  // INSERE OS DADOS NO CDS
  dmDadosPEDSCI.tbNotas.FieldByName('BDCODPROD').AsInteger := wCodProd;
  dmDadosPEDSCI.tbNotas.FieldByName('BDCODNOTA').AsInteger := wCod;
  dmDadosPEDSCI.tbNotas.FieldByName('BDCODCLI').AsInteger := wCodCli;
  dmDadosPEDSCI.tbNotas.FieldByName('BDCODEMP').AsInteger := wCodEmp;
  dmDadosPEDSCI.tbNotas.FieldByName('BDDATAEMISSAO').AsDateTime := wData;
  dmDadosPEDSCI.tbNotas.FieldByName('BDQTD').AsInteger := wQuantidade;
  dmDadosPEDSCI.tbNotas.FieldByName('BDVLRNOTA').AsCurrency := wValor;
  dmDadosPEDSCI.tbNotas.FieldByName('BDBCICMS').AsCurrency := wValor;
  dmDadosPEDSCI.tbNotas.FieldByName('BDALIQICMS').AsCurrency := wAliquota;
  dmDadosPEDSCI.tbNotas.FIeldByName('BDVLRICMS').AsCurrency := (wAliquota / 100) * wValor;

  // ENVIA PARA O BANCO
  dmDadosPEDSCI.tbNotas.Post;

  // INFORMA QUE DEU CERTO
  Result := True;
end;

end.