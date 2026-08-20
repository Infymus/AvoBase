 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Report_BaseForm;

interface uses
   constantsunit,
   img_storageformunit,
   masterdataunit,
   toolboxunit,
   inifileunit,
   errorresultunit,
   avobase_dialogformunit,
   VerificationUnit,
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
   QuickRpt,
   QRCtrls,
   ExtCtrls;

type
	tAvoBase_ReportBase = class(TForm)
    QReport: TQuickRep;
    Band_Header: TQRBand;
    Band_Title: TQRBand;
    Band_ColumnHeader: TQRBand;
    Band_Detail: TQRBand;
    Band_Summary: TQRBand;
    ReportNameLabel: TQRLabel;
    SalesCycleLabel: TQRLabel;
    ReportLabel: TQRLabel;
    Band_Header_Child1: TQRChildBand;
    Band_Title_Child1: TQRChildBand;
    Band_ColumnHeader_Child1: TQRChildBand;
    InvoiceDateLabel: TQRLabel;
    BAND_Footer: TQRBand;
    ChildBand2: TQRChildBand;
    VersionString: TQRLabel;
    AvoBaseRegLabel: TQRLabel;
    QRImage1: TQRImage;
    procedure Band_DetailAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
   private
      fColorDetailBand : boolean;
   public
      property ColorDetailBand : boolean read fColorDetailBand write fColorDetailBand;
   end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

implementation

{$R *.dfm}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBase_ReportBase.FormCreate(Sender: TObject);
begin
//   InvoiceDateLabel.Caption := 'why you no fix me';
   //DateToStr( Now ) + ' - ' + TimeToStr( Now );
end;

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBase_ReportBase.ChildBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
//var ObjVerf : tKeyVerif;
begin
   VersionString.Caption := AVOBASE_NAME + ' ' + Ver_Num + '   ' + AVOBASE_WEBSITE;
   AvoBaseRegLabel.Caption := '';
   (*
   //
	ObjVerf := tKeyVerif.Create;
	if NOT(ObjVerf.Tk4726TuI) then
	begin
      AvoBaseRegLabel.Caption := #85 + #78 + #82 + #69 + #71 + #73 + #83 + #84 + #69 + #82 + #69 + #68 + #33 +
         #32 + #86 + #105 + #115 + #105 + #116 + #32 + #104 + #116 + #116 + #112 + #58 + #47 + #47 + #119 +
         #119 + #119 + #46 + #97 + #118 + #111 + #98 + #97 + #115 + #101 + #46 + #99 + #111 + #109 + #32 +
         #116 + #111 + #32 + #117 + #110 + #108 + #111 + #99 + #107 + #32 + #102 + #101 + #97 + #116 +
         #117 + #114 + #101 + #115 + #33; {UNREGISTERED! Visit http://www.avobase.com to unlock features!}
      { NOT REGISTERED AT ALL }
   end else
      begin
         {This copy of AvoBase is REGISTERED to }
         AvoBaseRegLabel.Caption := #84 + #104 + #105 + #115 + #32 + #99 + #111 + #112 + #121 + #32 + #111 +
            #102 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #105 + #115 + #32 + #82 + #69 +
            #71 + #73 + #83 + #84 + #69 + #82 + #69 + #68 + #32 + #116 + #111 + #32 +
            objVerf.FIRST_NAME + ' ' + objVerf.LAST_NAME;
         { THEY ARE REGISTERED }
		end;
	{ *** NOW CHECK EXPIRATION DATES FOR WARNINGS *** }
	if (ObjVerf.Tk4726TuI) AND NOT(ObjVerf.Tk4726Tu1) then
	begin
      { THIS VERSION OF AVOBASE IS REGISTERED CORRECTLY - BUT THE KEY HAS EXPIRED }
      if (OBJVerf.EXP) then
      begin
         { REGISTERED, BUT KEY HAS EXPIRED }
         AvoBaseRegLabel.Caption := #82 + #69 + #71 + #73 + #83 + #84 + #82 + #65 + #84 + #73 + #79 +
            #78 + #32 + #69 + #88 + #80 + #73 + #82 + #69 + #68 + #33 + #32 + #86 + #105 + #115 + #105 +
            #116 + #32 + #104 + #116 + #116 + #112 + #58 + #47 + #47 + #119 + #119 + #119 + #46 + #97 +
            #118 + #111 + #98 + #97 + #115 + #101 + #46 + #99 + #111 + #109 + #32 + #116 + #111 + #32 +
            #117 + #110 + #108 + #111 + #99 + #107 + #32 + #102 + #101 + #97 + #116 + #117 + #114 +
            #101 + #115 + #33; {REGISTRATION EXPIRED! Visit http://www.avobase.com to unlock features!}
      end;
   end else
      begin
         if (OBJVerf.ExpDate - NOW <= 30) AND (OBJVerf.ExpDate <> -999) then
         begin
            { THIS VERSION OF AVOBASE IS REGISTERED CORRECTLY - KEY WILL SOON EXPIRE }
            // Here we do nothing.
         end;
      end;
	FreeAndNil(ObjVerf);
   //
   *)
end;



// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

procedure tAvoBase_ReportBase.Band_DetailAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
begin
   if (fColorDetailBand) then
   begin
      if Band_Detail.Color = clWhite
         then Band_Detail.Color := $00DFDFDF
      else
         Band_Detail.Color := clWhite;
   end;
end;

end.
