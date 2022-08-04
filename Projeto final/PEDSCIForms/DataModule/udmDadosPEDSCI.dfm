object dmDadosPEDSCI: TdmDadosPEDSCI
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 452
  Width = 646
  object SQLQueryFiltros: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 440
    Top = 8
  end
  object dsQueryFiltros: TDataSource
    DataSet = SQLQueryFiltros
    Left = 528
    Top = 8
  end
  object dsEmpresas: TSQLDataSet
    CommandText = 'select * from TEMPRESA'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 24
    Top = 8
  end
  object dspEmpresas: TDataSetProvider
    DataSet = dsEmpresas
    Left = 92
    Top = 8
  end
  object tbEmpresas: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'BDCODEMP'
        DataType = ftInteger
      end
      item
        Name = 'BDCNPJCPF'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'BDNOMEEMP'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'BDCODUF'
        DataType = ftInteger
      end
      item
        Name = 'BDTELEFONE'
        DataType = ftString
        Size = 17
      end>
    IndexDefs = <
      item
        Name = 'iCODIGO'
        Fields = 'BDCODEMP'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'iNOME'
        Fields = 'BDNOMEEMP'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iCNPJ'
        Fields = 'BDCNPJCPF'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iUF'
        Fields = 'BDCODUF'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iTELEFONE'
        Fields = 'BDTELEFONE'
        Options = [ixCaseInsensitive]
      end>
    Params = <>
    ProviderName = 'dspEmpresas'
    StoreDefs = True
    Left = 160
    Top = 8
  end
  object dsClientes: TSQLDataSet
    CommandText = 'select * from TCLIENTE'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 24
    Top = 72
  end
  object dspClientes: TDataSetProvider
    DataSet = dsClientes
    Left = 92
    Top = 72
  end
  object tbClientes: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'BDCODCLI'
        DataType = ftInteger
      end
      item
        Name = 'BDCNPJCPF'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'BDNOMECLI'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'BDCODUF'
        DataType = ftInteger
      end
      item
        Name = 'BDTELEFONE'
        DataType = ftString
        Size = 17
      end>
    IndexDefs = <
      item
        Name = 'iCODIGO'
        Fields = 'BDCODCLI'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'iNOME'
        Fields = 'BDNOMECLI'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iCPF'
        Fields = 'BDCNPJCPF'
      end
      item
        Name = 'iCODUF'
        Fields = 'BDCODUF'
      end
      item
        Name = 'iTELEFONE'
        Fields = 'BDTELEFONE'
      end>
    Params = <>
    ProviderName = 'dspClientes'
    StoreDefs = True
    Left = 160
    Top = 72
  end
  object dsProdutos: TSQLDataSet
    CommandText = 'select * from TCADPRODUTO'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 24
    Top = 128
  end
  object dspProdutos: TDataSetProvider
    DataSet = dsProdutos
    Left = 92
    Top = 136
  end
  object tbProdutos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'BDCODPROD'
        DataType = ftInteger
      end
      item
        Name = 'BDDESCRICAO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'BDNCM'
        DataType = ftInteger
      end
      item
        Name = 'BDVALOR'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'iCODIGO'
        Fields = 'BDCODPROD'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'iDESCRICAO'
        Fields = 'BDDESCRICAO'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iNCM'
        Fields = 'BDNCM'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iVALOR'
        Fields = 'BDVALOR'
        Options = [ixCaseInsensitive]
      end>
    Params = <>
    ProviderName = 'dspProdutos'
    StoreDefs = True
    Left = 160
    Top = 136
  end
  object dsNotas: TSQLDataSet
    CommandText = 'select * from TLANCNOTA'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 24
    Top = 200
  end
  object dspNotas: TDataSetProvider
    DataSet = dsNotas
    Left = 92
    Top = 200
  end
  object tbNotas: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'BDCODNOTA'
        DataType = ftInteger
      end
      item
        Name = 'BDCODCLI'
        DataType = ftInteger
      end
      item
        Name = 'BDCODEMP'
        DataType = ftInteger
      end
      item
        Name = 'BDDATAEMISSAO'
        DataType = ftDate
      end
      item
        Name = 'BDVLRNOTA'
        DataType = ftCurrency
      end
      item
        Name = 'BDBCICMS'
        DataType = ftCurrency
      end
      item
        Name = 'BDALIQICMS'
        DataType = ftCurrency
      end
      item
        Name = 'BDVLRICMS'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'iCODIGO'
        Fields = 'BDCODNOTA'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'iCODCLI'
        Fields = 'BDCODCLI'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iCODEMP'
        Fields = 'BDCODEMP'
      end
      item
        Name = 'iDATA'
        Fields = 'BDDATAEMISSAO'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iVLRNOTA'
        Fields = 'BDVLRNOTA'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iBCICMS'
        Fields = 'BDCICMS'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iALIQICMS'
        Fields = 'BDALIQICMS'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'iVLRICMS'
        Fields = 'BDVLRICMS'
        Options = [ixCaseInsensitive]
      end>
    Params = <>
    ProviderName = 'dspNotas'
    StoreDefs = True
    Left = 160
    Top = 200
  end
  object dsItens: TSQLDataSet
    CommandText = 'select * from TITENSNOTA'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmConnectionPEDSCI.SQLConnectionPEDSCI
    Left = 24
    Top = 264
  end
  object dspItens: TDataSetProvider
    DataSet = dsItens
    Left = 92
    Top = 264
  end
  object tbItens: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'BDCODNOTA'
        DataType = ftInteger
      end
      item
        Name = 'BDCODITEM'
        DataType = ftInteger
      end
      item
        Name = 'BDCODPROD'
        DataType = ftInteger
      end
      item
        Name = 'BDQUANTIDADE'
        DataType = ftInteger
      end
      item
        Name = 'BDCODEMP'
        DataType = ftInteger
      end
      item
        Name = 'BDVLRUNITARIO'
        DataType = ftCurrency
      end
      item
        Name = 'BDVLRTOTAL'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'ICODITEM'
        Fields = 'BDCODITEM'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'ICODNOTA'
        Fields = 'BDCODNOTA'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'ICODEMP'
        Fields = 'BDCODEMP'
        Options = [ixPrimary, ixUnique]
      end>
    Params = <>
    ProviderName = 'dspItens'
    StoreDefs = True
    Left = 160
    Top = 264
  end
end
