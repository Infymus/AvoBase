inherited EarningList_EditForm: TEarningList_EditForm
  Caption = 'EarningList_EditForm'
  ClientHeight = 489
  ClientWidth = 835
  ExplicitWidth = 841
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 13
  inherited border_panel: TPanel
    Width = 835
    Height = 489
    ExplicitWidth = 700
    ExplicitHeight = 472
    inherited BASE_TOP_CAPTION_PANEL: TPanel
      Width = 835
      ExplicitWidth = 700
      inherited BASE_FORM_LABEL: TLabel
        Width = 825
      end
    end
    inherited StatusBar: TStatusBar
      Top = 468
      Width = 835
      Panels = <
        item
          Width = 150
        end
        item
          Width = 150
        end>
      ExplicitTop = 451
      ExplicitWidth = 700
    end
    inherited BASE_NAVBAR_PANEL: TPanel
      Width = 835
      ExplicitWidth = 700
      inherited BASE_NAVBAR_DOCK_PANEL: TPanel
        Left = 685
        Width = 150
        Caption = ''
        ExplicitLeft = 550
        ExplicitWidth = 150
      end
    end
    inherited BASE_LIST_DOCK_PANEL: TPanel
      Left = 240
      Width = 595
      Height = 392
      ExplicitLeft = 240
      ExplicitWidth = 460
      ExplicitHeight = 375
    end
    object edit_panel: TPanel
      Left = 0
      Top = 76
      Width = 240
      Height = 392
      Align = alLeft
      BevelOuter = bvNone
      Color = 16444898
      ParentBackground = False
      TabOrder = 4
      ExplicitHeight = 375
    end
  end
end
