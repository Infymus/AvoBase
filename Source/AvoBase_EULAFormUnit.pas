 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

 UNIT  AvoBase_EULAFormUnit;

{ NOTE: YOU MUST REPLACE THE EULA IN THIS FORM WIN THE ONE IN \_CODING\AVOBASE\DOCS }

INTERFACE USES
   windows,
   messages,
   sysutils,
   variants,
   classes,
   graphics,
   controls,
   forms,
   dialogs,
   stdctrls,
   comctrls,
   extctrls,
   buttons,
   inifileunit,
   img_storageformunit,
   toolwin,
   constantsunit,
   toolboxunit,
   ActnList;


const
   EULA_ACCEPT = 1;
   EULA_DECLINE = 2;

TYPE
  tEULAForm = class(TForm)
    BackPanel: TPanel;
    Panel4: TPanel;
    Panel3: TPanel;
    TOP_BACK_PANEL: TPanel;
    StatusImage: TImage;
    HeaderMsgPanel: TPanel;
    HeaderLabel: TLabel;
    STATUS_MESSAGE_BACK_PANEL: TPanel;
    EULAEdit: TRichEdit;
    ToolBar1: TToolBar;
    AcceptButton: TToolButton;
    DeclineButton: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure AcceptButtonClick(Sender: TObject);
    procedure DeclineButtonClick(Sender: TObject);
  PUBLIC
    fResult : Integer;
  end;


function CheckEULA : boolean;

IMPLEMENTATION

{$R *.DFM}

(******************************************************************************************* *)

