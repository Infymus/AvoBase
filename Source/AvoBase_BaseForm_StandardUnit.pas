 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_BaseForm_StandardUnit;

interface uses
   toolboxunit,
   constantsunit,
   IMG_StorageFormUnit,
   masterdata_navigationtoolunit,
   MasterData_BaseGridUnit,
   //
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   ActnList,
   StdCtrls,
   ExtCtrls,
   ComCtrls,
   ToolWin,
   db;

type
	tAvobase_BaseForm_Standard = class( tForm )
      BASE_TOP_CAPTION_PANEL: TPanel;
      BASE_FORM_LABEL: TLabel;
      BASE_TOP_SEP_PANEL: TPanel;
      StatusBar: TStatusBar;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   public
      constructor Create(AOwner: TComponent; InCaption : string; isTopBarVisble : boolean; isStatBarVisible : boolean); overload;
   end;

implementation

{$R *.dfm}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

constructor tAvobase_BaseForm_Standard.Create(AOwner: TComponent; InCaption: string; isTopBarVisble: boolean; isStatBarVisible : boolean);
begin
  inherited create( aOwner );
   //
   Self.BASE_FORM_LABEL.Caption := inCaption;
	Self.BASE_TOP_CAPTION_PANEL.Visible := isTopBarVisble;
   Self.StatusBar.Visible := isStatBarVisible;
end;

procedure tAvobase_BaseForm_Standard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.

