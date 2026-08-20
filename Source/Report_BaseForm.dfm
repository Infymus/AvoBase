object AvoBase_ReportBase: TAvoBase_ReportBase
  Left = 353
  Top = 36
  Caption = 'AvoBase_ReportBase'
  ClientHeight = 1084
  ClientWidth = 887
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object QReport: TQuickRep
    Left = 35
    Top = 20
    Width = 816
    Height = 1056
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = Letter
    Page.Values = (
      127.000000000000000000
      2794.000000000000000000
      127.000000000000000000
      2159.000000000000000000
      127.000000000000000000
      127.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    SnapToGrid = True
    Units = Inches
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsMaximized
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    object Band_Header: TQRBand
      Left = 48
      Top = 48
      Width = 720
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageHeader
      object ReportNameLabel: TQRLabel
        Left = 0
        Top = 1
        Width = 300
        Height = 35
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          92.604166666666670000
          0.000000000000000000
          2.645833333333333000
          793.750000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = True
        Caption = 'ORGNAME0123456789012345'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = False
        ExportAs = exptText
        FontSize = 16
      end
      object SalesCycleLabel: TQRLabel
        Left = 629
        Top = 23
        Width = 91
        Height = 15
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          39.687500000000000000
          1664.229166666667000000
          60.854166666666670000
          240.770833333333300000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'SalesCycleLabel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 8
      end
      object ReportLabel: TQRLabel
        Left = 625
        Top = 1
        Width = 95
        Height = 20
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          52.916666666666670000
          1653.645833333333000000
          2.645833333333333000
          251.354166666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'ReportLabel'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 12
      end
      object InvoiceDateLabel: TQRLabel
        AlignWithMargins = True
        Left = 0
        Top = 27
        Width = 50
        Height = 18
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          47.625000000000000000
          0.000000000000000000
          71.437500000000000000
          132.291666666666700000)
        Alignment = taLeftJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'datetime'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 8
      end
    end
    object Band_Title: TQRBand
      Left = 48
      Top = 89
      Width = 720
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbTitle
    end
    object Band_ColumnHeader: TQRBand
      Left = 48
      Top = 130
      Width = 720
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbColumnHeader
    end
    object Band_Detail: TQRBand
      Left = 48
      Top = 171
      Width = 720
      Height = 133
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AfterPrint = Band_DetailAfterPrint
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        351.895833333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbDetail
    end
    object Band_Summary: TQRBand
      Left = 48
      Top = 304
      Width = 720
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbSummary
    end
    object Band_Header_Child1: TQRChildBand
      Left = 48
      Top = 88
      Width = 720
      Height = 1
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clBlack
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Band_Header
      PrintOrder = cboAfterParent
    end
    object Band_Title_Child1: TQRChildBand
      Left = 48
      Top = 129
      Width = 720
      Height = 1
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clBlack
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Band_Title
      PrintOrder = cboAfterParent
    end
    object Band_ColumnHeader_Child1: TQRChildBand
      Left = 48
      Top = 170
      Width = 720
      Height = 1
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clBlack
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Band_ColumnHeader
      PrintOrder = cboAfterParent
    end
    object BAND_Footer: TQRBand
      Left = 48
      Top = 344
      Width = 720
      Height = 1
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clBlack
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      BandType = rbPageFooter
    end
    object ChildBand2: TQRChildBand
      Left = 48
      Top = 345
      Width = 720
      Height = 19
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = ChildBand2BeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        50.270833333333330000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = BAND_Footer
      PrintOrder = cboAfterParent
      object VersionString: TQRLabel
        Left = 18
        Top = 2
        Width = 56
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          34.395833333333330000
          47.625000000000000000
          5.291666666666667000
          148.166666666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'VersionString'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 7
      end
      object AvoBaseRegLabel: TQRLabel
        AlignWithMargins = True
        Left = 510
        Top = 2
        Width = 210
        Height = 13
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          34.395833333333330000
          1349.375000000000000000
          5.291666666666667000
          555.625000000000000000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'This Copy Registered To: AvoBase Representative'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 7
      end
      object QRImage1: TQRImage
        Left = 0
        Top = 0
        Width = 12
        Height = 12
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          31.750000000000000000
          0.000000000000000000
          0.000000000000000000
          31.750000000000000000)
        Picture.Data = {
          07544269746D61707E120000424D7E1200000000000036000000280000001E00
          000027000000010020000000000048120000D70D0000D70D0000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFAA835ADDB97D3CEBD9D0C7E6FFFFFFFDFEFEFEFFFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFCC56905F6D06C00FED46E00FF9C5B0FD7E8DED2EAFFFFFFFBFFFFFFFFFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA2876BE0D06B00FFD16E
          00FED47100FED87400FEDF7800FF9F5700DEE9E3DCE7FDFDFEFDFFFFFFFFFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFEFEFEFBFAF9FDCA6B04FBD06C00FFD37000FED67200FFD976
          00FFDD7900FEDF7B00FEE37F00FDBA6B06EAD5D5D3DCFFFFFFFFFEFEFEFEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFAC957DDBCE6B00FED26E00FED57100FFD87400FEDB7700FFDE7A00FFE17D
          00FFE48000FFE88300FFE68200FDD58416F3C2C1C0D7FFFFFFFFFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEF3F3F3F8C05E00FAD06C
          00FFD36F00FFD67300FED97500FFDC7800FFE07B00FFE37E00FFE68100FFE984
          00FEEC8700FFF08A00FFF08A00FFDC8E20F0C4BCAFDEFFFFFFFFFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC1A78BDFCF6C00FED26E00FDD47200FDD874
          00FEDB7700FDDD7900FDE17D00FEE58000FEE78200FEEA8600FEEE8900FEF08B
          00FDF48F00FDF79200FEFC9400FFD18A1CEBD3C3ACE9FFFFFFFCFFFFFFFFFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
          FEFEF4F7FAF2AE5000F2D06D00FFD37000FFD67200FFD97500FFDD7900FFE07C
          00FFE37B00FFD27B0DFFD88A26FFD9881DFEE28000FFF58E00FFF69000FFF993
          00FFFC9600FEFC9600FEFB9200FFBB700AE9E0CFB9EFFEFFFFFBFFFFFFFFFEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6A683E1D16D
          00FFD26E00FDD57100FFD77300FFDB7700FEDD7800FFCC7C1CFFC0BDBCFFFFFF
          FFFFFFFFFFFFFFFFFFFFE4E9F1FEC48229FFF89200FFFA9500FFFD9700FFF993
          00FFF38E00FEEC8800FFEA8300FFAD5E00EDE0D4C5EEFBFCFCFCFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFFFFF0A84E00EDD06D00FFD37000FED672
          00FFD97500FFE07A00FEB59169FFFFFFFFFFFEFEFEFEFFFFFFFEFEFEFEFEFFFF
          FFFFFEFEFEFFFDFFFFFFB27827FFFC9600FEFC9600FFF69100FEEF8B00FFE985
          00FEE37F00FFDD7A00FED77400FFB05D00EFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB7936CDDD26C00FFD16E00FED57200FED87400FFE07A00FFC5A7
          86FEFFFFFFFEF9FAFCFFFFFFFFFFFEFEFEFFFEFEFEFFFFFFFFFEFEFEFEFEFEFE
          FEFFF6F4F2FFFA9903FFF99300FDF28E00FFEC8700FEE68200FFDF7C00FFD976
          00FFD37100FDB06C23E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6B35B
          00EED06D00FED37000FFD67200FED97500FFB0804AFFFFFFFFFEFFFFFFFFD8CB
          BCFE997143FEFAF9F8FEFEFEFEFEFFFFFFFEFFFFFFFFFFFFFFFFFDFDFEFFC681
          1CFEF79100FEF08B00FEEA8500FFE37F00FEDD7A00FED77400FED77100FFD2C3
          B3EAFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFAB8D6EE3D16B00FFD26E00FFD571
          00FFD87400FED56F00FFF0EEECFFFEFEFEFEFEFEFEFFE5DBCFFFE6EAF1FFFFFF
          FFFFFEFEFEFFECEDEDFFFFFFFFFEFEFEFEFFFFFFFFFFB79870FFF48E00FFEC88
          00FFE78200FEE07D00FFDA7700FFD37100FFA05909E8FFFFFFFAFFFFFFFFFFFF
          FFFFFEFEFEFFFFFFFFFDC26808F7D06D00FED37000FFD67300FEDA7600FFA886
          61FEFFFFFFFFFFFFFFFFFEFEFEFEE0D6C9FFCCB9A3FFFFFFFFFFFFFFFFFFC4BF
          BBFFC18228FEDCCCB5FFFFFFFFFFB8A794FFF28A00FFE98500FFE47F00FEDD7A
          00FFD77400FFD57000FFDED2C6EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA691
          7BDCCF6B00FFD26E00FED47100FED87400FFD97601FEF4F3F1FFFFFFFFFFFEFE
          FEFEFFFFFFFFCEC6BDFEDBDCDCFE9F733FFEDAD1C4FECD8825FED29030FFD3D5
          D9FEFFFFFFFEB49D80FEEE8800FEE68200FEE07C00FFD97600FED47100FFA658
          03F2FCFEFFFAFFFFFFFFFFFFFFFFFEFEFEFFFBFAFAFCC86904FDD06D00FED370
          00FFD67200FFDA7600FEDA7907FEFAFAF9FFFFFFFFFFFEFEFEFEFFFFFFFEC7BC
          B1FFFFFFFFFFF6F5F4FFDF880DFFBD9153FEFFFFFFFEFEFEFEFFFEFEFEFFB480
          3DFFEB8500FDE48000FFDD7900FED77400FFD06D00FEDBD7D2E3FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFB1A090D6CE6B00FED16E00FFD57200FED77400FFDC77
          00FFB8690DFEFCFDFDFFFFFFFFFFFEFEFEFEFFFFFFFFB7AA9BFFE3E3E3FEF28F
          02FEC2AB8CFEFFFFFFFFFEFEFEFFFEFEFEFFFBFBFCFFE08309FEE78200FFDF7C
          00FEDA7700FFD47100FEB36107F8FDFDFDFCFEFEFEFEFFFFFFFFFEFEFEFEF4F5
          F6F6BF6000FCD06D00FFD37000FED67300FFD97500FFDD7800FEB16D1EFFFEFE
          FFFEFEFEFEFFFFFFFFFFFFFFFFFEB89C78FFEE8A00FFD6CAB9FFFFFFFFFFFEFE
          FEFFFEFEFEFEFFFFFFFFEDECEAFFE88400FFE37F00FFDD7A00FFD77400FECC6A
          00FFC4BFBBC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4AE97DACF6C00FFD16E
          00FFD57100FED87400FFDB7700FFDF7A00FFBA6B0EFEFEFEFEFFFEFEFEFFFFFF
          FFFEFFFFFFFFB09574FFDED5CBFFFFFFFFFFFEFEFEFFFEFEFEFEFFFFFFFFFEFF
          FFFFB0762DFFE78200FFE07D00FEDA7600FFD47100FEBB6B12F2FFFFFFFFFEFE
          FEFEFFFFFFFFFFFFFFFFF5F9FCF0AE5300F1D06C00FDD37000FDD77300FFD975
          00FEDD7800FDDF7B00FDE07F07FDFAFAFAFDFFFFFFFDFEFEFEFEFEFEFEFDFFFF
          FFFDFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFED8CFC3FDF08700FDE480
          00FEDD7A00FDD67400FECE6A00FFB9AEA2D0FEFEFEFEFFFFFFFFFFFFFFFFFFFF
          FFFFCAAD8FE1D26D00FFD26E00FED57100FFD77400FEDB7700FFDE7A00FFE17D
          00FFE27F00FFE1DCD8FFFFFFFFFFFFFFFFFFFEFEFEFFFEFEFEFFFFFFFFFFFFFF
          FFFFFEFEFEFFFFFFFFFEE8E8E7FFCF7400FFE68300FFE07C00FFDA7700FED471
          00FFB46712E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA55F14E3CD6A
          00FFD37000FFD77300FFD97500FEDD7800FFDF7C00FFE37E00FFE68200FDBB6D
          0AFFF9FAFCFFFFFFFFFEFEFEFEFFFEFEFEFFFFFFFFFFFEFEFEFFFFFFFFFFE8E8
          E6FFC97606FEEA8500FFE37F00FFDD7A00FFD77400FFD36D00FFC1AF9CE0FEFE
          FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7AB9FD3C36802FDD773
          00FDDB7700FFDE7A00FEE17C00FFE48000FFE88300FEEA8500FFB17325FFF4F6
          F8FEFEFEFEFFFEFEFEFFFEFEFEFEFEFDFCFEB4A287FEEB8700FFED8800FFE883
          00FFE07C00FFDA7700FED37100FFA55906E3FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEFEFFFFFFFFFBFBFBFBC9BFB4D7BC6400F5E37E
          00FFE37E00FEE68100FEEA8500FEEC8700FFF08B00FFF08D04FECC8217FEBB82
          30FFCC8519FFF69707FFF69000FFF08B00FEEA8500FEE48000FFDC7900FFD774
          00FFD57000FFD2C0ABEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEFEFFFFFFFFFAFCFFF99C8D79E6BA6E12FEEF86
          00FFEA8500FEEE8900FFF08B00FFF48F00FEF89200FFFB9600FEFF9800FEFA94
          00FEF48F00FEED8900FEE78300FFE17D00FFDA7700FFD47100FFA05200E7FEFF
          FFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFF7F7F7F2BBBBBBF6DDE1E5FFC6B49FFFC0791FFEF48A
          00FFF28D00FFF69000FEF89300FFFB9600FFFD9700FFF79100FFF18C00FFEA86
          00FFE48000FEDD7A00FFD77400FED36F00FFD9CBBDEFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF919191E2E3E3E3FFE3E3E3FFE8E8E8FEF3F6FBFFC4B7A6FED18B29FFF58D
          00FFFB9500FEFD9700FFFA9400FFF38E00FFED8800FFE78300FFE07D00FEDA77
          00FFD47200FFAC5A00F1FAFBFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF9CCCCCCF9DFDF
          DFFEE5E5E5FEEBEBEBFFF0F0F0FEF6F6F6FFFFFFFFFFC4BCB3FEDA8F20FFF792
          00FEF89100FFF18B00FEEA8600FEE37F00FEDD7A00FFD77400FECF6D00FECFCA
          C3E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFE7F7F7FDBE0E0E0FFE2E2E2FFE8E8E8FFEDED
          EDFEF3F3F3FEF8F8F8FFFDFDFDFFF2F2F2FEEDEDEEFEAEADACF7D1800DF6EA86
          00FEE78300FFE17D00FEDA7700FED57200FFBE6707F8FCFCFCFCFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
          FEFEF9F9F9FDD6D6D6FCE0E0E0FFE5E5E5FEEBEBEBFFF0F0F0FFF6F6F6FEFCFC
          FCFFF8F8F8FFEEEEEEFEE7E7E7FF8C8C8CDCFEFEFEFEDFDEDBE1B56806F0E07C
          00FFD77400FFCF6C00FFB4AEA8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF868686D2DDDD
          DDFFE3E3E3FEE8E8E8FFEEEEEEFFF3F3F3FEF9F9F9FFFDFDFDFEF3F3F3FFE8E8
          E8FFB7B7B7F0FFFFFFFCFEFEFEFEFFFFFFFFFCFEFFFBE4DDD3E9A05C0DE2C66E
          0EF7FFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEFEEEEEEEF6C9C9C9FFE0E0E0FFE5E5E5FEEBEB
          EBFFF0F0F0FFF6F6F6FFFBFBFBFEF8F8F8FFEDEDEDFFEAEAEAFFA9A9A9E9FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBE4E2E0EFFEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFA5A5A5D3DEDEDEFEE3E3E3FDE8E8E8FFEEEEEEFEF3F3F3FDF9F9
          F9FDFDFDFDFDF4F4F4FDE8E8E8FDB0B0B0F4F3F3F3F5FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEBEBE9B4B4
          B4FDDFDFDFFEE6E6E6FFEBEBEBFEF1F1F1FFF6F6F6FFFCFCFCFFF9F9F9FFEEEE
          EEFFE8E8E8FFB8B8B8ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7B7B7DCDFDFDFFFE3E3E3FFE8E8
          E8FFEEEEEEFEF3F3F3FFF9F9F9FFFDFDFDFFF3F3F3FDE8E8E8FFBBBBBBFCE7E7
          E7EAFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFC989898C4C4C4C4FEEBEBEBFDF1F1F1FFF6F6
          F6FEFCFCFCFFF9F9F9FFEEEEEEFEE4E4E4FFA5A5A5D3FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFEFEFFFFFFFFFFF9F9F9FBBDBDBDDFB9B9B9F8FFFFFFFFFCFCFCFEF3F3
          F3FEE8E8E8FECDCDCDFFECECECF3FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFEFEFFFFFFFFFFF6F6F6F8CDCDCDE7AAAAAAEBF9F9F9FFE2E2E2FE8D8D
          8DD6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFBFBFBF9C4C4C4EAA2A2A2E5FCFCFCF9FEFEFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF}
        Stretch = True
      end
    end
  end
end
