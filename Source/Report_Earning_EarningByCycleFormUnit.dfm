inherited Report_Earning_EarningByCycle: TReport_Earning_EarningByCycle
  Caption = 'Report_Earning_EarningByCycle'
  ExplicitWidth = 903
  ExplicitHeight = 1123
  PixelsPerInch = 96
  TextHeight = 13
  inherited QReport: TQuickRep
    Left = 32
    DataSet = ReportQuery
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      127.000000000000000000
      2794.000000000000000000
      127.000000000000000000
      2159.000000000000000000
      127.000000000000000000
      127.000000000000000000
      0.000000000000000000)
    ExplicitLeft = 32
    inherited Band_Header: TQRBand
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      inherited ReportNameLabel: TQRLabel
        Width = 352
        Size.Values = (
          92.604166666666670000
          0.000000000000000000
          2.645833333333333000
          931.333333333333300000)
        Caption = 'Earning Breakdown By Sales Cycle'
        FontSize = 16
        ExplicitWidth = 352
      end
      inherited SalesCycleLabel: TQRLabel
        Size.Values = (
          39.687500000000000000
          1664.229166666667000000
          60.854166666666670000
          240.770833333333300000)
        FontSize = 8
      end
      inherited ReportLabel: TQRLabel
        Size.Values = (
          52.916666666666670000
          1653.645833333333000000
          2.645833333333333000
          251.354166666666700000)
        FontSize = 12
      end
      inherited InvoiceDateLabel: TQRLabel
        Size.Values = (
          47.625000000000000000
          0.000000000000000000
          71.437500000000000000
          132.291666666666700000)
        FontSize = 8
      end
    end
    inherited Band_Title: TQRBand
      Height = 0
      Enabled = False
      Size.Values = (
        0.000000000000000000
        1905.000000000000000000)
      ExplicitHeight = 0
    end
    inherited Band_ColumnHeader: TQRBand
      Top = 89
      Height = 0
      Enabled = False
      Size.Values = (
        0.000000000000000000
        1905.000000000000000000)
      ExplicitTop = 89
      ExplicitHeight = 0
    end
    inherited Band_Detail: TQRBand
      Top = 130
      Height = 18
      BeforePrint = Band_DetailBeforePrint
      Size.Values = (
        47.625000000000000000
        1905.000000000000000000)
      ExplicitTop = 130
      ExplicitHeight = 18
      object db_mopdate: TQRLabel
        Left = 1
        Top = 1
        Width = 72
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          2.645833333333333000
          190.500000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'db_mopdate'
        Color = clWhite
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_exptype: TQRLabel
        Left = 102
        Top = 1
        Width = 547
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          269.875000000000000000
          2.645833333333333000
          1447.270833333333000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = True
        Caption = 'Type'
        Color = clWhite
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_amount: TQRLabel
        Left = 659
        Top = 1
        Width = 61
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1743.604166666667000000
          2.645833333333333000
          161.395833333333300000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = '000000.00'
        Color = clWhite
        Transparent = True
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    inherited Band_Summary: TQRBand
      Top = 179
      Height = 1
      Color = clBlack
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 179
      ExplicitHeight = 1
    end
    inherited Band_Header_Child1: TQRChildBand
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
    end
    inherited Band_Title_Child1: TQRChildBand
      Top = 89
      Height = 0
      Enabled = False
      Size.Values = (
        0.000000000000000000
        1905.000000000000000000)
      ExplicitTop = 89
      ExplicitHeight = 0
    end
    inherited Band_ColumnHeader_Child1: TQRChildBand
      Top = 89
      Height = 0
      Enabled = False
      Size.Values = (
        0.000000000000000000
        1905.000000000000000000)
      ExplicitTop = 89
      ExplicitHeight = 0
    end
    inherited BAND_Footer: TQRBand
      Top = 210
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 210
    end
    inherited ChildBand2: TQRChildBand
      Top = 211
      Height = 15
      Size.Values = (
        39.687500000000000000
        1905.000000000000000000)
      ExplicitTop = 211
      ExplicitHeight = 15
      inherited VersionString: TQRLabel
        Top = 1
        Size.Values = (
          34.395833333333330000
          47.625000000000000000
          2.645833333333333000
          148.166666666666700000)
        FontSize = 7
        ExplicitTop = 1
      end
      inherited AvoBaseRegLabel: TQRLabel
        Top = 1
        Size.Values = (
          34.395833333333330000
          1349.375000000000000000
          2.645833333333333000
          555.625000000000000000)
        FontSize = 7
        ExplicitTop = 1
      end
      inherited QRImage1: TQRImage
        Top = 1
        Width = 16
        Height = 16
        Size.Values = (
          42.333333333333330000
          0.000000000000000000
          2.645833333333333000
          42.333333333333330000)
        ExplicitTop = 1
        ExplicitWidth = 16
        ExplicitHeight = 16
      end
    end
    object BAND_Group: TQRGroup
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
      BeforePrint = BAND_GroupBeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = Band_Detail
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      Expression = 'ReportQuery.C_ID'
      FooterBand = BAND_GroupFooter
      Master = QReport
      ReprintOnNewPage = False
      object QRLabel1: TQRLabel
        Left = 0
        Top = 1
        Width = 196
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          0.000000000000000000
          2.645833333333333000
          518.583333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'EARNINGS FOR SALES CYCLE:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_cycle: TQRLabel
        Left = 198
        Top = 1
        Width = 53
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          523.875000000000000000
          2.645833333333333000
          140.229166666666700000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'db_cycle'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object DateLabel: TQRLabel
        Left = 1
        Top = 21
        Width = 30
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          2.645833333333333000
          55.562500000000000000
          79.375000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Date'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = 102
        Top = 21
        Width = 115
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          269.875000000000000000
          55.562500000000000000
          304.270833333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Type - Description'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 670
        Top = 21
        Width = 50
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1772.708333333333000000
          55.562500000000000000
          132.291666666666700000)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Caption = 'Amount'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    object ChildBand1: TQRChildBand
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
      ParentBand = BAND_Group
      PrintOrder = cboAfterParent
    end
    object BAND_GroupFooter: TQRBand
      Left = 48
      Top = 148
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
      BandType = rbGroupFooter
    end
    object ChildBand3: TQRChildBand
      Left = 48
      Top = 149
      Width = 720
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = ChildBand3BeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        79.375000000000000000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = BAND_GroupFooter
      PrintOrder = cboAfterParent
      object QRShape1: TQRShape
        Left = 498
        Top = 2
        Width = 220
        Height = 26
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          68.791666666666670000
          1317.625000000000000000
          5.291666666666667000
          582.083333333333300000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel2: TQRLabel
        Left = 559
        Top = 6
        Width = 94
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1479.020833333333000000
          15.875000000000000000
          248.708333333333300000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'CYCLE TOTAL:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_subtotal: TQRLabel
        Left = 654
        Top = 6
        Width = 61
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1730.375000000000000000
          15.875000000000000000
          161.395833333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '000000.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
    object ChildBand4: TQRChildBand
      Left = 48
      Top = 180
      Width = 720
      Height = 30
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      BeforePrint = ChildBand4BeforePrint
      Color = clWhite
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        79.375000000000000000
        1905.000000000000000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ParentBand = Band_Summary
      PrintOrder = cboAfterParent
      object QRShape2: TQRShape
        Left = 498
        Top = 2
        Width = 220
        Height = 26
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          68.791666666666670000
          1317.625000000000000000
          5.291666666666667000
          582.083333333333300000)
        Shape = qrsRectangle
        VertAdjust = 0
      end
      object QRLabel6: TQRLabel
        Left = 548
        Top = 6
        Width = 105
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1449.916666666667000000
          15.875000000000000000
          277.812500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'REPORT TOTAL:'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
      object db_reporttotal: TQRLabel
        Left = 654
        Top = 6
        Width = 61
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1730.375000000000000000
          15.875000000000000000
          161.395833333333300000)
        Alignment = taRightJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '000000.00'
        Color = clWhite
        Transparent = False
        WordWrap = True
        ExportAs = exptText
        FontSize = 10
      end
    end
  end
  object ReportQuery: TQuery
    Left = 27
    Top = 15
  end
end
