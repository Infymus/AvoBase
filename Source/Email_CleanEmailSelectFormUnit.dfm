inherited EmailCleanEmailSelectForm: TEmailCleanEmailSelectForm
  Caption = 'EmailCleanEmailSelectForm'
  ClientHeight = 318
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Height = 318
    ExplicitHeight = 318
    inherited BASEFORM_BACK_PANEL: TPanel
      Height = 316
      ExplicitHeight = 316
      inherited BASE_FORM_TOP_PANEL: TPanel
        ExplicitTop = 0
        inherited BASE_FORM_CAPTION_LABEL: TLabel
          Width = 309
          Height = 20
        end
      end
      inherited BASE_DOCK_PANEL: TPanel
        Top = 20
        Height = 221
        BorderWidth = 4
        Caption = ''
        ExplicitLeft = 0
        ExplicitTop = 20
        ExplicitHeight = 221
        object deletegroupbox: TGroupBox
          Left = 4
          Top = 4
          Width = 307
          Height = 213
          Align = alClient
          Caption = 'Email Delete Categories'
          TabOrder = 0
          object deletelabel: TLabel
            Left = 15
            Top = 23
            Width = 277
            Height = 50
            AutoSize = False
            Caption = 
              'This cleanup utility allows you to delete any Email by Status. A' +
              'ny Status you select below will be deleted from AvoBase. '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object pendingstatlabel: TLabel
            Left = 15
            Top = 72
            Width = 110
            Height = 13
            Caption = 'Email Status Types:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object db_Deleted: TCheckBox
            Left = 24
            Top = 91
            Width = 262
            Height = 17
            Caption = 'Deleted - Emails marked as deleted'
            TabOrder = 0
          end
          object db_pending: TCheckBox
            Left = 24
            Top = 114
            Width = 262
            Height = 17
            Caption = 'Pending - Emails waiting to be sent'
            TabOrder = 1
          end
          object db_sent: TCheckBox
            Left = 24
            Top = 138
            Width = 262
            Height = 17
            Caption = 'Sent - Emails that correctly sent'
            TabOrder = 2
          end
          object db_failed: TCheckBox
            Left = 24
            Top = 161
            Width = 262
            Height = 17
            Caption = 'Failed - Emails that were undeliverable'
            TabOrder = 3
          end
          object db_error: TCheckBox
            Left = 24
            Top = 185
            Width = 262
            Height = 17
            Caption = 'Error - Emails unable to send due to errors'
            TabOrder = 4
          end
        end
      end
      inherited ToolBar: TToolBar
        Top = 241
        Align = alBottom
        ExplicitTop = 241
      end
      inherited StatusBar: TStatusBar
        Top = 295
        ExplicitTop = 295
      end
    end
  end
end
