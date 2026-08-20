inherited OrgSelectOrgAndMultieCycleForm: TOrgSelectOrgAndMultieCycleForm
  Caption = 'OrgSelectOrgAndMultieCycleForm'
  ClientHeight = 255
  ClientWidth = 616
  ExplicitWidth = 618
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 616
    Height = 255
    ExplicitWidth = 616
    ExplicitHeight = 255
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 614
      Height = 253
      ExplicitWidth = 614
      ExplicitHeight = 253
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 614
        ExplicitWidth = 614
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 20
        Width = 614
        Height = 158
        Caption = ''
        ExplicitTop = 20
        ExplicitWidth = 614
        ExplicitHeight = 158
        object GroupBox1: TGroupBox
          Left = 1
          Top = 1
          Width = 612
          Height = 156
          Align = alClient
          Caption = 'Sales Organization Options'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object info_label: TLabel
            Left = 11
            Top = 18
            Width = 589
            Height = 36
            AutoSize = False
            Caption = 'FILLED_IN_BY_FORM_CREATE'
            WordWrap = True
          end
          object Label1: TLabel
            Left = 11
            Top = 130
            Width = 314
            Height = 13
            Caption = 'Note: Only Organizations and Sales Cycles created will be shown.'
          end
          object GroupBox_SalesOrgs: TGroupBox
            Left = 11
            Top = 60
            Width = 229
            Height = 64
            Caption = 'Sales Organization'
            TabOrder = 0
            object orgLabel: TLabel
              Left = 11
              Top = 16
              Width = 80
              Height = 14
              Caption = 'ORGANIZATION'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object SelectOrgCycle_Org: TComboBox
              Left = 11
              Top = 33
              Width = 208
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              TabOrder = 0
              OnChange = SelectOrgCycle_OrgChange
            end
          end
          object GroupBox_StartSalesCycle: TGroupBox
            Left = 246
            Top = 60
            Width = 174
            Height = 64
            Caption = 'Starting Sales Cycle'
            TabOrder = 1
            object campYearLabel: TLabel
              Left = 11
              Top = 16
              Width = 67
              Height = 14
              Caption = 'CYCLE YEAR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object CycleNumLabel: TLabel
              Left = 97
              Top = 16
              Width = 63
              Height = 14
              Caption = 'CYCLE NUM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object SelectOrgCycle_CycleStartNum: TComboBox
              Left = 97
              Top = 33
              Width = 69
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              TabOrder = 0
            end
            object SelectOrgCycle_CycleStartYear: TComboBox
              Left = 11
              Top = 33
              Width = 70
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              TabOrder = 1
            end
          end
          object GroupBox_EndSalesCycle: TGroupBox
            Left = 426
            Top = 60
            Width = 174
            Height = 64
            Caption = 'Ending Sales Cycle'
            TabOrder = 2
            object Label8: TLabel
              Left = 11
              Top = 16
              Width = 67
              Height = 14
              Caption = 'CYCLE YEAR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label9: TLabel
              Left = 97
              Top = 16
              Width = 63
              Height = 14
              Caption = 'CYCLE NUM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object SelectOrgCycle_CycleEndNum: TComboBox
              Left = 97
              Top = 33
              Width = 69
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              TabOrder = 0
            end
            object SelectOrgCycle_CycleEndYear: TComboBox
              Left = 11
              Top = 33
              Width = 70
              Height = 19
              Style = csOwnerDrawFixed
              ItemHeight = 13
              TabOrder = 1
            end
          end
        end
      end
      inherited ToolBar: TToolBar
        Top = 178
        Width = 614
        Align = alBottom
        ExplicitTop = 178
        ExplicitWidth = 614
      end
      inherited StatusBar: TStatusBar
        Top = 232
        Width = 614
        ExplicitTop = 232
        ExplicitWidth = 614
      end
    end
  end
end
