 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit HintsUnit;

interface uses
   constantsunit,
   toolboxunit,
   masterdataunit,
   inifileunit,
   avobase_dialogformunit,
   Dialogs,
   typinfo;

type
   tAvoBaseHintTypes = (
      HintProductTabClick = 0
      );

procedure Hints_ShowHint( hintArea : tAvoBaseHintTypes );

implementation

procedure Hints_ShowHint( hintArea : tAvoBaseHintTypes );
var
   hintStringName : string;
   hintString : string;
   hintValue : boolean;
begin
   hintStringName := GetEnumName( TypeInfo( tAvobaseHintTypes ), Integer( hintArea ) );
   hintValue := AvoINIReadBoolean(AVOBASE_NAME, hintStringName, False );
   hintString := '';
   //
   if NOT ( hintValue ) then
   begin
      case hintArea of
         //
         HintProductTabClick:
            hintString := 'AvoBase does not require that you add products before you use them on your orders.\n\n' +
               'Simply add the product on your order and AvoBase will transfer those products to your ' +
               'product database by product number, name and sales cycle - once your order is closed.';
         //
         //
         //
         //
         //
         //
         //
         //
         //
      end;
      //
      AvoBaseDialog('AvoBase Hints', hintString, mtInformation, [mbOk], 0);
      AvoINIWriteBoolean(AVOBASE_NAME, hintStringName, True);
   end;
end;

end.
