 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Brochure_ListFormUnit;

interface uses
   toolboxunit,
   constantsunit,
   masterdataunit,
   inifileunit,
   img_storageformunit,
   errorresultunit,
   actionunit,
   masterdata_basegridunit,
   Avobase_BaseForm_ListUnit,
   Avobase_BaseForm_StandardUnit,
   AvoBase_DialogFormUnit,
   masterdata_navigationtoolunit,
   masterdata_BaseDataClassUnit,
   //
   masterdata_brochurelistunit,
   brochure_editformunit,
   brochure_viewformunit,
   //
   db,
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
   ExtCtrls,
   ComCtrls,
   ToolWin,
   ActnList,
   jpeg;

type
	tBrochureListForm = class(TAvobase_BaseForm_List)
   private
   	frmBrochureEdit : tBrochureEditForm;
      brochureQuery : tMasterData_BaseDataClass;
      brochureListQuery : tMasterDataBrochureList;
      //
   	procedure HandleQueryUpdate(Sender: TObject; Field: TField);
   public
   	procedure BrochureList();
      procedure BrochureNew();
      procedure BrochureEdit();
      procedure BrochureDelete();
      procedure BrochureView();
      procedure BrochureReports;
      procedure BrochureHelp();
      //
      procedure UpdateBrochureQuery();
      constructor Create(owner : tComponent);  overload;
      destructor Destroy; override;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tBrochureListForm.Create(owner: tComponent);
begin
	inherited create( Nil, 'Customers', false, True);
   //
   StatusBar.Panels.Add();
   StatusBar.Panels[0].Width := 100;
   //
   brochureListQuery := tMasterDataBrochureList.Create( masterData);
   //
   brochureQuery := tMasterData_BaseDataClass.create( masterData, masterData.GetTable_Brochure );
   //
   // These items are INHERITED from the AvoBase_BasweForm_StandardUnit
   // DataListGrid, gridDataSource, dbNavTool <-- all inherited
   gridDataSource.DataSet := brochureListQuery;
   gridDataSource.OnDataChange := HandleQueryUpdate;
   //
   DataListGrid.Init( brochureListQuery, 'ID' );
   DataListGrid.Clear;
   DataListGrid.Add(brochureListQuery.FieldByName('ORG'), 'ORG', 100, clRed, [fsBold], taLeftJustify);
   DataListGrid.Add(brochureListQuery.FieldByName('CYCLE'), 'CYCLE', 80, clBlue, [fsBold], taLeftJustify);
   DataListGrid.Add(brochureListQuery.FieldByName('BORDER'), 'BROCHURES', 80, clBlack, [fsBold], taRightJustify);
   DataListGrid.Add(brochureListQuery.FieldByName('AMOUNT'), 'COST', 80, clWebRed, [fsBold], taRightJustify);
   //
   dbNavTool.Init( brochureListQuery );
   //
   UpdateBrochureQuery();
end;

destructor tBrochureListForm.Destroy;
begin

  inherited;
end;

procedure tBrochureListForm.BrochureDelete;
begin
	showmessage('BrochureDelete');
end;

procedure tBrochureListForm.BrochureEdit;
begin
	showmessage('BrochureEdit');

end;

procedure tBrochureListForm.BrochureHelp;
begin
	showmessage('BrochureHelp');

end;

procedure tBrochureListForm.BrochureList;
begin
	showmessage('BrochureList');

end;

procedure tBrochureListForm.BrochureNew;
begin
	showmessage('BrochureNew');

end;

procedure tBrochureListForm.BrochureReports;
begin
	showmessage('BrochureReports');

end;

procedure tBrochureListForm.BrochureView;
begin
	showmessage('BrochureView');

end;


procedure tBrochureListForm.HandleQueryUpdate(Sender: TObject; Field: TField);
begin

end;

procedure tBrochureListForm.UpdateBrochureQuery;
var
	sortDir : string;
   onlyActive : tActiveStates;
begin
{
	if (SortViewComboBox.ItemIndex = 1) then
   	sortDir := 'DESC'
   else
   	sortDir := '';
   //
   case ActiveComboBox.ItemIndex of
   	0 : onlyActive := tActiveStates.stateActive;
   	1 : onlyActive := tActiveStates.stateInactive;
   	2 : onlyActive := tActiveStates.stateAll;
   end;
   //
   }
   onlyActive := tActiveStates.stateActive;
   brochureListQuery.Update('FNAME', sortDir, onlyActive);
end;

end.
