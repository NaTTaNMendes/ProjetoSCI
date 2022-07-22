object dmConnectionPEDSCI: TdmConnectionPEDSCI
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 344
  Width = 414
  object SQLConnectionPEDSCI: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'DevartFirebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=DbxDevartInterBase'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver270.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartInterBaseMetaDataCommandFactory,' +
        'DbxDevartInterBaseDriver270.bpl'
      'ProductName=DevartFirebird'
      'GetDriverFunc=getSQLDriverFirebird'
      'LibraryName=dbexpida41.dll'
      'VendorLib=fbclient.dll'
      'LibraryNameOsx=libdbexpida41.dylib'
      'VendorLibOsx=libfbclient.dylib'
      'DataBase=DataBase Name'
      'User_Name=user'
      'Password=password'
      'SQLDialect=3'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'DevartInterBase TransIsolation=ReadCommitted'
      'WaitOnLocks=True'
      'CharLength=0'
      'EnableBCD=True'
      'OptimizedNumerics=True'
      'LongStrings=True'
      'UseQuoteChar=False'
      'FetchAll=False'
      'DeferredBlobRead=False'
      'DeferredArrayRead=False'
      'ForceUsingDefaultPort=False'
      'ForceUnloadClientLibrary=False'
      'WireCompression=False'
      'UseSSL=False'
      'UseUnicode=True'
      'BlobSize=-1'
      'ErrorResourceFile='
      'DevartFirebird TransIsolation=ReadCommitted')
    Left = 56
    Top = 24
  end
  object odSelecionaBanco: TOpenDialog
    Filter = 'Firebird|*.fdb'
    Left = 200
    Top = 24
  end
end
