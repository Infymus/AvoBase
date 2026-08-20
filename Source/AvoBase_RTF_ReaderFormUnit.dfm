object AvoBaseRTFReader: TAvoBaseRTFReader
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AvoBase'
  ClientHeight = 532
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BackPanel: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 532
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Caption = 'BackPanel'
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 473
    ExplicitHeight = 560
    object Panel4: TPanel
      Left = 1
      Top = 482
      Width = 474
      Height = 49
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      ExplicitTop = 510
      ExplicitWidth = 471
      object ToolBar1: TToolBar
        Left = 437
        Top = 0
        Width = 37
        Height = 49
        Align = alRight
        AutoSize = True
        ButtonHeight = 50
        ButtonWidth = 37
        Caption = 'ToolBar1'
        DisabledImages = IMG_StorageForm.AvoBase_30x30_DisabledImages
        Images = IMG_StorageForm.Avobase_ToolBar_Img
        ShowCaptions = True
        TabOrder = 0
        ExplicitLeft = 434
        object DeclineButton: TToolButton
          Left = 0
          Top = 0
          Caption = 'Ok'
          ImageIndex = 72
        end
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 474
      Height = 481
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      ExplicitWidth = 471
      ExplicitHeight = 509
      object TOP_BACK_PANEL: TPanel
        Left = 0
        Top = 0
        Width = 474
        Height = 47
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 471
        object StatusImage: TImage
          Left = 0
          Top = 0
          Width = 50
          Height = 47
          Align = alLeft
          Picture.Data = {
            0A544A504547496D61676570030000FFD8FFE000104A46494600010100000100
            010000FFDB004300090607080706090807080A0A090B0D160F0D0C0C0D1B1415
            1016201D2222201D1F1F2428342C242631271F1F2D3D2D3135373A3A3A232B3F
            443F384334393A37FFDB0043010A0A0A0D0C0D1A0F0F1A37251F253737373737
            3737373737373737373737373737373737373737373737373737373737373737
            37373737373737373737373737FFC00011080032003203012200021101031101
            FFC4001B00000202030100000000000000000000000005030601040702FFC400
            34100002010301060502020B0000000000000102030004110506122131415113
            147181912261073215162452628292A1B1D1F0FFC40014010100000000000000
            000000000000000000FFC40014110100000000000000000000000000000000FF
            DA000C03010002110311003F00EE34560900649007735134EA466321BEE0D04D
            5866541BCCC00EE4D2BBED616CBC3F16191BC47DC5DC1900FDCF415E629DAEC3
            090F0718C76A09ECB5AD3AFA79E0B6B80D2C04091191948CF22320641C1E2387
            0ADF0411915CD76DE4B8D364B0D6E0243231B3BAC75527284FA3023F9AAE3B31
            A8F9FB0472727140EA8A28A0AE6DEC67F412DDEE7891D8DCC7752C2464491A9F
            A811D70093EA056E58BA8959118346E03A30E441EBFE3E699DC429710490CAA1
            A3914AB29EA08C1AA7ECCC8F058F929D899F4A9DACE4279B20E28DEE857E281D
            EA3078D6F2463991C3D7A56869936F2A93C0F514EA51BCA0F7A4057CB5FC89C9
            58EFAFBF3FEF412ED1698BAAE9D7BA79C7ED709F0CF6907153F205567F0C3556
            68C5BCD9575FA594F423811F3574725ED83AFE68CEF7B75AE757A8740DBD9B70
            6EDBDF62EA3ED96E0E3FA81F9A0EBC0D14B23BF531A1CF3028A069553D522161
            B5F149CA0D5EDCC2DD84F1E590FA952C3D855B2956D1E96755B058E398C1710C
            A93C1305DEDC7539071D47304762683C47771C76A3C661BC38632294DFDD433B
            4724790F1B7107AA9FF8553B5CB2DA9174E05FEF64F168EDD57FDD2DFD5AD7EF
            411737B76EADCC190807D85037DA3DBA8AD77ECF4D3E6261C0843F403FC4C39F
            A0AAEE9567ABEB9A9C777792492B0E0B9FCA83B28E82AC7A0FE1F14914CEB803
            A5746D2F46B6B08C2C68323ED40AE1D3A758901CF05028AB36076A283341E545
            141A532217E2AA7DAA48913F757E28A28275007202BD5145014514507FFFD9}
          Stretch = True
          Transparent = True
        end
        object HeaderMsgPanel: TPanel
          Left = 50
          Top = 0
          Width = 424
          Height = 47
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 421
          object HeaderLabel: TLabel
            Left = 21
            Top = 17
            Width = 385
            Height = 19
            AutoSize = False
            Caption = 'RTF HEader Label'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
        end
      end
      object STATUS_MESSAGE_BACK_PANEL: TPanel
        Left = 0
        Top = 47
        Width = 474
        Height = 434
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        Caption = 'STATUS_MESSAGE_BACK_PANEL'
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        ExplicitWidth = 471
        ExplicitHeight = 462
        object EULAEdit: TRichEdit
          Left = 5
          Top = 5
          Width = 464
          Height = 424
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Lines.Strings = (
            'TBD.')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          ExplicitWidth = 461
          ExplicitHeight = 452
        end
      end
    end
  end
end
