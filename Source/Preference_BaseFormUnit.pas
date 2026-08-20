 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

UNIT  Preference_BaseFormUnit;

interface uses
   constantsunit,
   masterdataunit,
   img_storageformunit,
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
   StdCtrls,
   Buttons,
   INIFiles,
   ExtCtrls,
   ComCtrls,
   DBCtrls,
   Mask,
   Grids,
   DBGrids,
   DB,
   Menus,
   DBTables,
   OleCtrls,
   SHDocVw,
   StdActns,
   jpeg;

const
   PREF_SAVE = 1;
   PREF_CANCEL = 2;
   PREF_HELP = 3;
   PREF_REGISTRATION = 4;
   PREF_GENERALSETTINGS = 5;
   PREF_REPSETTINGS = 6;
   PREF_EMAILSETTINGS = 7;
   PREF_ORGANIZATIONS = 8;
   PREF_ORDERFEES = 9;
   PREF_TAXRATES = 10;
   PREF_SHIPPINGRATES = 11;
   PREF_EARNINGTYPES = 12;
   PREF_EXPENSETYPES = 13;
   PREF_INVOICESETTINGS = 14;
   PREF_PRODUCTSETTINGS = 15;

type
	tPrefBaseForm = class( tForm )
    pref_full_back_panel: TPanel;
    PREF_BACK_PANEL: TPanel;
    PADDING_PANEL: TPanel;
    Pref_Scroll_Box: TScrollBox;
    PREF_TOP_BACK_PANEL: TPanel;
    PREF_HEADER_BACK_PANEL: TPanel;
    PREF_HEADER_LABEL: TLabel;
    pref_image: TImage;
    back_sep_panel: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   protected
      fEvent : tEventHandler;
   private
      Pref_Type : Integer;
      //
      function fGetBorder : integer;
      procedure fSetBorder( inVal : integer );
   public
   	property Border : integer read fGetBorder write fSetBorder;
      property OnEvent : tEventHandler READ fEvent WRITE fEvent;
	  	constructor Create( Owner : TComponent; InPref_Type : Integer ); OVERLOAD;
      destructor Destroy; OVERRIDE;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

CONSTRUCTOR TPrefBaseForm.Create(Owner: TComponent; InPref_Type: Integer );
begin
  { Create It }
  Inherited Create(Owner);
  { Set the Variables }
  Pref_Type := InPref_Type;
  { Set it in EDIT Mode }
  // NOT YET BUT WE WILL   Pref_DataSource.DataSet.Edit;
end;

DESTRUCTOR TPrefBaseForm.Destroy;
begin
  { Destroy The Oject }
  Inherited Destroy;
end;

procedure TPrefBaseForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TPrefBaseForm.fGetBorder : integer;
begin
   result := pref_full_back_panel.BorderWidth;
end;

procedure tPrefBaseForm.fSetBorder(inVal: integer);
begin
   pref_full_back_panel.BorderWidth := inVal;
end;

end.

