object Customer_NoteListForm: TCustomer_NoteListForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Customer_NoteListForm'
  ClientHeight = 443
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BASEFORM_DOCK: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 443
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object BASEFORM_BACK_PANEL: TPanel
      Left = 1
      Top = 1
      Width = 663
      Height = 441
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object BASE_FORM_TOP_PANEL: TPanel
        Left = 0
        Top = 0
        Width = 663
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 0
        object BASE_FORM_CAPTION_LABEL: TLabel
          Left = 6
          Top = 0
          Width = 657
          Height = 20
          Align = alClient
          Caption = 'BASE_FORM_CAPTION_LABEL'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          ExplicitWidth = 256
          ExplicitHeight = 18
        end
        object BASE_LABEL_SEP_PANEL: TPanel
          Left = 0
          Top = 0
          Width = 6
          Height = 20
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
        end
      end
      object menu_dock_panel: TPanel
        Left = 0
        Top = 20
        Width = 663
        Height = 50
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object LIST_PANEL: TPanel
        Left = 0
        Top = 70
        Width = 316
        Height = 371
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        object StatusBar: TStatusBar
          Left = 0
          Top = 350
          Width = 316
          Height = 21
          Panels = <>
        end
      end
      object right_back_panel: TPanel
        Left = 316
        Top = 70
        Width = 347
        Height = 371
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 347
          Height = 45
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel2'
          TabOrder = 0
          object top_edit_panel: TPanel
            Left = 0
            Top = 0
            Width = 347
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label1: TLabel
              Left = 233
              Top = 1
              Width = 23
              Height = 13
              Caption = 'Date'
            end
            object db_NDESC: TLabeledEdit
              Left = 2
              Top = 16
              Width = 226
              Height = 21
              EditLabel.Width = 122
              EditLabel.Height = 13
              EditLabel.Caption = 'Note Name or Description'
              TabOrder = 0
            end
            object db_date: TDateTimePicker
              Left = 231
              Top = 16
              Width = 111
              Height = 21
              Date = 40974.359159305550000000
              Time = 40974.359159305550000000
              TabOrder = 1
            end
          end
        end
        object EDIT_PANEL: TPanel
          Left = 0
          Top = 45
          Width = 347
          Height = 326
          Align = alClient
          BevelOuter = bvNone
          BiDiMode = bdLeftToRight
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBiDiMode = False
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
end
