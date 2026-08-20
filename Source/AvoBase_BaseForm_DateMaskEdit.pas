 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit AvoBase_BaseForm_DateMaskEdit;

interface uses
   masterdataunit,
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   avobase_baseform_menuunit,
   avobase_dialogformunit,
   //
   windows,
   messages,
   sysutils,
   variants,
   classes,
   ActnList,
   Controls,
   StdCtrls,
   ComCtrls,
   Mask,
   graphics,
   forms,
   dialogs,
   extctrls,
   ToolWin;

type
  TAvoDateEdit = class(TForm)
    back_panel: TPanel;
    labelDate: TLabel;
    sDateEdit: TMaskEdit;
    sDatePicker: TDateTimePicker;
    DateTimePicker1: TDateTimePicker;
  private
    { Private declarations }
  public
      //
      constructor Create( Owner : TComponent; inDockPanel : tPanel ); virtual;
      destructor Destroy; override;
  end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TAvoDateEdit.Create(Owner: TComponent; inDockPanel: tPanel);
begin
	inherited Create( owner );
   //
   with Self do
   begin
      Width := back_panel.width;
      height := back_panel.height;
      ManualDock(inDockPanel, nil, alClient);
      BorderStyle := bsNone;
      Left := (Self.Width - inDockPanel.Width) div 2;
      Top := (Self.Height - inDockPanel.Height) div 2;
      WindowState := wsMaximized;
      Anchors := [AkLeft,AkTop,AkRight,AkBottom];
      BorderIcons := [];
      Position := poDefault;
      Align := alClient;
      Show();
   end;
end;

destructor TAvoDateEdit.Destroy;
begin
   //
   inherited;
end;



end.
