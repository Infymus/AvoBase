 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_GroupBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  //
  messages,
  sysutils,
  variants,
  classes,
  graphics,
  controls,
  forms,
  dialogs,
  extctrls,
  stdctrls,
  jpeg;

type
  tAvoBaseGroupBox = class( tForm )
    DockPanel: TPanel;
    TOP_BACK_PANEL: TPanel;
    IMG_PANEL: TPanel;
    PRIMARY_IMAGE: TImage;
    SECONDARY_IMAGE: TImage;
    ORDERS_IMAGE: TImage;
    PREF_IMAGE: TImage;
    REPORTS_IMAGE: TImage;
    HEADER_PANEL: TPanel;
    procedure FormCreate(Sender: TObject);
  public
    FORM_CONST : Integer;
    FORM_GROUP : Integer;
    AVO_GROUPBOX_INITHEIGHT : integer;
    AVO_GROUPBOX_ADDHEIGHT : integer;
  end;

IMPLEMENTATION

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tAvoBaseGroupBox.FormCreate(Sender: TObject);
begin
   ORDERS_IMAGE.Visible := False;
   SECONDARY_IMAGE.Visible := False;
   PREF_IMAGE.Visible := False;
   PRIMARY_IMAGE.Visible := False;
   REPORTS_IMAGE.Visible := False;
   AVO_GROUPBOX_ADDHEIGHT := 0;
   AVO_GROUPBOX_INITHEIGHT := 40;
end;



end.
