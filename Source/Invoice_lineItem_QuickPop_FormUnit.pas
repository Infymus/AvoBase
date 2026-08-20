 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
 unit Invoice_lineItem_QuickPop_FormUnit;

interface uses
	Invoice_LineItem_InterfaceUnit,
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   avobase_dialogformunit,
   CalculatorFormUnit,
   DiscountFormUnit,
   RecordStructureUnit,
   product_selectformunit,
   toolbox_producttoolboxunit,
   toolbox_preferencetoolboxunit,
   toolbox_taxtoolboxunit,
	//
   windows,
   messages,
   sysutils,
   forms,
   contnrs,
   classes,
   Variants,
   Graphics,
   Controls,
   Dialogs,
   StdCtrls,
   Mask,
   ExtCtrls,
   Menus,
   Buttons, ComCtrls, ToolWin;

type
   TLineItem_QuickPop = class(TForm)
      InvoceLineBackPanel: TPanel;
      LineItemOnePanel: TPanel;
      descriptionEdit: TLabeledEdit;
      db_prodn1: TLabeledEdit;
      db_prodn2: TLabeledEdit;
      db_prodn3: TLabeledEdit;
      db_prodn4: TLabeledEdit;
      Label1: TLabel;
      backOrderCombo: TComboBox;
      db_taxclasslabel: TLabel;
      db_taxclass: TComboBox;
      BOT_PANEL: TPanel;
      imgAvoName: TImage;
      imgAvoIcon: TImage;
      MOPButtonBar: TToolBar;
      OkButton: TToolButton;
    orgCombo: TComboBox;
    CycleNumComboBox: TComboBox;
    CycleYearComboBox: TComboBox;
    orgLabel: TLabel;
    CycleNumLabel: TLabel;
    campYearLabel: TLabel;
    procedure CycleNumComboBoxChange(Sender: TObject);
   private
      fCycleID : string;
      fID : string;
      fOrderID : string;
      fOrgID : string;
      fBackOrderedType : integer;
      fLineItemCharge : boolean;
      fOrderType : tOrderTypes;
      fTaxRate : currency;
      fProductDesc : string;
      fprodn1 : string;
      fprodn2 : string;
      fprodn3 : string;
      fprodn4 : string;
      fmTaxID : string; // master tax ID
      //
      procedure fSetCycleID(inValue: string);
      procedure fSetBackOrderedType(inValue: integer);
      procedure fSetOrgID(inValue: string);
      procedure fSetProductDesc(inValue: string);
      procedure fSetProductPRODN1(inValue: string);
      procedure fSetProductPRODN2(inValue: string);
      procedure fSetProductPRODN3(inValue: string);
      procedure fSetProductPRODN4(inValue: string);
      procedure fSetmTaxID(inValue: string);
      procedure fSetOrderID( inValue : string );

      //
      function fGetCycleID: string;
      function fGetOrgID: string;
      function fGetBackOrderedType : integer;
      function fGetProductDesc: string;
      function fGetProductPRODN1: string;
      function fGetProductPRODN2: string;
      function fGetProductPRODN3: string;
      function fGetProductPRODN4: string;
      function fGetmTaxID: string;
      function fGetOrderID : string;
      //
      procedure Fill_Cycle_Numbers;
      procedure Fill_Cycle_Years;
      procedure SetOrgProductLabels;
    procedure CycleYearComboBoxChange(Sender: TObject);
    procedure orgComboChange(Sender: TObject);
   public
      property CycleID : string read fGetCycleID write fSetCycleID;
      property OrderID : string read fGetOrderID write fSetOrderID;
      property OrgID : string read fGetOrgID write fSetOrgID;
      property BackOrderType : integer read fGetBackOrderedType write fSetBackOrderedType;
      property ProductPRODN1 : string read fGetProductPRODN1 write fSetProductPRODN1;
      property ProductPRODN2 : string read fGetProductPRODN2 write fSetProductPRODN2;
      property ProductPRODN3 : string read fGetProductPRODN3 write fSetProductPRODN3;
      property ProductPRODN4 : string read fGetProductPRODN4 write fSetProductPRODN4;
      property mTaxID : string read fGetmTaxID write fSetmTaxID;
      //
      constructor create( inOwner : tComponent ); override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Create, Destroy, Startup, Shutdown'}

