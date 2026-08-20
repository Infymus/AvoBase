inherited CycleViewOrderListForm: TCycleViewOrderListForm
  Left = 365
  Top = 11
  Caption = 'CycleViewOrderListForm'
  ClientHeight = 405
  ClientWidth = 601
  ExplicitWidth = 603
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  inherited BASEFORM_DOCK: TPanel
    Width = 601
    Height = 405
    ExplicitWidth = 601
    ExplicitHeight = 405
    inherited BASEFORM_BACK_PANEL: TPanel
      Width = 599
      Height = 403
      ExplicitWidth = 599
      ExplicitHeight = 403
      inherited BASE_FORM_TOP_PANEL: TPanel
        Width = 599
        ExplicitWidth = 599
      end
      inherited BASE_DOCK_PANEL: TPanel
        Width = 599
        Height = 308
        ExplicitWidth = 599
        ExplicitHeight = 308
        object VIEWGRID_DOCK_PANEL: TPanel
          Left = 1
          Top = 55
          Width = 597
          Height = 252
          Align = alBottom
          Caption = 'VIEWGRID_DOCK_PANEL'
          Color = clActiveCaption
          ParentBackground = False
          TabOrder = 0
        end
        object BASE_NAVBAR_PANEL: TPanel
          Left = 1
          Top = -1
          Width = 597
          Height = 56
          Align = alBottom
          BevelOuter = bvNone
          Color = clCream
          TabOrder = 1
          object BASE_NAVBAR_DOCK_PANEL: TPanel
            Left = 497
            Top = 0
            Width = 100
            Height = 56
            Align = alRight
            BevelOuter = bvNone
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
            ExplicitLeft = 445
          end
        end
      end
      inherited ToolBar: TToolBar
        Width = 599
        ExplicitWidth = 599
      end
      inherited StatusBar: TStatusBar
        Top = 382
        Width = 599
        ExplicitTop = 382
        ExplicitWidth = 599
      end
    end
  end
end
