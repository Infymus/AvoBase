inherited Earning_ViewEarningsForm: TEarning_ViewEarningsForm
  Caption = 'Earning_ViewEarningsForm'
  ClientHeight = 539
  ClientWidth = 545
  ExplicitWidth = 553
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 545
    Height = 539
    ExplicitWidth = 447
    ExplicitHeight = 539
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 543
      Height = 537
      ExplicitWidth = 445
      ExplicitHeight = 537
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 543
        ExplicitWidth = 445
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 537
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 543
        Height = 442
        ExplicitWidth = 445
        ExplicitHeight = 442
        object db_nav_dock: TPanel
          Left = 1
          Top = 1
          Width = 541
          Height = 60
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitWidth = 443
        end
      end
      inherited ToolBar: TToolBar
        Width = 543
        ExplicitWidth = 445
      end
      inherited StatusBar: TStatusBar
        Top = 516
        Width = 543
        Panels = <
          item
            Width = 150
          end
          item
            Width = 150
          end>
        ExplicitTop = 516
        ExplicitWidth = 445
      end
    end
  end
end
