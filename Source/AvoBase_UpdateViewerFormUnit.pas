 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)


unit AvoBase_UpdateViewerFormUnit;

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
   ActnList;

type
   TAvoBase_UpdateViewer = class(TForm)
    BackPanel: TPanel;
    Panel4: TPanel;
    ToolBar1: TToolBar;
    okButton: TToolButton;
    Panel3: TPanel;
    TOP_BACK_PANEL: TPanel;
    StatusImage: TImage;
    HeaderMsgPanel: TPanel;
    HeaderLabel: TLabel;
    STATUS_MESSAGE_BACK_PANEL: TPanel;
    rtfEdit: TRichEdit;
    procedure okButtonClick(Sender: TObject);
   private
   public
      constructor create( owner : tComponent ); override;
   end;


implementation

{$R *.dfm}

constructor TAvoBase_UpdateViewer.create(owner: tComponent);
begin
   inherited create( owner );
   //
   if ( FileExists( ExtractFilePath(ParamStr(0)) + '\updates.rtf')) then
   begin
      rtfEdit.Lines.LoadFromFile( ExtractFilePath(ParamStr(0)) + '\updates.rtf');
   end;
end;

procedure TAvoBase_UpdateViewer.okButtonClick(Sender: TObject);
begin
   Close();
end;

end.
