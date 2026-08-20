inherited Customer_ExportSelectTypeForm: TCustomer_ExportSelectTypeForm
  Caption = 'Customer_ExportSelectTypeForm'
  ClientHeight = 195
  ClientWidth = 572
  ExplicitWidth = 574
  ExplicitHeight = 197
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 572
    Height = 195
    ExplicitWidth = 548
    ExplicitHeight = 456
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 570
      Height = 193
      ExplicitWidth = 546
      ExplicitHeight = 454
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 570
        ExplicitWidth = 546
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 570
        Height = 98
        BorderWidth = 5
        Caption = ''
        ExplicitWidth = 546
        ExplicitHeight = 359
        object exportGroup: TRadioGroup
          Left = 5
          Top = 5
          Width = 560
          Height = 88
          Align = alClient
          Caption = 'Customer Export Types'
          TabOrder = 0
          ExplicitLeft = 120
          ExplicitTop = 116
          ExplicitWidth = 185
          ExplicitHeight = 105
        end
      end
      inherited ToolBar: TToolBar
        Width = 570
        ExplicitWidth = 570
      end
      inherited StatusBar: TStatusBar
        Top = 172
        Width = 570
        ExplicitTop = 229
        ExplicitWidth = 570
      end
    end
  end
end
