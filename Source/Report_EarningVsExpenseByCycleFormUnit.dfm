inherited Report_EarningVsExpenseByCycle: TReport_EarningVsExpenseByCycle
  Caption = 'Report_EarningVsExpenseByCycle'
  PixelsPerInch = 96
  TextHeight = 13
  inherited QReport: TQuickRep
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
    inherited Band_Header: TQRBand
      Size.Values = (
        105.833333333333300000
        1905.000000000000000000)
      inherited ReportNameLabel: TQRLabel
        Width = 278
        Size.Values = (
          92.604166666666670000
          0.000000000000000000
          2.645833333333333000
          735.541666666666700000)
        Caption = 'Earning Vs Expense Report'
        FontSize = 16
        ExplicitWidth = 278
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
        Width = 124
        Size.Values = (
          47.625000000000000000
          0.000000000000000000
          71.437500000000000000
          328.083333333333300000)
        FontSize = 8
        ExplicitWidth = 124
      end
    end
    inherited Band_Title: TQRBand
      Height = 806
      Size.Values = (
        2132.541666666667000000
        1905.000000000000000000)
      ExplicitHeight = 806
      object QRChart: TQRChart
        Left = 12
        Top = 10
        Width = 706
        Height = 785
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          2076.979166666667000000
          31.750000000000000000
          26.458333333333330000
          1867.958333333333000000)
        object QRDBChart1: TQRDBChart
          Left = -1
          Top = -1
          Width = 1
          Height = 1
          Title.Font.Height = -16
          Title.Text.Strings = (
            'Top Customer By Orders Placed')
          Title.Visible = False
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          PrintMargins = (
            25
            15
            25
            15)
          ColorPaletteIndex = 14
          object Series1: TPieSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Style = smsLabelValue
            Marks.Visible = True
            DataSource = ReportQuery
            XLabelsSource = 'DESCR'
            Gradient.Direction = gdRadial
            OtherSlice.Legend.Visible = False
            PieValues.Name = 'Pie'
            PieValues.Order = loNone
            PieValues.ValueSource = 'AMT_TOTAL'
          end
        end
      end
    end
    inherited Band_ColumnHeader: TQRBand
      Top = 896
      Height = 9
      Size.Values = (
        23.812500000000000000
        1905.000000000000000000)
      ExplicitTop = 896
      ExplicitHeight = 9
    end
    inherited Band_Detail: TQRBand
      Top = 906
      Height = 10
      Size.Values = (
        26.458333333333330000
        1905.000000000000000000)
      ExplicitTop = 906
      ExplicitHeight = 10
    end
    inherited Band_Summary: TQRBand
      Top = 916
      Height = 9
      Size.Values = (
        23.812500000000000000
        1905.000000000000000000)
      ExplicitTop = 916
      ExplicitHeight = 9
    end
    inherited Band_Header_Child1: TQRChildBand
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
    end
    inherited Band_Title_Child1: TQRChildBand
      Top = 895
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 895
    end
    inherited Band_ColumnHeader_Child1: TQRChildBand
      Top = 905
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 905
    end
    inherited BAND_Footer: TQRBand
      Top = 925
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 925
    end
    inherited ChildBand2: TQRChildBand
      Top = 926
      Height = 15
      Size.Values = (
        39.687500000000000000
        1905.000000000000000000)
      ExplicitTop = 926
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
  end
  object ReportQuery: TQuery
    SessionName = 'ReportSession_1'
    SQL.Strings = (
      'SELECT * FROM "c:\temp\cacc.db" ')
    Left = 111
    Top = 144
  end
  object ReportSession: TSession
    KeepConnections = False
    NetFileDir = 'C:\TEMP'
    PrivateDir = 'C:\TEMP'
    Left = 111
    Top = 195
  end
end