procedure TEULAForm.FormCreate(Sender: TObject);
begin
   Self.Caption := AVOBASE_NAME + ' EULA';
  EULAEdit.Clear;
  EULAEdit.Lines.Add('AVOBASE End-User Software License Agreement');
  EULAEdit.Lines.Add('');
  EulaEdit.Lines.Add('AVOBASE and related documentation (the "Product") is made available to you under the terms of this ' +
  'AVOBASE  END-USER SOFTWARE LICENSE AGREEMENT (THE "AGREEMENT"). BY CLICKING THE "ACCEPT" BUTTON, OR BY INSTALLING OR ' +
  'USING AVOBASE , YOU ARE CONSENTING TO BE BOUND BY THE AGREEMENT.  IF YOU DO NOT AGREE TO THE TERMS AND CONDITIONS OF ' +
  'THIS AGREEMENT, DO NOT CLICK THE "ACCEPT" BUTTON, AND DO NOT INSTALL OR USE ANY PART OF AVOBASE.');
  EULAEdit.Lines.Add('');
  EulaEdit.Lines.Add('1. LICENSE GRANT. AVOBASE, LLC grants you a non-exclusive license to use the executable code ' +
  'version of the Product.  This Agreement will also govern any software upgrades provided by AVOBASE that replace ' +
  'and/or supplement the original Product, unless such upgrades are accompanied by a separate license, in which case ' +
  'the terms of that license will govern.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('2.  TERMINATION.  If you breach this Agreement your right to use the Product will terminate ' +
  'immediately and without notice, but all provisions of this Agreement except the License Grant (Paragraph 1) will ' +
  'survive termination and continue in effect.  Upon termination, you must destroy copies of the Product.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('3.  PROPRIETARY RIGHTS. AVOBASE, LLC, for itself and on behalf of its licensors, hereby ' +
  'reserves all intellectual property rights in the Product, except for the rights expressly granted in this ' +
  'Agreement.  You may not remove or alter any trademark, logo, copyright, registration keys or other proprietary ' +
  'notice in or on the Product.  This license does not grant you any right to use the trademarks, service marks ' +
  'or logos of AVOBASE, LLC or its licensors.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('4.  DISCLAIMER OF WARRANTY.  THE PRODUCT IS PROVIDED "AS IS" WITH ALL FAULTS.  TO THE EXTENT ' +
  'PERMITTED BY LAW, AVOBASE, LLC AND AVOBASE, LLC LICENSORS HEREBY DISCLAIM ALL WARRANTIES, WHETHER EXPRESS OR ' +
  'IMPLIED, INCLUDING WITHOUT LIMITATION WARRANTIES THAT THE PRODUCT IS FREE OF DEFECTS, MERCHANTABLE, FIT FOR ' +
  'A PARTICULAR PURPOSE AND NON-INFRINGING. YOU BEAR ENTIRE RISK AS TO SELECTING THE PRODUCT FOR YOUR PURPOSES ' +
  'AND AS TO THE QUALITY AND PERFORMANCE OF THE PRODUCT.  THIS LIMITATION WILL APPLY NOTWITHSTANDING THE FAILURE ' +
  'OF ESSENTIAL PURPOSE OF ANY REMEDY. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF IMPLIED ' +
  'WARRANTIES, SO THIS DISCLAIMER MAY NOT APPLY TO YOU.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('5.  LIMITATION OF LIABILITY.  EXCEPT AS REQUIRED BY LAW, AVOBASE, LLC AND ITS DIRECTORS, ' +
  'LICENSORS, CONTRIBUTORS AND AGENTS (COLLECTIVELY, AVOBASE, LLC) WILL NOT BE LIABLE FOR ANY INDIRECT, SPECIAL, ' +
  'INCIDENTAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES ARISING OUT OF OR IN ANY WAY RELATING TO THIS AGREEMENT OR THE ' +
  'USE OF OR INABILITY TO USE THE PRODUCT, INCLUDING WITHOUT LIMITATION DAMAGES FOR LOSS OF GOODWILL, WORK STOPPAGE, ' +
  'LOST PROFITS, LOSS OF DATA, AND COMPUTER FAILURE OR MALFUNCTION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES ' +
  'AND REGARDLESS OF THE THEORY (CONTRACT, TORT OR OTHERWISE) UPON WHICH SUCH CLAIM IS BASED.  THE AVOBASE, LLC ' +
  'COLLECTIVE LIABILITY UNDER THIS AGREEMENT WILL NOT EXCEED THE GREATER OF $500 (FIVE HUNDRED DOLLARS) AND THE ' +
  'FEES PAID BY YOU UNDER THIS LICENSE (IF ANY).  SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF ' +
  'INCIDENTAL, CONSEQUENTIAL OR SPECIAL DAMAGES, SO THIS EXCLUSION AND LIMITATION MAY NOT APPLY TO YOU.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('6.  EXPORT CONTROLS.  This license is subject to all applicable export restrictions. ' +
  'You must comply with all export and import laws and restrictions and regulations of any United States or ' +
  'foreign agency or authority relating to the Product and its use.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('7.  U.S. GOVERNMENT END-USERS.  The Product is a "commercial item," as that term is ' +
  'defined in 48 C.F.R. 2.101, consisting of "commercial computer software" and "commercial computer software ' +
  'documentation," as such terms are used in 48 C.F.R. 12.212 (Sept. 1995) and 48 C.F.R. 227.7202 (June 1995). ' +
  'Consistent with 48 C.F.R. 12.212, 48 C.F.R. 27.405(b)(2) (June 1998) and 48 C.F.R. 227.7202, all U.S. Government ' +
  'End Users acquire the Product with only those rights as set forth herein.');
  EulaEdit.Lines.Add('');
  EulaEdit.Lines.Add('8.  MISCELLANEOUS.  (a) This Agreement constitutes the entire agreement between AVOBASE, ' +
  'LLC and you concerning the subject matter hereof, and it may only be modified by a written amendment signed ' +
  'by an authorized executive of AVOBASE, LLC.  (b) Except to the extent applicable law, if any, provides ' +
  'otherwise, this Agreement will be governed by the laws of the state of California, U.S.A., excluding its ' +
  'conflict of law provisions.  (c) This Agreement will not be governed by the United Nations Convention on ' +
  'Contracts for the International Sale of Goods.  (d) If any part of this Agreement is held invalid or ' +
  'unenforceable, that part will be construed to reflect the parties'' original intent and the remaining ' +
  'portions will remain in full force and effect.  (e) A waiver by either party of any term or condition ' +
  'of this Agreement or any breach thereof, in any one instance, will not waive such term or condition ' +
  'or any subsequent breach thereof.  (f) Except as required by law, the controlling language of this ' +
  'Agreement is English.  (g) You may assign your rights under this Agreement to any party that consents ' +
  'to, and agrees to be bound by, its terms; the AVOBASE, LLC may assign its rights under this Agreement ' +
  'without condition.  (h) This Agreement will be binding upon and will inure to the benefit of the parties, ' +
  'their successors and permitted assigns.');
  //
  EULAEdit.SelStart := 0;
  EULAEdit.SelLength := 0;
  EULAEdit.ScrollBy(0,0);
