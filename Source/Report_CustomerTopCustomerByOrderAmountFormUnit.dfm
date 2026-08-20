inherited Report_Customer_TopCustByOrderAmount: TReport_Customer_TopCustByOrderAmount
  Caption = 'Report_Customer_TopCustByOrderAmount'
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
        Width = 338
        Size.Values = (
          92.604166666666670000
          0.000000000000000000
          2.645833333333333000
          894.291666666666700000)
        AlignToBand = True
        Caption = 'Top Customer By Order Amounts'
        FontSize = 16
        ExplicitWidth = 338
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
      Height = 884
      Size.Values = (
        2338.916666666667000000
        1905.000000000000000000)
      ExplicitHeight = 884
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
          object Series1: TPieSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Style = smsLabelValue
            Marks.Visible = True
            DataSource = ReportQuery
            XLabelsSource = 'CUSTNAME'
            Gradient.Direction = gdRadial
            OtherSlice.Legend.Visible = False
            PieValues.Name = 'Pie'
            PieValues.Order = loNone
            PieValues.ValueSource = 'AMOUNT'
          end
        end
      end
    end
    inherited Band_ColumnHeader: TQRBand
      Top = 974
      Height = 6
      Size.Values = (
        15.875000000000000000
        1905.000000000000000000)
      ExplicitTop = 974
      ExplicitHeight = 6
    end
    inherited Band_Detail: TQRBand
      Top = 981
      Height = 4
      Size.Values = (
        10.583333333333330000
        1905.000000000000000000)
      ExplicitTop = 981
      ExplicitHeight = 4
    end
    inherited Band_Summary: TQRBand
      Top = 985
      Height = 6
      Size.Values = (
        15.875000000000000000
        1905.000000000000000000)
      ExplicitTop = 985
      ExplicitHeight = 6
    end
    inherited Band_Header_Child1: TQRChildBand
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
    end
    inherited Band_Title_Child1: TQRChildBand
      Top = 973
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 973
    end
    inherited Band_ColumnHeader_Child1: TQRChildBand
      Top = 980
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 980
    end
    inherited BAND_Footer: TQRBand
      Top = 991
      Size.Values = (
        2.645833333333333000
        1905.000000000000000000)
      ExplicitTop = 991
    end
    inherited ChildBand2: TQRChildBand
      Top = 992
      Height = 15
      Size.Values = (
        39.687500000000000000
        1905.000000000000000000)
      ExplicitTop = 992
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
    Left = 123
    Top = 132
  end
  object ReportSession: TSession
    AutoSessionName = True
    NetFileDir = 'C:\TEMP'
    PrivateDir = 'C:\TEMP'
    Left = 123
    Top = 183
  end
end
