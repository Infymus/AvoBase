 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 unit RecordStructureUnit;

interface uses
  classes, constantsunit;

// All AvoBase Record Structures Go Here. THIS IS A TOP LEVEL UNIT.

type
	tDateRecord = record
      fDate : tDateTime;
      fYear : integer;
      fMonth : integer;
      fDay : integer;
      fHour : integer;
      fMin : integer;
      fSec : integer;
      fMilli : integer;
   end;

type
   tErrorResult = record
      errorResult : boolean;
      errorMessage : string;
      AsInteger : integer;
      AsString : string;
      AsBoolean : boolean;
      AsDouble : double;
      AsCurrency : currency;
      AsDateTime : tDateTime;
   end;

type
   tProdRec = Record
      id : string;
      isactive : boolean;
      c_id : string;
      org_id : string;
      num : string;
      qty : integer;
      name : string;
      prodn1 : string;
      prodn2 : string;
      prodn3 : string;
      prodn4 : string;
      descr : string;
      amount : currency;
      sellat : currency;
      rcost : currency;
      scost : currency;
      ycost : currency;
      mTaxID : string;
   end;
   


  
   
   


type
   tLineItemRecord = record
      QTYSold : integer;
      QTYReturned : integer;
      QTYFree : integer;
      AmountTax : currency;
      AmountSubTotal : currency;
      AmountTotal : currency;
   end;
   
type
   tCycleRec = record
      org_id : string;
      org_name : string;
      id : string;
      year : integer;
      num : integer;
      sdate : tDateTime;
      cname : string;
      edate : tDateTime;
      isactive : boolean;
   end;
 
 type
   tTaxRecord1 = record
      Tax : double;
   end;     
   
   type
   tTaxRecord2 = record
      id : string;
      taxID : string;
      Name : string;
      Descr : string;
      Samt : currency;
      Eamt : currency;
      Rate : double;
      isactive : boolean;
      ttype : integer;
   end;
   
   type
   tOrderRec = record
      id : string;
   end;

type
   tCustOrderRec = record
      total_orders : integer;
      total_amount_owed : currency;
      total_amount_paid : currency;
   end;
   
   
   TYPE
  tCustRec = Record
   ID : string;
   ISACTIVE : boolean;
   FNAME : string;
   MNAME : string;
   LNAME : string;
   FULLNAME : string;
   ADDR1 : string;
   ADDR2 : string;
   CITY : string;
   STATE : string;
   ZIP : string;
   CITYSTATEZIP : string;
   PHONEH : string;
   PHONEC : string;
   PHONEW : string;
   BDAY : tDateTime;
   EMAIL : string;
   TAXE : boolean;
   TAXEXID : string;
  end;
  
   type
   tShippingRecord = record
      shipID : string;
      shipAmount : currency;
   end;
   
   
   type
   tPaymentRec = record
      id : string;
      org_id : string;
      order_id : string;
      c_id : string;
      mopdate : tDateTime;
      moptype : integer;
      mopvalue : string;
      mopccexpm : integer;
      mopccexpy : integer;
      mopnoc : string;
      mopcvv : string;
      mopcct : integer;
      mop_rev : boolean;
      amount : currency;
   end;

type
   tReversalRec = record
      id : string;
      org_id : string;
      order_id : string;
      c_id : string;
      rdate : tDateTime;
      rtype : integer;
      mopdate : tDateTime;
      moptype : integer;
      mopvalue : string;
      mopccexpm : integer;
      mopccexpy : integer;
      mopnoc : string;
      mopcvv : string;
      mopcct : integer;
      mop_rev : boolean;
      amount : currency;
   end;

type
   tTransRec = record
      id : string;
      tdate : tDateTime;
      ttime : tDateTime;
      c_stid : string; // customer ID
      c_id : string; // cycleID
      org_id : string; // organization ID
      order_id : string; // order ID
      ttype : integer; // trans type - see tTransTypes
      tmopvalue : string; // mop value - like check #
      tmoptype : integer; // MOP type - see tMethodOfPaymentTypes
      amount : currency;
      disp_msg : string;
   end;
   
type
   vEnResultRec = record
      noKey : boolean;
      exKey : boolean;
   end;
      
type
   tReturnLineItemRecord = record
      QTYSold : integer;
      QTYReturned : integer;
      QTYFree : integer;
      AmountTax : currency;
      AmountSubTotal : currency;
      AmountTotal : currency;
   end;

      type
   tFeeItemRecord = record
      AmountTax : currency;
      AmountSubTotal : currency;
      AmountTotal : currency;
   end;
   
   type
   tExpenseTypeRecord = record
      id : string;
      org_id : string;
      name : string;
      isactive : boolean;
      autoa : boolean;
      descr : string;
      taxded : boolean;
   end;
   
   type
   tEmailFormatMSG = record
      c_id : string; // customer id
      order_id : string; // order_id
      cycle_id : string; // cycle_id
      org_id : string; // org_id
   end;
   
   type
   tEmailRec = record
      id : string;
      c_id : string;
      order_id : string;
      etime : tdatetime;
      edate : tdatetime;
      sdate : tdatetime;
      etype : tEmailTypes;
      status : tEmailStatusTypes;
      ret : integer;
      descr : string;
   end;

type
   tEmailSettings = record
      SMTPS : string;
      SMTPUSER : string;
      SMTPPW : string;
      SMTPF : string;
      SMTPORT : integer;
      SMTPAUTHTYPE : integer;
      ORDBODY : string;
      RETBODY : string;
   end;
   
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

implementation

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.

