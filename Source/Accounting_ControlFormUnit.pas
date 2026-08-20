 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Accounting_ControlFormUnit;

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
   Accounting_EscrowFormUnit,
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
   StdCtrls;

const
	ACCCONTROL_ESCROW = 1521;

type
   tControlForm_Accounting = class(TForm)
      MAIN_DOCK_PANEL: TScrollBox;
   private
      procedure HandleCloseForm(Sender: TObject);
   public
      frm_AccountingEscrow : tAccountingEscrowForm;
      //
      procedure AccountingEscrow();
      //
      procedure GlobalRefreshEvent();
   	procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tControlForm_Accounting.AccountingEscrow;
begin
	if (frm_AccountingEscrow = NIL) then
   begin
   	frm_AccountingEscrow := tAccountingEscrowForm.Create(Application);
      //
      DockForm( frm_AccountingEscrow, ACCCONTROL_ESCROW );
   end;
   //
   if (frm_AccountingEscrow <> NIL) then
   	frm_AccountingEscrow.Show();
end;

procedure tControlForm_Accounting.DockForm(inForm: tForm; inFormType: integer);
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

procedure tControlForm_Accounting.GlobalRefreshEvent;
begin
   if ( frm_AccountingEscrow <> Nil ) then
      frm_AccountingEscrow.GlobalRefreshEvent();
end;

procedure tControlForm_Accounting.HandleCloseForm(Sender: TObject);
begin
   case tForm(Sender).Tag of
      ACCCONTROL_ESCROW: frm_AccountingEscrow := Nil;
   end;
end;

procedure tControlForm_Accounting.StartForm;
begin
   // We do nothing because it is done outside.
end;

procedure tControlForm_Accounting.StopForm;
begin
	if (frm_AccountingEscrow <> NIL) then
   	frm_AccountingEscrow.Close();
end;

end.