end;

procedure TEULAForm.AcceptButtonClick(Sender: TObject);
begin
  fResult := EULA_ACCEPT;
  Close;
end;


procedure TEULAForm.DeclineButtonClick(Sender: TObject);
begin
  fResult := EULA_DECLINE;
  Close;
end;


function CheckEULA : boolean;
var
   eulaForm : tEULAForm;
begin
   result := false;
   if (AvoINIReadString(AVOBASE_NAME, 'EULA', 'false') = 'false') then
   begin
      try
         eulaForm := tEULAForm.Create(Application);
         eulaForm.ShowModal();
         if (eulaForm.fResult = EULA_ACCEPT) then
         begin
            AvoINIWriteString(AVOBASE_NAME, 'EULA', 'true');
            result := true;
         end;
      finally
         FreeAndNil(eulaForm);
      end;
   end else
      result := true;
end;


end.


{

AVOBASE End-User Software License Agreement

AVOBASE and related documentation (the "Product") is made available to you under the terms
of this AVOBASE  END-USER SOFTWARE LICENSE AGREEMENT (THE "AGREEMENT").
BY CLICKING THE "ACCEPT" BUTTON, OR BY INSTALLING OR USING AVOBASE , YOU
ARE CONSENTING TO BE BOUND BY THE AGREEMENT.  IF YOU DO NOT AGREE TO THE
TERMS AND CONDITIONS OF THIS AGREEMENT, DO NOT CLICK THE "ACCEPT"
BUTTON, AND DO NOT INSTALL OR USE ANY PART OF AVOBASE.

1. LICENSE GRANT. AVOBASE Software Company grants you a non-exclusive license to use the executable ' +
    'code version of the Product.  This Agreement will also govern any software upgrades provided by ' +
    'AVOBASE that replace and/or supplement the original Product, unless such upgrades are ' +
    'accompanied by a separate license, in which case the terms of that license will govern.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('2.  TERMINATION.  If you breach this Agreement your right to use the Product will terminate ' +
    'immediately and without notice, but all provisions of this Agreement except the License Grant ' +
    '(Paragraph 1) will survive termination and continue in effect.  Upon termination, you must destroy ' +
    'all copies of the Product.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('3.  PROPRIETARY RIGHTS. AVOBASE Software Company, for ' +
    'itself and on behalf of its licensors, hereby reserves all intellectual property rights in the Product, ' +
    'except for the rights expressly granted in this Agreement.  You may not remove or alter any ' +
    'trademark, logo, copyright or other proprietary notice in or on the Product.  This license does not ' +
    'grant you any right to use the trademarks, service marks or logos of AVOBASE Software Company or its ' +
    'licensors.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('4.  DISCLAIMER OF WARRANTY.  THE PRODUCT IS PROVIDED "AS IS" WITH ALL ' +
    'FAULTS.  TO THE EXTENT PERMITTED BY LAW, AVOBASE SOFTWARE COMPANY AND AVOBASE SOFTWARE COMPANY''S ' +
    'LICENSORS HEREBY DISCLAIM ALL WARRANTIES, WHETHER EXPRESS OR IMPLIED, ' +
    'INCLUDING WITHOUT LIMITATION WARRANTIES THAT THE PRODUCT IS FREE OF ' +
    'DEFECTS, MERCHANTABLE, FIT FOR APARTICULAR PURPOSE AND NON-INFRINGING. ' +
    'YOU BEAR ENTIRE RISK AS TO SELECTING THE PRODUCT FOR YOUR PURPOSES AND ' +
    'AS TO THE QUALITY AND PERFORMANCE OF THEPRODUCT.  THIS LIMITATION WILL ' +
    'APPLY NOTWITHSTANDING THE FAILURE OF ESSENTIAL PURPOSE OF ANY REMEDY. ' +
    'SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF IMPLIED ' +
    'WARRANTIES, SO THIS DISCLAIMER MAY NOT APPLY TO YOU.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('5.  LIMITATION OF LIABILITY.  EXCEPT AS REQUIRED BY LAW, AVOBASE SOFTWARE COMPANY AND ITS ' +
    'DIRECTORS, LICENSORS, CONTRIBUTORS AND AGENTS (COLLECTIVELY, AVOBASE ' +
    'LLC) WILL NOT BE LIABLE FOR ANY INDIRECT, SPECIAL, INCIDENTAL, CONSEQUENTIAL ' +
    'OR EXEMPLARY DAMAGES ARISING OUT OF OR IN ANY WAY RELATING TO THIS ' +
    'AGREEMENT OR THE USE OF OR INABILITY TO USE THE PRODUCT, INCLUDING ' +
    'WITHOUT LIMITATION DAMAGES FOR LOSS OF GOODWILL, WORK STOPPAGE, LOST ' +
    'PROFITS, LOSS OF DATA, AND COMPUTER FAILURE OR MALFUNCTION, EVEN IF ' +
    'ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND REGARDLESS OF THE THEORY ' +
    '(CONTRACT, TORT OR OTHERWISE) UPON WHICH SUCH CLAIM IS BASED.  THE ' +
    'AVOBASE SOFTWARE COMPANY COLLECTIVE LIABILITY UNDER THIS AGREEMENT WILL NOT EXCEED ' +
    'THE GREATER OF $500 (FIVE HUNDRED DOLLARS) AND THE FEES PAID BY YOU UNDER ' +
    'THIS LICENSE (IF ANY).  SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR ' +
    'LIMITATION OF INCIDENTAL, CONSEQUENTIAL OR SPECIAL DAMAGES, SO THIS ' +
    'EXCLUSION AND LIMITATION MAY NOT APPLY TO YOU.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('6.  EXPORT CONTROLS.  This license is subject to all applicable export restrictions.  You must ' +
    'comply with all export and import laws and restrictions and regulations of any United States or ' +
    'foreign agency or authority relating to the Product and its use.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('7.  U.S. GOVERNMENT END-USERS.  The Product is a "commercial item," as that term is ' +
    'defined in 48 C.F.R. 2.101, consisting of "commercial computer software" and "commercial ' +
    'computer software documentation," as such terms are used in 48 C.F.R. 12.212 (Sept. 1995) and ' +
    '48 C.F.R. 227.7202 (June 1995). Consistent with 48 C.F.R. 12.212, 48 C.F.R. 27.405(b)(2) (June ' +
    '1998) and 48 C.F.R. 227.7202, all U.S. Government End Users acquire the Product with only ' +
    'those rights as set forth herein.');
  EULAEdit.Lines.Add('');
  EULAEdit.Lines.Add('8.  MISCELLANEOUS.  (a) This Agreement constitutes the entire agreement between AVOBASE ' +
    'Software Company and you concerning the subject matter hereof, and it may only be modified by a written ' +
    'amendment signed by an authorized executive of AVOBASE Software Company.  (b) Except to the extent ' +
    'applicable law, if any, provides otherwise, this Agreement will be governed by the laws of the ' +
    'state of California, U.S.A., excluding its conflict of law provisions.  (c) This Agreement will not be ' +
    'governed by the United Nations Convention on Contracts for the International Sale of Goods.  (d) ' +
    'If any part of this Agreement is held invalid or unenforceable, that part will be construed to reflect ' +
    'the parties'' original intent, and the remaining portions will remain in full force and effect.  (e) A ' +
    'waiver by either party of any term or condition of this Agreement or any breach thereof, in any one ' +
    'instance, will not waive such term or condition or any subsequent breach thereof.  (f) Except as ' +
    'required by law, the controlling language of this Agreement is English.  (g) You may assign your ' +
    'rights under this Agreement to any party that consents to, and agrees to be bound by, its terms; ' +
    'the AVOBASE Software Company Foundation may assign its rights under this Agreement without condition.  (h) ' +
    'This Agreement will be binding upon and will inure to the benefit of the parties, their successors ' +
    'and permitted assigns.');

}

