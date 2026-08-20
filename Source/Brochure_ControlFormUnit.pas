 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Brochure_ControlFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   img_storageformunit,
   avobase_dialogformunit,
   avobase_helpformunit,
   avobase_baseform_menuunit,
   avobase_baseform_standardunit,
   //
   Brochure_ListFormUnit,
   Brochure_EditFormUnit,
	//
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Graphics,
   Controls,
   Forms,
   Dialogs;

const
	BROCHURECONTROL_LIST = 3000;
   BROCHURECONTROL_EDIT = 3001;

type
   tControlForm_Brochure = class(TForm)
      MAIN_DOCK_PANEL: TScrollBox;
   private
      procedure HandleCloseForm(Sender: TObject);
   public
   	frm_BrochureList : tBrochureListForm;
      frm_BrochureEdit : tBrochureEditForm;
      //
      procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Brochure.DockForm(inForm: tForm; inFormType: integer);
begin
	inForm.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   inForm.BorderStyle := bsNone;
   inForm.Left := (MAIN_DOCK_PANEL.Width - MAIN_DOCK_PANEL.Width) div 2;
   inForm.Top := (MAIN_DOCK_PANEL.Height - MAIN_DOCK_PANEL.Height) div 2;
   inForm.WindowState := wsMaximized;
   inForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   inForm.BorderIcons := [];
   inForm.Position := poDefault;
   inForm.OnDestroy := HandleCloseForm;
   inForm.Tag := inFormType;
end;

procedure tControlForm_Brochure.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    BROCHURECONTROL_LIST: frm_BrochureList := Nil;
  end;
end;

procedure tControlForm_Brochure.StartForm;
begin
	// we need to make sure that if this form is created and NO other forms are showing
	if (frm_BrochureList = NIL) then
   begin
   	frm_BrochureList := tBrochureListForm.Create(Application);
      DockForm( frm_BrochureList, BrochureCONTROL_LIST );
   end;

   // now, which one do we show? We always try to show the list, but if an EDIT is up
   if (frm_BrochureList <> NIL) then
   	frm_BrochureList.Show();
   if (frm_BrochureEdit <> NIL) then
   	frm_BrochureEdit.Show();
end;

procedure tControlForm_Brochure.StopForm;
begin

end;

end.
