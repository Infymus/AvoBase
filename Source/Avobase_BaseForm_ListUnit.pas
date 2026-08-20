 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

// Encapsulates a Grid, Datasource and NavTool - for quick ease of use for forms that just want to display a list of ... something

unit Avobase_BaseForm_ListUnit;

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
   db,
   jpeg;

type
   tAvobase_BaseForm_List = class(TForm)
    border_panel: TPanel;
    BASE_TOP_CAPTION_PANEL: TPanel;
    BASE_FORM_LABEL: TLabel;
    BASE_TOP_SEP_PANEL: TPanel;
    StatusBar: TStatusBar;
    BASE_NAVBAR_PANEL: TPanel;
    BASE_NAVBAR_DOCK_PANEL: TPanel;
    BASE_LIST_DOCK_PANEL: TPanel;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      fBorder : boolean;
      //
      procedure fSetBorder( inVal : boolean );
      function fGetBorder : boolean;
   public
      dataListGrid : tAvoBaseDBGrid;
      gridDataSource : tDataSource;
      dbNavTool : tAvoBaseDBNavigationTool;
      property ShowBorder : boolean read fGetBorder write fSetBorder;
      constructor Create(AOwner: TComponent; InCaption : string; isTopBarVisble : boolean; isStatBarVisible : boolean); overload;
   end;

  implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TAvobase_BaseForm_List.Create(AOwner: TComponent; InCaption: string; isTopBarVisble, isStatBarVisible: boolean);
Var
   oldHeight : integer;
begin
  inherited create( aOwner );
   // Set up captions and visibility
   Self.Caption := inCaption;
   //Self.BASE_FORM_LABEL.Caption := inCaption;
	Self.BASE_TOP_CAPTION_PANEL.Visible := False;
   Self.StatusBar.Visible := isStatBarVisible;
   Self.Height := self.Height + 50;
   // Create Datasource, List Grids and DB Nav Tools
	gridDataSource := tDataSource.Create(nil);
   dataListGrid := tAvoBaseDBGrid.Create( nil, BASE_LIST_DOCK_PANEL );
   dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL );
   fBorder := false;
end;



procedure TAvobase_BaseForm_List.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeAndNil(GridDataSource);
	FreeAndNil(DataListGrid);
   FreeAndNil(dbNavTool);
   //
   Action := caFree;
end;

procedure tAvobase_BaseForm_List.fSetBorder(inVal: boolean);
begin
   fBorder := inVal;
   if ( fBorder) then
      self.border_panel.BorderWidth := 1
   else
      self.border_panel.BorderWidth := 0;
end;

function tAvobase_BaseForm_List.fGetBorder: boolean;
begin
   result := fBorder;
end;

end.
