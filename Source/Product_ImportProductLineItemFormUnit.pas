 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Product_ImportProductLineItemFormUnit;

interface uses
   constantsunit,
   toolboxunit,
   errorresultunit,
   masterdataunit,
   toolbox_cycletoolboxunit,
   toolbox_orgtoolboxunit,
   avobase_dialogformunit,
   CalculatorFormUnit,
   DiscountFormUnit,
   product_selectformunit,
   toolbox_producttoolboxunit,
   toolbox_preferencetoolboxunit,
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
   Buttons;

type
	tImportProduct_LineItem_Form = class(TForm)
    line_item_panel: TPanel;
      db_ycost: TMaskEdit;
      db_rcost: TMaskEdit;
      db_prodnum: TEdit;
      db_prodname: TEdit;
      db_qty: TEdit;
    procedure line_item_panelClick(Sender: TObject);
   private
   	fLineItemFormHeight : integer;
      fLineNew : boolean;
      fLineNumber : integer;
      //
      eLineClicked : tLineItemEvent;
      eLineDelete : tLineItemEvent;
      eLineUpdate : tLineItemEvent;
      //
      function fGetdb_prodnum : string;
      function fGetdb_prodname : string;
      function fGetdb_qty : integer;
      function fGetdb_ycost : currency;
      function fGetdb_rcost : currency;
      procedure LineItemClicked;
   public
      //
   	property formLineHeight : integer read fLineItemFormHeight;
      property ProdNum : string read fGetdb_prodnum;
      property ProdName : string read fGetdb_prodname;
      property Qty : integer read fGetdb_qty;
      property Ycost : currency read fGetdb_ycost;
      property Rcost : currency read fGetdb_rcost;
      property IsNewLine : boolean read fLineNew write fLineNew;
      property LineNumber : integer read fLineNumber write fLineNumber;
      property OnLineDelete : tLineItemEvent read eLineDelete write eLineDelete;
      property OnLineUpdate : tLineItemEvent read eLineUpdate write eLineUpdate;
      property OnLineClicked : tLineItemEvent read eLineClicked write eLineClicked;
      //
      constructor create( inOwner : tComponent ); override;
   end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

constructor tImportProduct_LineItem_Form.create(inOwner: tComponent);
begin
	inherited create( inOwner );
   //
   fLineItemFormHeight := 25;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function tImportProduct_LineItem_Form.fGetdb_prodname: string;
begin
	result := db_prodname.text;
end;

function tImportProduct_LineItem_Form.fGetdb_prodnum: string;
begin
	result := db_prodnum.text;
end;

function tImportProduct_LineItem_Form.fGetdb_qty: integer;
var
	 qty : integer;
begin
	//
end;

function tImportProduct_LineItem_Form.fGetdb_rcost: currency;
begin
	//
end;

function tImportProduct_LineItem_Form.fGetdb_ycost: currency;
begin
	//
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure tImportProduct_LineItem_Form.LineItemClicked;
begin
   if Assigned(eLineClicked) then
   	eLineClicked( fLineNumber );
end;

procedure tImportProduct_LineItem_Form.line_item_panelClick( Sender: TObject );
begin
	LineItemClicked();
end;

{
procedure tImportProduct_LineItem_Form.OnLineClicked( lineNum: integer);
begin
   if Assigned(eLineClicked) then
   	eLineClicked( fLineNumber );
end;

procedure tImportProduct_LineItem_Form.OnLineDelete( lineNum: integer);
begin
   if Assigned(eLineDelete) then
   	eLineDelete( fLineNumber );
end;

procedure tImportProduct_LineItem_Form.OnLineUpdate( lineNum: integer);
begin
   if Assigned(eLineUpdate) then
   	eLineUpdate( fLineNumber );
end;
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//


end.



