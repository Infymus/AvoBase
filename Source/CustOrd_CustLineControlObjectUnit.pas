 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)
 
unit CustOrd_CustLineControlObjectUnit;

interface uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   inifileunit,
   errorresultunit,
   avobase_percentformunit,
   avobase_dialogformunit,
   //
   Toolbox_PreferenceToolBoxUnit,
   CustOrd_CustFormUnit,
   //
   bde,
   db,
   Windows,
   Messages,
   SysUtils,
   Variants,
   Classes,
   Contnrs,
   Graphics,
   Controls,
   Forms,
   Dialogs,
   math,
   StdCtrls;

type
	tLineItemControlObject = class(tObject)
   private
      LineItem : tObjectList;
      fLineNumber : integer;
      fDockSite : tScrollBox;
      //
      function fGetLineItemCount : integer;
   public
   	function Add() : integer; overload;
      //
      property Count : integer read fGetLineItemCount;
      //
      constructor create( inDockPanel : tScrollBox); virtual;
      constructor destroy; virtual;
   end;

implementation

// ######################################################################################### //

constructor tLineItemControlObject.create( inDockPanel : tScrollBox);
begin
   inherited Create;
   //
   LineItem := tObjectList.Create(True);
   fDockSite := inDockPanel;
end;

constructor tLineItemControlObject.destroy;
begin
   FreeAndNil( LineItem );
   //
   inherited Free;
end;


// ######################################################################################### //

function tLineItemControlObject.Add: integer;
var
	LineItem_Form : tCustOrd_CustForm;
begin
   LineItem_Form := tCustOrd_CustForm.Create( fDockSite );
   fDockSite.Visible := False;
   with LineItem_Form do
   begin
      // Constructor
      Height := FormHeight;
      ManualDock( fDockSite );
      Visible := True;
      Show();
      Align := alBottom;
      Align := alTop;
      // Events
      //OnLineDelete := Handle_LineItem_LineDelete;
   end;
   fDockSite.Visible := true;
   LineItem.Add( LineItem_Form );
   result := LineItem.Count - 1;
end;

// ######################################################################################### //

function tLineItemControlObject.fGetLineItemCount: integer;
begin
   result := LineItem.Count;
end;


end.