constructor TLineItem_QuickPop.create(inOwner: tComponent);
begin
   inherited create( inOwner );
   self.Caption := 'AvoBase Product Values';
   //
   backOrderCombo.Clear();
   with backOrderCombo do
   begin
   	Clear();
   	Items.Add('Not Back Ordered');
      Items.Add('Back Ordered');
      Items.Add('Missed Shipment');
      Items.Add('No Longer Available');
      ItemIndex := 0;
	end;
   //
   // Set PROD captions
   db_prodn1.Visible := false;
   db_prodn2.Visible := false;
   db_prodn3.Visible := false;
   db_prodn4.Visible := false;
   //
   // fill in back ordered items
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, '');
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties - SET'}

procedure TLineItem_QuickPop.fSetCycleID(inValue: string);
var
   cycleRec : tCycleRec;
   cnt : integer;
begin
   fCycleID := inValue;
   Fill_Cycle_Years();
   Fill_Cycle_Numbers();
   if ( fCycleID <> '' ) then
   begin
      cycleRec := Cycle_GetCycleByCycleID( fCycleID );
      // Years MUST be first
      Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
      // Numbers MUST be after YEARS
      Cycle_ComboBox_FillCycleNumbersLineItem( Org_GetOrgIDByOrgName(orgCombo.Text), cycleRec.year, CycleNumComboBox );
      // Now set the YEAR correctly
      for cnt := 0 to CycleYearComboBox.Items.Count do
         if ( CycleYearComboBox.Items.Strings[ cnt ] = IntToStr( cycleRec.year ) ) then
            CycleYearComboBox.ItemIndex := cnt;
      // Now set the NUM correctly
      for cnt := 0 to CycleNumComboBox.Items.Count do
         if ( CycleNumComboBox.Items.Strings[ cnt ] = IntToStr( cycleRec.num ) ) then
            CycleNumComboBox.ItemIndex := cnt;
   end;
end;

procedure TLineItem_QuickPop.fSetBackOrderedType(inValue: integer);
begin
   fBackOrderedType := inValue;
   backOrderCombo.ItemIndex := fBackOrderedType;
end;

procedure TLineItem_QuickPop.fSetOrderID(inValue: string);
begin
   fOrderID := inValue;
end;

procedure TLineItem_QuickPop.fSetOrgID(inValue: string);
var
   cnt : integer;
   orgName : string;
begin
   fOrgID := inValue;
   //
   Org_ComboBox_FillActiveOrgs_WithCycles( fOrgID, orgCombo );
   //
   orgName := Org_GetOrgNameByOrgID( fOrgID );
   for cnt := 0 to orgCombo.Items.Count do
      if (orgCombo.Items.Strings[ cnt ] = orgName) then
         orgCombo.ItemIndex := cnt;
   SetOrgProductLabels()
end;

procedure TLineItem_QuickPop.fSetProductDesc(inValue: string);
begin
   fProductDesc := inValue;
   descriptionEdit.Text := fProductDesc;
end;

procedure TLineItem_QuickPop.fSetProductPRODN1(inValue: string);
begin
   fprodn1 := invalue;
   db_prodn1.Text := fprodn1;
end;

procedure TLineItem_QuickPop.fSetProductPRODN2(inValue: string);
begin
   fprodn2 := invalue;
   db_prodn2.Text := fprodn2;
end;

procedure TLineItem_QuickPop.fSetProductPRODN3(inValue: string);
begin
   fprodn3 := invalue;
   db_prodn3.Text := fprodn3;
end;

procedure TLineItem_QuickPop.fSetProductPRODN4(inValue: string);
begin
   fprodn4 := invalue;
   db_prodn4.Text := fprodn4;
end;

procedure TLineItem_QuickPop.fSetmTaxID(inValue: string);
begin
   fmTaxID := inValue;
   //
   Tax_FillTaxSubClassesByTaxClass( db_taxclass, fmTaxID );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Properties - GET'}

function TLineItem_QuickPop.fGetBackOrderedType: integer;
begin

end;

function TLineItem_QuickPop.fGetCycleID: string;
var
   C_ID : string;
   cycleRec : tCycleRec;
begin
   C_ID := '';
   cycleRec := Cycle_InitCycleRecord;
   cycleRec.year := StrToInt( CycleYearComboBox.Text );
   cycleRec.Num := StrToInt( CycleNumComboBox.Text );
   C_ID := Cycle_GetCycleIDByOrgYearNum( orgCombo.Text, cycleRec.Year, cycleRec.Num );
   //
   fCycleID := C_ID;
   result := fCycleID;
