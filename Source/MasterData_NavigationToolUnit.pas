 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit MasterData_NavigationToolUnit;

interface uses
   constantsunit,
   toolboxunit,
   img_storageformunit,
   actionunit,
   //
   windows,
   messages,
   sysutils,
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
   db,
   toolwin,
   ComCtrls;

type
	tAvoBaseDBNavigationTool = class( tToolBar )
   private
   	fDataSet : tDataSet;
      fActionList : tActionList;
      //
      procedure CreateButton(inButtonType: integer);
		function AddNewAction( inActionType : integer; inName : string; inCaption : string; inImageIndex : integer ) : boolean;
      function AssignAction(inType: integer): tAction;
      procedure HandleActionExecute(Sender: TObject);
      procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
      procedure ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
      //
      procedure SetValues( inParent : tWinControl; inDataSet : tDataSet ); overload;
      procedure SetValues( inParent : tWinControl); overload;
	public
      procedure Init( inParent : tWinControl; inDataSet : tDataSet ); overload;
      procedure Init( inParent : tWinControl ); overload;
      procedure Init( inDataSet : tDataSet ); overload;
      //
      Constructor Create( owner : tComponent; inParent : tWinControl ); overload;
      Constructor Create( owner: TComponent; inParent : tWinControl; inDataSet : tDataSet ); overload;
      Destructor Destroy; override;
   end;

implementation

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

// One place to rule all of the values
procedure tAvoBaseDBNavigationTool.SetValues( inParent : tWinControl);
begin
   with Self do
   begin
      Parent := inParent;
      //
      //Align := tAlign(alClient);
      AutoSize := true;
      Caption := 'ToolBar';
      color := clCream;
      ctl3D := true;
      DisabledImages := Img_StorageForm.Disable_Img;
      DockSite := false;
      drawingStyle := dsNormal;
      borderwidth := 0;
      EdgeInner := esNone;
      edgeOuter := esNone;
      flat := true;
//      GradientEndColor := $00D6D6D6;
//      GradientStartColor := clWindow;
      Images := Img_StorageForm.Avobase_ToolBar_Img;
      name := 'AvoBaseToolNavBar';
      Wrapable := false;
      Transparent := true;
      ShowCaptions := True;
      OnCustomDraw := ToolBarCustomDraw;
   end;
end;

procedure tAvoBaseDBNavigationTool.SetValues( inParent : tWinControl; inDataSet : tDataSet );
begin
   fDataSet := inDataSet;
   //
   SetValues( inParent );
end;

// This one just allows creating, must use the Init() method to do the rest
constructor tAvoBaseDBNavigationTool.Create(owner: TComponent; inParent : tWinControl );
begin
   Inherited Create( owner );
   //
   SetValues( inParent );
   //
   fActionList := tActionList.Create( owner );
   fActionList.OnUpdate := ActionList1Update;
   // Create the Actions
   AddNewAction( CMD_FIRST, 'actFirst', 'First', IMG_NAV_FIRST);
   AddNewAction( CMD_PREV, 'actPrev', 'Prev', IMG_NAV_PRIOR);
   AddNewAction( CMD_NEXT, 'actNext', 'Next', IMG_NAV_NEXT);
   AddNewAction( CMD_LAST, 'actLast', 'Last', IMG_NAV_LAST);
   // Create the buttons
   CreateButton(CMD_LAST);
   CreateButton(CMD_NEXT);
   CreateButton(CMD_PREV);
   CreateButton(CMD_FIRST);
end;

// This one allows creation and docking immediately
constructor tAvoBaseDBNavigationTool.Create(owner: TComponent; inParent: tWinControl; inDataSet: tDataSet);
begin
   Inherited Create( owner );
   //
   fDataSet := inDataSet;
   //
   fActionList := tActionList.Create( owner );
   fActionList.OnUpdate := ActionList1Update;
   // Defaults
   self.SetValues( inParent, inDataSet );
   // Create the Actions
   AddNewAction( CMD_FIRST, 'actFirst', 'First', IMG_NAV_FIRST);
   AddNewAction( CMD_PREV, 'actPrev', 'Prev', IMG_NAV_PRIOR);
   AddNewAction( CMD_NEXT, 'actNext', 'Next', IMG_NAV_NEXT);
   AddNewAction( CMD_LAST, 'actLast', 'Last', IMG_NAV_LAST);
   // Create the buttons
   CreateButton(CMD_LAST);
   CreateButton(CMD_NEXT);
   CreateButton(CMD_PREV);
   CreateButton(CMD_FIRST);
   // Show it
   Self.Show();
end;

procedure tAvoBaseDBNavigationTool.Init( inParent : tWinControl );
begin
   // Defaults
   Self.SetValues( inParent );
   // Show it
   Self.Show();
end;

procedure tAvoBaseDBNavigationTool.Init( inDataSet : tDataSet );
begin
   fDataSet := inDataSet;
end;

procedure tAvoBaseDBNavigationTool.Init( inParent : tWinControl; inDataSet : tDataSet );
begin
   fDataSet := inDataSet;
   // Defaults
   Self.SetValues( inParent, inDataSet );
   // Show it
   Self.Show();
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBNavigationTool.CreateButton(inButtonType: integer);
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( Self );
   toolButton.Action := AssignAction( inButtonType );
   toolButton.Left := -1;
   toolButton.Parent := Self;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tAvoBaseDBNavigationTool.AddNewAction( inActionType : integer; inName : string; inCaption : string; inImageIndex : integer ) : boolean;
var
   action : tAction;
begin
   result := true;
   action := tAction.Create( fActionList );
   action.OnExecute := HandleActionExecute;
   action.Tag := inActionType;
   action.Caption := inCaption;
   action.Name := inName;
   action.Enabled := true;
   action.ImageIndex := inImageIndex;
   action.ActionList := fActionList;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

function tAvoBaseDBNavigationTool.AssignAction(inType: integer): tAction;
var
   x : integer;
begin
   result := nil;
   for x := 0 to fActionList.ActionCount -1 do
      if fActionList.Actions[ x ].Tag = inType then
         result := fActionList.Actions[x] as tAction;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

destructor tAvoBaseDBNavigationTool.Destroy;
begin
//	if (fActionList <> NIL) then FreeAndNil(fActionList);
   //
   inherited Destroy;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBNavigationTool.HandleActionExecute(Sender: TObject);
begin
	with Sender as tAction do
   	case Tag of
      	CMD_FIRST :
         begin
         	if (fDataSet.RecNo >= 1) then
               fDataSet.First();
         end;
         CMD_PREV :
         begin
         	if (fDataSet.RecNo >= 1) then
               fDataSet.Prior();
         end;
         CMD_NEXT :
         begin
         	if (fDataSet.RecNo < fDataSet.RecordCount) then
               fDataSet.Next();
         end;
         CMD_LAST :
         begin
         	if (fDataSet.RecNo < fDataSet.RecordCount) then
               fDataSet.Last();
         end;
      end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBNavigationTool.ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
   exit;
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trRebarDontCare);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBaseDBNavigationTool.ActionList1Update(Action: TBasicAction; var Handled: Boolean);
begin
	Handled := true;
   if (fDataSet.State in [dsEdit, dsInsert]) then
      Enabled := false
   else
   	Enabled := true;
end;



end.

