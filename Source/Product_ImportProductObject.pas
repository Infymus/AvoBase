 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_ImportProductObject;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   inifileunit,
   errorresultunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   //
   Invoice_FEEItem_FormUnit,
   Invoice_FEEItem_NoFormUnit,
   Toolbox_PreferenceToolBoxUnit,
   toolbox_TaxToolBoxUnit,
   Fee_SelectFormUnit,
   Product_ImportProductLineItemFormUnit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   math,
   Contnrs,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   StdCtrls,
   DBTables;

type
	tImportProductObject = class(tObject)
   private
      fDockSite : tScrollBox;
      fLineNumber : integer;
      fOrgID : string;
      fCycleID : string;
      //
      LineItems : tObjectList; // This controls ALL of the item lists
      // ----------------------------------------------------------------------------- //
      // events
      // ----------------------------------------------------------------------------- //
      // GET
      function fGetCount : integer;
      // ----------------------------------------------------------------------------- //
      // SET
      procedure DockSiteScrollBottom;

      procedure HandleLineDeleted( lineNum : integer);
      procedure HandleLineUpdate( lineNum : integer);
      procedure HandleLineClicked( lineNum : integer);
      procedure DoLineColor();
      procedure RenumberLines();
   public
   	// Add New Line
   	function Add() : integer; overload;
      function AddBlankLineItem() : integer;
      // Delete
      procedure DeleteLine;
      // Load / Save
      procedure Load();
      procedure Save();
      function CheckSave : string;
      procedure Clear();
   	// properties
      property Count : integer read fGetCount;
      property OrgID : string read fOrgID write fOrgID;
      property CycleID : string read fCycleID write fCycleID;
      //
      constructor create( inDockPanel : tScrollBox); virtual;
      constructor destroy; virtual;
   end;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tImportProductObject.create( inDockPanel : tScrollBox);
begin
  inherited Create;
  //
  fDockSite := inDockPanel;
  //
  LineItems := tObjectList.Create(True);
end;

constructor tImportProductObject.destroy;
begin
   FreeAndNil( LineItems );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tImportProductObject.Add: integer;
var
   LineItem_Form : tImportProduct_LineItem_Form;
begin
	LineItem_Form := tImportProduct_LineItem_Form.Create( fDockSite );
   fDockSite.Visible := False;
   with LineItem_Form do
   begin
   	Height := formLineHeight;
      ManualDock( fDockSite );
      Visible := True;
      Show();
      Align := alBottom;
      Align := alTop;
      IsNewLine := true;
      LineNumber := LineItems.Count;
      OnLineDelete := HandleLineDeleted;
      OnLineUpdate := HandleLineUpdate;
      OnLineClicked := HandleLineClicked;
   end;
	fDockSite.Visible := true;
   LineItems.Add( LineItem_Form );
   fLineNumber := LineItems.Count - 1;
   result := LineItems.Count - 1;
   DoLineColor();
end;

function tImportProductObject.AddBlankLineItem: integer;
begin
   result := Self.Add();
   DockSiteScrollBottom();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tImportProductObject.CheckSave: string;
begin
   //

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.Clear;
begin
   //

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.DeleteLine;
var
	prevLine : integer;
begin
	if ( LineItems.Count - 1 <> 0 ) then
   begin
   	prevLine := fLineNumber - 1;
   	LineItems.Delete( fLineNumber );
      fLineNumber := prevLine;
      DoLineColor();
      LineItems.Pack();
      RenumberLines();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.DockSiteScrollBottom;
begin
   //

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.RenumberLines;
var
   lineCount : integer;
begin
	for lineCount := 0 to LineItems.Count - 1 do
   	tImportProduct_LineItem_Form(LineItems[ lineCount ]).LineNumber := lineCount;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.DoLineColor;
var
   lineCount : integer;
begin
	for lineCount := 0 to LineItems.Count - 1 do
   	if (lineCount = fLineNumber) then
            tImportProduct_LineItem_Form(LineItems[ lineCount ]).line_item_panel.Color := $00CAFFFF
         else
         	tImportProduct_LineItem_Form(LineItems[ lineCount ]).line_item_panel.Color := clWhite;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tImportProductObject.fGetCount: integer;
begin
   result := LineItems.Count;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.HandleLineClicked(LineNum: integer);
begin
   fLineNumber := LineNum;
   DoLineColor();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.HandleLineDeleted(LineNum: integer);
begin
	//
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.HandleLineUpdate(LineNum: integer);
begin
	//
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProductObject.Load;
begin
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


procedure tImportProductObject.Save;
begin
   //

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.
