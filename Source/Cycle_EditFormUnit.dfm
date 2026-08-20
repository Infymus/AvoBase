inherited CycleEditForm: TCycleEditForm
  Left = 347
  Top = 253
  Caption = 'CycleEditForm'
  ClientHeight = 461
  ClientWidth = 648
  ExplicitWidth = 656
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 648
    Height = 461
    ExplicitWidth = 648
    ExplicitHeight = 461
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 646
      Height = 459
      ExplicitWidth = 646
      ExplicitHeight = 459
      inherited BASE_FORM_TOP_PANEL: TPanel
        Top = 58
        Width = 646
        ExplicitTop = 58
        ExplicitWidth = 646
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 640
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 78
        Width = 646
        Height = 360
        ExplicitTop = 78
        ExplicitWidth = 646
        ExplicitHeight = 360
        object Label1: TLabel
          Left = 6
          Top = 46
          Width = 61
          Height = 13
          Caption = 'Organization'
        end
        object Label2: TLabel
          Left = 372
          Top = 46
          Width = 50
          Height = 13
          Caption = 'Start Date'
        end
        object Label3: TLabel
          Left = 483
          Top = 46
          Width = 44
          Height = 13
          Caption = 'End Date'
        end
        object Label5: TLabel
          Left = 220
          Top = 46
          Width = 66
          Height = 13
          Caption = 'Cycle Number'
        end
        object campYearLabel: TLabel
          Left = 296
          Top = 46
          Width = 51
          Height = 13
          Caption = 'Cycle Year'
        end
        object isnewLabel: TLabel
          Left = 169
          Top = 2
          Width = 472
          Height = 38
          AutoSize = False
          Caption = 
            'FILLED_IN_BY_CREATE - this is some very long text that gets wrap' +
            'ped just to test how long text is while it is being wrapped.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          Visible = False
          WordWrap = True
        end
        object orgCombo: TComboBox
          Left = 6
          Top = 62
          Width = 208
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 1
          OnChange = orgComboChange
        end
        object db_active: TCheckBox
          Left = 9
          Top = 6
          Width = 154
          Height = 17
          Caption = 'Sales Cycle Is Active'
          TabOrder = 0
        end
        object INVOICE_MSG_DOCK_PANEL: TPanel
          Left = 1
          Top = 94
          Width = 644
          Height = 265
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'INVOICE_MSG_DOCK_PANEL'
          Color = clPurple
          DockSite = True
          ParentBackground = False
          TabOrder = 4
          object cycleDescriptPanel: TPanel
            Left = 0
            Top = 0
            Width = 644
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            Caption = 
              'Sales Cycle Invoice Override Message - This Message will appear ' +
              'on all Invoices in this Sales Cycle'
            Color = 15066597
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
          end
        end
        object CycleNumComboBox: TComboBox
          Left = 220
          Top = 62
          Width = 70
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 2
        end
        object CycleYearComboBox: TComboBox
          Left = 296
          Top = 62
          Width = 69
          Height = 19
          BevelInner = bvLowered
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 3
        end
        object sDateEdit: TDateTimePicker
          Left = 372
          Top = 62
          Width = 104
          Height = 19
          Date = 40904.351171550920000000
          Time = 40904.351171550920000000
          MinDate = 40179.000000000000000000
          TabOrder = 5
        end
        object eDateEdit: TDateTimePicker
          Left = 483
          Top = 62
          Width = 104
          Height = 19
          Date = 40904.351171550920000000
          Time = 40904.351171550920000000
          MinDate = 40179.000000000000000000
          TabOrder = 6
        end
      end
      inherited ToolBar: TToolBar
        Top = 0
        Width = 646
        Height = 58
        ExplicitTop = 0
        ExplicitWidth = 646
        ExplicitHeight = 58
      end
      inherited StatusBar: TStatusBar
        Top = 438
        Width = 646
        ExplicitTop = 438
        ExplicitWidth = 646
      end
    end
  end
end
