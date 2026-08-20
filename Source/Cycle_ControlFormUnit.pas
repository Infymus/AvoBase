 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Cycle_ControlFormUnit;

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
   Cycle_ListFormUnit,
   Cycle_EditFormUnit,
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
	CYCLECONTROL_LIST = 3000;
   CYCLECONTROL_EDIT = 3001;

type
	TControlForm_Cycle = class( tForm )
   	MAIN_DOCK_PANEL: TScrollBox;
      //
      procedure HandleCloseForm(Sender: TObject);
      procedure HandleOnLoadOrderEvent( sender : tObject; inOrderID : string );
   private
      fLoadOrderEvent : tLoadOrderEvent;
      fViewInvoiceEvent : tViewInvoiceEvent;
      fCycleRefreshEvent : tCycleRefreshEvent;
      //
      procedure HandleOnViewInvoiceEvent( sender : tobject; inorderid : string );
      Procedure HandleCycleRefreshEvent();
   public
   	frm_CycleList : tCycleListForm;
      frm_CycleEdit : tCycleEditForm;
		//
      procedure StartForm;
      procedure StopForm;
      procedure GlobalRefreshEvent();
      procedure DockForm(inForm: tForm; inFormType : integer);
      property OnLoadOrderEvent : tLoadOrderEvent read fLoadOrderEvent write fLoadOrderEvent;
      property OnViewOrderInvoice : tViewInvoiceEvent read fViewInvoiceEvent write fViewInvoiceEvent;
      property OnCycleRefreshEvent : tCycleRefreshEvent read fCycleRefreshEvent write fCycleRefreshEvent;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Cycle.DockForm(inForm: tForm; inFormType : integer);
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

procedure TControlForm_Cycle.GlobalRefreshEvent;
begin
   if ( frm_CycleList <> Nil ) then
      frm_CycleList.GlobalRefreshEvent();
end;

procedure TControlForm_Cycle.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    CYCLECONTROL_LIST: frm_CycleList := Nil;
  end;
end;

procedure TControlForm_Cycle.HandleCycleRefreshEvent;
begin
   if Assigned( fCycleRefreshEvent ) then
      fCycleRefreshEvent();
end;

procedure TControlForm_Cycle.HandleOnLoadOrderEvent(sender: tObject; inOrderID: string);
begin
	if Assigned(fLoadOrderEvent) then
   	fLoadOrderEvent( self, inOrderID );
end;

procedure TControlForm_Cycle.HandleOnViewInvoiceEvent(sender: tobject; inorderid: string);
begin
   if Assigned(fViewInvoiceEvent) then
      fViewInvoiceEvent( self, inorderid );
end;

procedure TControlForm_Cycle.StartForm;
begin
	// we need to make sure that if this form is created and NO other forms are showing
	if (frm_CycleList = NIL) then
   begin
   	frm_CycleList := tCycleListForm.Create(Application);
      frm_CycleList.OnLoadOrderEvent := handleOnLoadOrderEvent;
      frm_CycleList.OnViewInvoiceEvent := HandleONViewInvoiceEvent;
      frm_CycleList.OnCycleRefreshEvent := HandleCycleRefreshEvent;
      DockForm( frm_CycleList, CYCLECONTROL_LIST );
   end;

   // now, which one do we show? We always try to show the list, but if an EDIT is up
   if (frm_CycleList <> NIL) then
   	frm_CycleList.Show();
   if (frm_CycleEdit <> NIL) then
   	frm_CycleEdit.Show();
end;

procedure TControlForm_Cycle.StopForm;
begin
	if (frm_CycleList <> NIL) then
   	frm_CycleList.Close();
   if (frm_CycleEdit <> NIL) then
   begin
   	frm_CycleEdit.Show();
      frm_CycleEdit.Close();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.