end;

function TLineItem_QuickPop.fGetOrderID: string;
begin
   result := fOrderID;
end;

function TLineItem_QuickPop.fGetOrgID: string;
begin
   result := Org_GetOrgIDByOrgName( orgCombo.Text );
end;

function TLineItem_QuickPop.fGetProductDesc: string;
begin
   fProductDesc := descriptionEdit.Text;
   result := fProductDesc;
end;

function TLineItem_QuickPop.fGetProductPRODN1: string;
begin
   fprodn1 := db_prodn1.Text;
   result := fProdn1;
end;

function TLineItem_QuickPop.fGetProductPRODN2: string;
begin
   fprodn2 := db_prodn2.Text;
   result := fProdn2;
end;

function TLineItem_QuickPop.fGetProductPRODN3: string;
begin
   fprodn3 := db_prodn3.Text;
   result := fProdn3;
end;

function TLineItem_QuickPop.fGetProductPRODN4: string;
begin
   fprodn4 := db_prodn4.Text;
   result := fProdn4;
end;

function TLineItem_QuickPop.fGetmTaxID: string;
begin
   fmTaxID := Tax_GetMasterTaxIDByName( db_taxclass.Text );
   //
   result := fmTaxID;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Events'}

procedure TLineItem_QuickPop.orgComboChange(Sender: TObject);
begin
   // Years MUST be first
   Cycle_ComboBox_FillCycleYearsExist( Org_GetOrgIDByOrgName(orgCombo.Text), CycleYearComboBox );
   // Numbers MUST be after YEARS
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

procedure TLineItem_QuickPop.CycleNumComboBoxChange(Sender: TObject);
begin
   //
end;

procedure TLineItem_QuickPop.CycleYearComboBoxChange(Sender: TObject);
begin
   Cycle_ComboBox_FillCycleNumbersExist( Org_GetOrgIDByOrgName(orgCombo.Text), StrToInt(CycleYearComboBox.Text), CycleNumComboBox );
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{$REGION 'Methods and Procedures'}

procedure TLineItem_QuickPop.Fill_Cycle_Numbers;
var
   cnt : integer;
   cNum : integer;
   cycleRec : tCycleRec;
begin
   cycleRec := Cycle_GetCycleByCycleID(fCycleID );
   for cnt := 0 to CycleNumComboBox.Items.Count - 1 do
   begin
      cNum := StrToInt( CycleNumComboBox.Items.Strings[ cnt ] );
      if ( cNum = cycleRec.num )  then
         CycleNumComboBox.ItemIndex := cnt;
   end;
end;

procedure TLineItem_QuickPop.Fill_Cycle_Years;
var
   cnt : integer;
   cYear : integer;
   cycleRec : tCycleRec;
begin
   cycleRec := Cycle_GetCycleByCycleID( fCycleID );
   for cnt := 0 to CycleYearComboBox.Items.Count - 1 do
   begin
      cYear := StrToInt( CycleYearComboBox.Items.Strings[ cnt ] );
      if ( cYear = cycleRec.year )  then
         CycleYearComboBox.ItemIndex := cnt;
   end;
end;

procedure TLineItem_QuickPop.SetOrgProductLabels;
begin
   if ( Org_GetOrgProductSpecialField( fOrgID, 'PRODN1') <> '' ) then
   begin
      db_prodn1.editlabel.Caption := Org_GetOrgProductSpecialField( fOrgID, 'PRODN1');
      db_prodn1.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( fOrgID, 'PRODN2') <> '' ) then
   begin
      db_prodn2.editlabel.Caption := Org_GetOrgProductSpecialField( fOrgID, 'PRODN2');
      db_prodn2.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( fOrgID, 'PRODN3') <> '' ) then
   begin
      db_prodn3.editlabel.Caption := Org_GetOrgProductSpecialField( fOrgID, 'PRODN3');
      db_prodn3.visible := true;
   end;
   if ( Org_GetOrgProductSpecialField( fOrgID, 'PRODN4') <> '' ) then
   begin
      db_prodn4.editlabel.Caption := Org_GetOrgProductSpecialField( fOrgID, 'PRODN4');
      db_prodn4.visible := true;
   end;
end;

{$ENDREGION}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.
