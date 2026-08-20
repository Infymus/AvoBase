inherited CustOrd_MainForm: TCustOrd_MainForm
  Caption = 'CustOrd_MainForm'
  ClientHeight = 322
  ClientWidth = 653
  ExplicitWidth = 655
  ExplicitHeight = 324
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 653
    Height = 322
    ExplicitWidth = 653
    ExplicitHeight = 322
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 651
      Height = 320
      ExplicitWidth = 651
      ExplicitHeight = 320
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 651
        ExplicitTop = 0
        ExplicitWidth = 651
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 645
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 70
        Width = 651
        Height = 229
        ExplicitLeft = 0
        ExplicitTop = 70
        ExplicitWidth = 651
        ExplicitHeight = 229
      end
      inherited ToolBar: TToolBar
        Width = 651
        Height = 50
        ButtonWidth = 102
        ExplicitWidth = 651
        ExplicitHeight = 50
        object ToolButton6: TToolButton
          Left = 0
          Top = 0
          Caption = 'Add Customer'
          ImageIndex = 12
        end
        object ToolButton7: TToolButton
          Left = 102
          Top = 0
          Width = 8
          Caption = 'ToolButton7'
          ImageIndex = 5
          Style = tbsSeparator
        end
        object ToolButton1: TToolButton
          Left = 110
          Top = 0
          Caption = 'Create All Orders'
          ImageIndex = 58
        end
        object ToolButton2: TToolButton
          Left = 212
          Top = 0
          Caption = 'Create Single Order'
          ImageIndex = 58
        end
        object ToolButton8: TToolButton
          Left = 314
          Top = 0
          Width = 8
          Caption = 'ToolButton8'
          ImageIndex = 5
          Style = tbsSeparator
        end
        object ToolButton3: TToolButton
          Left = 322
          Top = 0
          Caption = 'Regenerate All'
          ImageIndex = 54
        end
        object ToolButton9: TToolButton
          Left = 424
          Top = 0
          Width = 8
          Caption = 'ToolButton9'
          ImageIndex = 5
          Style = tbsSeparator
        end
        object ToolButton4: TToolButton
          Left = 432
          Top = 0
          Caption = 'Cancel'
          ImageIndex = 3
        end
        object ToolButton5: TToolButton
          Left = 534
          Top = 0
          Caption = 'Help'
          ImageIndex = 24
        end
      end
      inherited StatusBar: TStatusBar
        Top = 299
        Width = 651
        ExplicitTop = 299
        ExplicitWidth = 651
      end
    end
  end
end
