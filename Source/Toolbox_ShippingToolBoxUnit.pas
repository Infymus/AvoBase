 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Toolbox_ShippingToolBoxUnit;

interface uses
  constantsunit,
  toolboxunit,
  errorresultunit,
  inifileunit,
  recordstructureunit,
  masterdataunit,
  masterdata_BaseDataClassUnit,
  toolbox_taxtoolboxunit,
  //
  db,
  dbtables,
  bde,
  sysutils,
  math,
  classes,
  forms,
  dateutils,
  inifiles,
  stdctrls;



function Shipping_InitRecord : tShippingRecord;
function Shipping_GetShippingAmountByOrgByAmount( inOrgID : string; inAmount : currency ) : tShippingRecord;

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function Shipping_InitRecord : tShippingRecord;
begin
   result.shipID := '';
   result.shipAmount := 0.0;
end;

{======================================================================}

function Shipping_GetShippingAmountByOrgByAmount( inOrgID : string; inAmount : currency ) : tShippingRecord;
var
   fQuery : tQuery;
   dateRec : tDateRecord;
   shipAmt : currency;
   shipPcnt : double;
   sAmt : currency;
   eAmt : currency;
   amtTax : currency;
   sType : integer;
   Pcnt : double;
   Rate : currency;
begin
   result := Shipping_InitRecord;

   //
   shipAmt := 0.00;
   shipPcnt := 0.0;

   //
   fQuery := masterData.GetQuery();
   fQuery.SQL.Text := 'SELECT ORG_ID, ISACTIVE, SAMT, EAMT, PCNT, RATE, STYPE' +
      ' FROM ' + masterData.GetTable_Shipping +
      ' WHERE ORG_ID = ' + masterData.WrapDBID( inOrgID ) +
      ' AND ISACTIVE = TRUE';
   fQuery.Open();

{
            'ID VARCHAR(40), ' +
            'ORG_ID VARCHAR(40), ' +
            'ISACTIVE BOOLEAN, ' +
            'NAME VARCHAR(50), ' +
            'DESCR VARCHAR(200), ' +

            'SAMT MONEY, ' + // start amount
            'EAMT MONEY, ' + // end amount

            'STYPE INTEGER, ' + // TYPE - 1 = $RATE$ - 2 = %PCNT%

            'PCNT FLOAT, ' + // PERCENT if STYPE = 2
            'RATE MONEY, ' + // RATE if STYPE = 1

}

   if (fQuery.RecordCount <> 0) then
   begin
      repeat
         sAmt := fQuery.FieldByName('SAMT').AsCurrency;
         eAmt := fQuery.FieldByName('EAMT').AsCurrency;
         sType := fQuery.FieldByName('STYPE').AsInteger;
         Rate := fQuery.FieldByName('RATE').AsCurrency;
         Pcnt := fQuery.FieldByName('PCNT').AsFloat;

         //
         if (inAmount >= sAmt) AND (inAmount <= eAmt) then
         begin
            case sType of
               integer(tShippingTypes.ShipRate):
               begin
                  shipAmt := shipAmt + Rate;
               end;
               integer(tShippingTypes.ShipPcnt):
               begin
                  shipAmt := shipAmt + (inAmount * Tax_PerformTaxCalculation( Pcnt ));
                  shipAmt := RoundTo( shipAmt, -2); // ug. we round. and round we go.
               end;
            end;
         end;

         //
         fQuery.Next();
      until fQuery.EOF;
   end;

   fQuery.Close();

   //
   FreeAndNil(fQuery);

   //
   result.shipAmount := shipAmt;
end;

{======================================================================}


end.

