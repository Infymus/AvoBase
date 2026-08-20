 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit AvoBase_BaseForm_MenuUnit;

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
	tAvoBase_BaseForm_Menu = class( tForm )
    BASEFORM_DOCK: TPanel;
    BASEFORM_BACK_PANEL: TPanel;
    BASE_FORM_TOP_PANEL: TPanel;
    BASE_FORM_CAPTION_LABEL: TLabel;
    BASE_LABEL_SEP_PANEL: TPanel;
    BASE_DOCK_PANEL: TPanel;
    ToolBar: TToolBar;
    StatusBar: TStatusBar;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
   protected
      fToolBarAlign : TAlign;
      fFormEvent : tModalResult;
   private
      function fGetFormEvent : tModalResult;
   public
   	actionList : tAvoActionList;
      //
      procedure CreateButton( inButtonType : integer );
      procedure CreateButtonSep();
      //
      property FormResult : TModalResult read fGetFormEvent;
      property ToolBarAlign : TAlign read fToolBarAlign write fToolBarAlign;
      //
      constructor Create( owner: TComponent; InCaption : string; isTopBarVisble : boolean; isStatBarVisible : boolean); overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


// create buttons on the form - NOTE: THEY HAVE TO BE INSERTED BACKWARDS AS IT MAKES THEM ALL AT LEFT.
constructor tAvoBase_BaseForm_Menu.Create(owner: TComponent; InCaption: string; isTopBarVisble: boolean; isStatBarVisible : boolean);
begin
  inherited create( owner );
   //
   actionList := tAvoActionList.Create(self);
   BASE_FORM_TOP_PANEL.Visible := False;
   Self.Caption := inCaption;
   //Self.BASE_FORM_CAPTION_LABEL.Caption := inCaption;
	//Self.BASE_FORM_TOP_PANEL.Visible := isTopBarVisble;
   Self.StatusBar.Visible := isStatBarVisible;
   //if (NOT isStatBarVisible) then self.Height := self.Height - self.StatusBar.Height;
   BASE_DOCK_PANEL.Caption := ''; // null it out at runtime, but we like it at design time
end;

procedure tAvoBase_BaseForm_Menu.CreateButton(inButtonType: integer);
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( ToolBar );
   toolButton.Action := actionList.AssignAction( inButtonType );
   toolButton.Left := -1;
   toolButton.Parent := ToolBar;
end;

procedure tAvoBase_BaseForm_Menu.CreateButtonSep;
var
	toolButton : tToolButton;
begin
	toolButton := tToolButton.Create( ToolBar );
   toolButton.Left := -1;
   toolButton.Style := tbsSeparator;
   toolButton.Width := 5;
   toolButton.Parent := ToolBar;
end;

destructor tAvoBase_BaseForm_Menu.Destroy;
begin
	// free any associated objects
   FreeAndNil( actionList );
   inherited;
end;

function tAvoBase_BaseForm_Menu.fGetFormEvent: tModalResult;
begin
   result := fFormEvent;
end;

procedure TAvoBase_BaseForm_Menu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	// delphi needs to make the form free itself, otherwise you run into access violations.
	Action := caFree;
end;

// This ensures that the menu bar is the color designated by the windows themes.
procedure tAvoBase_BaseForm_Menu.ToolBarCustomDraw(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
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

end.



