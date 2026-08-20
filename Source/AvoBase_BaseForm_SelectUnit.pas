 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit AvoBase_BaseForm_SelectUnit;

interface uses
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   masterdata_navigationtoolunit,
   MasterData_BaseGridUnit,
   //
   windows,
   messages,
   sysutils,
   db,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   actnlist,
   Themes,
   stdctrls,
   extctrls,
   toolwin,
   ComCtrls;

type
   tAvoBase_BaseForm_Select = class(TForm)
      BASE_BACK_PANEL: TPanel;
      BASE_FORM_TOP_PANEL: TPanel;
      BASE_FORM_CAPTION_LABEL: TLabel;
      BASE_LABEL_SEP_PANEL: TPanel;
      StatusBar: TStatusBar;
      BASE_NAVBAR_PANEL: TPanel;
      BASE_NAVBAR_DOCK_PANEL: TPanel;
      ToolBar: TToolBar;
      BASE_LIST_DOCK_PANEL: TPanel;
      OPTION_DOCK: TPanel;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
   private
      function fGetFormEvent : tModalResult;
   public
      fFormEvent : tModalResult;
      dataListGrid : tAvoBaseDBGrid;
      gridDataSource : tDataSource;
      dbNavTool : tAvoBaseDBNavigationTool;
   	actionList : tAvoActionList;
      //
      procedure CreateButton( inButtonType : integer );
      procedure CreateButtonSep();
      //
      property FormResult : TModalResult read fGetFormEvent;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; isStatBarVisible : boolean); overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor TAvoBase_BaseForm_Select.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; isStatBarVisible : boolean);
begin
  inherited create( owner );
   //
   actionList := tAvoActionList.Create(self);
   gridDataSource := tDataSource.Create(nil);
   dataListGrid := tAvoBaseDBGrid.Create( nil, BASE_LIST_DOCK_PANEL );
   dbNavTool := tAvoBaseDBNavigationTool.Create( nil, BASE_NAVBAR_DOCK_PANEL );
   //
   Self.BASE_FORM_CAPTION_LABEL.Caption := inCaption;
	Self.BASE_FORM_TOP_PANEL.Visible := False;
   Self.Height := self.Height + 50;
   Self.StatusBar.Visible := isStatBarVisible;
   BASE_LIST_DOCK_PANEL.Caption := ''; // null it out at runtime, but we like it at design time
   OPTION_DOCK.Caption := ''; // null it out at runtime, but we like it at design time
   //
   CreateButton( CMD_SELECT_CANCEL );
   CreateButtonSep;
	CreateButton( CMD_SELECT_OK );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAvoBase_BaseForm_Select.CreateButton(inButtonType: integer);
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( ToolBar );
   toolButton.Action := actionList.AssignAction( inButtonType );
   toolButton.Left := -1;
   toolButton.Parent := ToolBar;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAvoBase_BaseForm_Select.CreateButtonSep;
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( ToolBar );
   toolButton.Left := -1;
   toolButton.Style := tbsSeparator;
   toolButton.Width := 5;
   toolButton.Parent := ToolBar;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

destructor TAvoBase_BaseForm_Select.Destroy;
begin
   FreeAndNil(actionList);
   FreeAndNil(GridDataSource);
	FreeAndNil(DataListGrid);
   FreeAndNil(dbNavTool);
   //
   inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TAvoBase_BaseForm_Select.fGetFormEvent: tModalResult;
begin
   result := fFormEvent;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAvoBase_BaseForm_Select.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // DO NOT USE CA-FREE ON THIS... It is a popup MODAL form only that is controlled elsewhere!!!
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TAvoBase_BaseForm_Select.ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
   exit;
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trRebarRoot);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.


