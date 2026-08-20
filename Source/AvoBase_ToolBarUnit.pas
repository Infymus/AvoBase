 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_ToolBarUnit;

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
   toolwin,
   ComCtrls;

type
   tAvoBaseToolBar = class( tToolBar )
   private
      procedure ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
   public
   	actionList : tAvoActionList;
      //
      procedure CreateButton( inButtonType : integer );
      procedure CreateButtonSep();
      //
      constructor Create( inParent : tWinControl ); overload;
      destructor Destroy; overload;
   end;

implementation

constructor tAvoBaseToolBar.Create( inParent : tWinControl );
begin
   inherited create( nil );
   //
   actionList := tAvoActionList.Create( nil );
   //
   with self do
   begin
      Parent := inParent;
      AutoSize := true;
      Caption := 'ToolBar';
      color := clRed;
      ctl3D := true;
      DisabledImages := Img_StorageForm.Disable_Img;
      DockSite := false;
      drawingStyle := dsNormal;
      EdgeInner := esNone;
      edgeOuter := esNone;
      flat := true;
      GradientEndColor := $00D6D6D6;
      GradientStartColor := clWindow;
      Images := Img_StorageForm.Avobase_ToolBar_Img;
      name := 'AvoBaseToolBar';
      Wrapable := false;
      Transparent := true;
      ShowCaptions := True;
      OnCustomDraw := ToolBarCustomDraw;
      Align := alClient;
      font.Name := 'Tahoma';
      font.Size := 7;
   end;
   self.Show();
end;

destructor tAvoBaseToolBar.Destroy;
begin
	// free any associated objects
   FreeAndNil( actionList );
   inherited Destroy;
end;

procedure tAvoBaseToolBar.CreateButton(inButtonType: integer);
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( self );
   toolButton.Action := actionList.AssignAction( inButtonType );
   toolButton.Left := -1;
   toolButton.Parent := self;
   toolButton.Cursor := crHandPoint;
end;

procedure tAvoBaseToolBar.CreateButtonSep;
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( self );
   toolButton.Left := -1;
   toolButton.Style := tbsSeparator;
   toolButton.Width := 5;
   toolButton.Parent := self;
end;

procedure tAvoBaseToolBar.ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
var
	eleDetail : tThemedElementDetails;
begin
   exit;
	if (ThemeServices.ThemesEnabled) then
   begin
   	eleDetail := ThemeServices.GetElementDetails(trChevronHot);
      ThemeServices.DrawElement(Sender.Canvas.Handle, eleDetail, Sender.ClientRect);
      ThemeServices.DrawElement(Self.Canvas.Handle, eleDetail, Sender.ClientRect);
   end;
end;

end.
