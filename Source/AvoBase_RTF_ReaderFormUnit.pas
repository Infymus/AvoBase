 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_RTF_ReaderFormUnit;

INTERFACE USES
   windows,
   messages,
   sysutils,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   comctrls,
   extctrls,
   buttons,
   inifileunit,
   img_storageformunit,
   toolwin,
   constantsunit,
   toolboxunit,
   ActnList,
   jpeg;

type
   tAvoBaseRTFReader = class(TForm)
      BackPanel: TPanel;
      Panel4: TPanel;
      ToolBar1: TToolBar;
      DeclineButton: TToolButton;
      Panel3: TPanel;
      TOP_BACK_PANEL: TPanel;
      StatusImage: TImage;
      HeaderMsgPanel: TPanel;
      HeaderLabel: TLabel;
      STATUS_MESSAGE_BACK_PANEL: TPanel;
      EULAEdit: TRichEdit;
   private
   public
      procedure Open( inFileName : string );
   end;

procedure AvoBase_RTFReader( inFileName : string );

implementation

{$R *.dfm}

procedure AvoBase_RTFReader( inFileName : string );
var
   avoReader : tAvoBaseRTFReader;
begin
   avoReader := tAvoBaseRTFReader.Create( Application );
   avoReader.Open( inFileName );
   FreeAndNil(avoReader);
end;

// ================================================================================================

{ tAvoBaseRTFReader }

procedure tAvoBaseRTFReader.Open(inFileName: string);
begin
   //

end;

// ================================================================================================

end.
