 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit masterdata_tCustomerObject;

interface

uses
   constantsunit,
   masterdataunit,
   toolboxunit,
   masterdata_updateunit,
   inifileunit,
   errorresultunit,
   masterdata_BaseDataClassUnit,
   //
   bde,
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
   DBTables;

type
   tMasterData_CustomerObject = class( tMasterData_BaseDataClass )
   public
      //
      constructor create( inMasterData: tMasterData); virtual;
   end;

implementation

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

constructor tMasterData_CustomerObject.create(inMasterData: tMasterData);
begin
   inherited create( inMasterData, inMasterData.Gettable_Customer );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

// Properties






end.


