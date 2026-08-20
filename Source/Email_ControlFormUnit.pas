 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

unit Email_ControlFormUnit;

Interface Uses
   Avobase_Baseform_Standardunit,
   Avobase_Dialogformunit,
   Avobase_Emaildialogformunit,
   Avobase_Helpformunit,
   Avobase_Percentformunit,
   Avobase_Registerdialogformunit,
   Classes,
   Constantsunit,
   Controls,
   Dialogs,
   Email_Cleanemailselectformunit,
   Email_Listformunit,
   Encryptunit,
   Errorresultunit,
   Forms,
   Graphics,
   Idattachmentfile,
   Idbasecomponent,
   Idcomponent,
   Idexplicittlsclientserverbase,
   Idimap4,
   Idiohandler,
   Idiohandlersocket,
   Idiohandlerstack,
   Idiohandlerstream,
   Idmessage,
   Idmessageclient,
   Idserveriohandler,
   Idserveriohandlersocket,
   Idserveriohandlerstack,
   Idsmtp,
   Idsmtpbase,
   Idssl,
   Idsslopenssl,
   Idtcpclient,
   Idtcpconnection,
   Img_Storageformunit,
   Masterdata_Emailqueuelistbycycleidunit,
   Masterdata_Emailqueueunit,
   Masterdataunit,
   Messages,
   Preference_Emailformunit,
   Qrctrls,
   Qrexport,
   Qrpdffilt,
   Qrwebfilt,
   Quickrpt,
   Recordstructureunit,
   Report_Invoiceformunit,
   Report_Returnformunit,
   Sysutils,
   Toolbox_Customertoolboxunit,
   Toolbox_Cycletoolboxunit,
   Toolbox_Emailtoolboxunit,
   Toolbox_Ordertoolboxunit,
   Toolbox_Orgtoolboxunit,
   Toolbox_Preferencetoolboxunit,
   Toolboxunit,
   Variants,
   Verificationunit,
   Windows;


const
	EMAIL_LIST = 1000;
   EMAIL_EDIT = 1001;



type
  TControlForm_Email = class(TForm)
      MAIN_DOCK_PANEL: TScrollBox;
      procedure HandleCloseForm(Sender: TObject);
   private
      eEmailUpdateEvent : tEmailUpdateEvent;
      procedure FormatEmailMessage( VAR intIDMsg : tIDMessage; inData : tEmailFormatMSG);
      function RepCode( inCode : string;  inData: tEmailFormatMSG ) : string;
   public
      frm_EmailList : TEmailListForm;
      //
      procedure EmailRequeue();
      procedure EmailRequeueAll();
      procedure EmailSend();
      procedure EmailSendAll();
      procedure EmailDelete();
      procedure EmailDeleteAll();
      procedure EmailSetting();
      procedure EmailHelp();
      procedure EmailClean();
      procedure EmailCycle( inCycleID : string );
      procedure EmailQueueOrder( InOrderID : string );
      procedure UpdateEmailEvent();
      procedure GlobalRefreshEvent();
      //
      function tygHjehtU88jge: vEnResultRec;
      function Email_ValidateEmailSettings : string;
      function Email_SendSingleEmail( inID : string ): tErrorResult;
      function Email_SendAllEmail : tErrorResult;
      function Email_GenerateEmailFile( inOrderID : string ) : tErrorResult;
      function Check_Prior_EmailInQueue( inOrderID, inCustID : string ) : string;
      //
   	procedure StartForm;
      procedure StopForm;
      procedure DockForm(inForm: tForm; inFormType : integer);
      //
      property OnEmailEvent : tEmailUpdateEvent read eEmailUpdateEvent write eEmailUpdateEvent;
  end;

implementation

{$R *.dfm}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.DockForm(inForm: tForm; inFormType: integer);
begin
	inForm.ManualDock(MAIN_DOCK_PANEL, nil, alClient);
   inForm.BorderStyle := bsNone;
   inForm.Left := (MAIN_DOCK_PANEL.Width - MAIN_DOCK_PANEL.Width) div 2;
   inForm.Top := (MAIN_DOCK_PANEL.Height - MAIN_DOCK_PANEL.Height) div 2;
   inForm.WindowState := wsMaximized;
   inForm.Anchors := [AkLeft,AkTop,AkRight,AkBottom];
   inForm.BorderIcons := [];
   inForm.Position := poDefault;
   inForm.OnDestroy := HandleCloseForm;
   inForm.Tag := inFormType;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.HandleCloseForm(Sender: TObject);
begin
  case tForm(Sender).Tag of
    EMAIL_LIST: frm_EmailList := Nil;
  end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.StartForm;
begin
	if (frm_EmailList = NIL) then
   begin
   	frm_EmailList := TEmailListForm.Create(Application);
      //
      DockForm( frm_EmailList, EMAIL_LIST );
   end;
   //
   if (frm_EmailList <> NIL) then
   	frm_EmailList.Show();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.StopForm;
begin
	if (frm_EmailList <> NIL) then
   	frm_EmailList.Close();
end;

function TControlForm_Email.tygHjehtU88jge: vEnResultRec;
//var ty345Gt : tKeyVerif;
begin
   result.noKey := false;
   result.exKey := false;
   (*
   //
   ty345Gt := tKeyVerif.Create;
   //
   if NOT(ty345Gt.Tk4726TuI) then
      result.noKey := true;
	if (ty345Gt.Tk4726TuI) AND NOT(ty345Gt.Tk4726Tu1) then
      result.exKey := true;
   //
   FreeAndNil(ty345Gt);
   *)
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.UpdateEmailEvent;
begin
	if (frm_EmailList <> NIL) then
      frm_EmailList.UpdateEmailEvent();
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailDelete;
begin
   if ( frm_EmailList.ID <> '' ) then
      if AvoBaseDialog('Delete Email', 'Are you sure you want to delete this Email?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
   begin
      Email_DeleteEmail( frm_EmailList.ID );
      frm_EmailList.GlobalRefreshEvent();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailDeleteAll;
begin
   if ( frm_EmailList.EmailCount <> 0 ) then
      if AvoBaseDialog('Delete All Emails', 'Are you sure you want to delete ALL Emails in your queue?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
   begin
      Email_DeleteAllEmails();
      frm_EmailList.GlobalRefreshEvent();
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailHelp;
begin
   AvoBaseHelp_Execute('ControlForm_Email');
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TControlForm_Email.Check_Prior_EmailInQueue(inOrderID, inCustID : string): string;
var
   emailRec : tEmailRec;
begin
   result := '';
   //
   emailRec := toolbox_emailtoolboxunit.Email_GetEmailStatusByOrderID( inOrderID );
   case emailRec.status of
      EmailPending : result := 'An Email for Order # ' + Order_GetOrderNumberNameByOrderID( inOrderID) +
         ' exists in a Pending State.';
      EmailSent, EmailDeleted, EmailNonExist : result := '';
      EmailFailed, EmailError : result := 'An Email for Order # ' + Order_GetOrderNumberNameByOrderID( inOrderID) +
         ' already exists in a Failed (Error) State.';
   end;
   //
   if ( result <> '' ) then
   begin
      if AvoBaseDialog('Email Already Exists', 'There is an issue that must be resolved first:' + #13 + #13 +
         Order_GetOrderTypeNameByOrderID( inOrderID ) + ' # ' + Order_GetOrderNumberByOrderID( inOrderID ) +
         ' - Customer: ' + Customer_GetCustomerNameByCustID( inCustID ) + #13 + #13 +
         result + #13 + #13 + 'Would you like to delete the old Email and re-create it?', mtWarning, [mbyes, mbno], 0) = mbYes then
      begin
         toolbox_emailtoolboxunit.Email_DeleteEmailByID( emailRec.id );
         result := '';
      end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailRequeue;
begin
   if ( frm_EmailList.Status <> EmailPending ) then
   begin
      if AvoBaseDialog('Requeue Email', 'Requeue this Email to Pending Status?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
         frm_EmailList.Requeue();
   end else
      AvoBaseDialog('Requeue Email Status', 'The Email is already in a Pending Status.', mtInformation, [mbOk], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailRequeueAll;
begin
   if ( frm_EmailList.EmailCount > 0 ) then
   begin
      if AvoBaseDialog('Requeue All Emails', 'Requeue all listed Emails to Pending Status?', mtConfirmation, [mbYes, mbNo], 0) = mbYes then
         frm_EmailList.RequeueAll()
   end else
      AvoBaseDialog('Requeue Email Status', 'There are no Emails to requeue that are in a Sent, Failed or Error state.', mtInformation, [mbOk], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailSend;
var
   errResult : tErrorResult;
   canSend : boolean;
begin
   canSend := true;
   //
   if ( frm_EmailList.Status = EmailSent ) then
      if AvoBaseDialog('Email Already Sent', 'The Email requested has already been sent.\n\n' +
         'Do you wish to send the Email again?', mtConfirmation, [mbyes, mbno], 0) = mbno then
      canSend := false;
   if ( frm_EmailList.Status = EmailDeleted ) then
   begin
      AvoBaseDialog('Email Deleted', 'The Email requested has been deleted. You will need to re-queue the Email first.', mtInformation, [mbok], 0);
      canSend := false;
   end;
   if ( canSend ) then
      if AvoBaseDialog('Send Email', 'Confirm sending of Email?', mtConfirmation, [mbyes, mbno], 0) = mbNo then
         canSend := false;
   //
   if ( canSend ) then
   begin
      errResult := Email_SendSingleEmail( frm_emaillist.ID );
      if ( errResult.errorResult ) then
         AvoBaseDialog('Email Send Error', errResult.errorMessage, mtError, [mbok], 0);
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailSendAll;
var
   errResult : tErrorResult;
   canSend : boolean;
   emailListQuery : tMasterDataEmailList;
begin
   canSend := true;
   //
   emailListQuery := tMasterDataEmailList.Create( masterData );
   emailListQuery.Open();
   if ( emailListQuery.RecordCount = 0 ) then
   begin
      AvoBaseDialog('Email Send Error', 'There are no queued Emails ready to send.', mtInformation, [mbok], 0);
      canSend := false;
   end;
   emailListQuery.Close();
   FreeAndNil( emailListQuery );
   //

   if ( canSend ) then
      if AvoBaseDialog('Send Email', 'Confirm sending of All Emails?', mtConfirmation, [mbyes, mbno], 0) = mbNo then
         canSend := false;
   //
   if ( canSend ) then
   begin
      errResult := Email_SendAllEmail();
      if ( errResult.errorResult ) then
         AvoBaseDialog('Email Send Error', errResult.errorMessage, mtError, [mbok], 0);
   end;

end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailSetting;
begin
   Preference_EmailSettings();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TControlForm_Email.Email_GenerateEmailFile( inOrderID: string): tErrorResult;
var
   invoiceOrder : tReport_InvoiceForm;
   invoiceReturn : tReport_Return;
   emailDir : string;
   emailFileName : string;
   orgID : string;
begin
   result := Error_Init();
   //
   emailDir := Pref_GetEmailDir();
   orgID := Order_GetOrgIDByOrderID( inOrderID );
   //
   case Order_GetOrderTypeByOrderID( inOrderID ) of
      OrdTypeOrder:
      begin
         emailFileName := Org_GetOrgNameByOrgID( orgID ) + 'Invoice' + Order_GetOrderNumberByOrderID( inOrderID ) + '.PDF';
         result.errorMessage := emailFileName;
         //
         if ( FileExists( emailDir + emailFileName )) then
            SysUtils.DeleteFile( emailDir + emailFileName );
         //
         invoiceOrder := tReport_InvoiceForm.create( Application, inOrderID );
         try
            invoiceOrder.QReport.ExportToFilter(TQRPDFDocumentFilter.Create(Pref_GetEmailDir + emailFileName));
         except
            on E:Exception do
            begin
               result.errorResult := true;
               result.errorMessage := E.Message;
            end;
         end;
         FreeAndNil(invoiceOrder);
      end;
      OrdTypeReturn:
      begin
         emailFileName := Org_GetOrgNameByOrgID( orgID ) + 'Return' + Order_GetOrderNumberByOrderID( inOrderID ) + '.PDF';
         result.errorMessage := emailFileName;
         //
         if ( FileExists( emailDir + emailFileName )) then
            SysUtils.DeleteFile( emailDir + emailFileName );
         //
         invoiceReturn := tReport_Return.create( Application, inOrderID );
         try
            invoiceReturn.QReport.ExportToFilter(TQRPDFDocumentFilter.Create(Pref_GetEmailDir + emailFileName));
         except
            on E:Exception do
            begin
               result.errorResult := true;
               result.errorMessage := E.Message;
            end;
         end;
         FreeAndNil(invoiceReturn);
      end;
      else
         begin
            result.errorResult := true;
            result.errorMessage := 'Invalid Order Number';
         end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.GlobalRefreshEvent;
begin
   if assigned( frm_EmailList ) then
      frm_EmailList.GlobalRefreshEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TControlForm_Email.Email_ValidateEmailSettings: string;
var
   emailSettings : tEmailSettings;
begin
   result := '';
   //
   emailSettings := Email_GetEmailSettings();
   //
   with emailSettings do
   begin
      if ( SMTPS = '' ) then
         result := result + 'SMTP Server cannot be blank. ';
      if ( SMTPUSER = '' ) then
         result := result + 'SMTP User Name cannot be blank. ';
      if ( SMTPPW = '' ) then
         result := result + 'SMTP Password cannot be blank. ';
      if ( SMTPF = '' ) then
         result := result + 'SMTP From Address cannot be blank. ';
      if ( SMTPORT = 0 ) then
         result := result + 'SMTP Port cannot be 0. Default is 25. ';
      if ( ORDBODY = '' ) then
         result := result + 'The Invoice Order Body cannot be blank.';
      if ( RETBODY = '' ) then
         result := result + 'The Invoice Return Body cannot be blank.';
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ This will go through the message and replace it with whatever kind neccessary. }
function TControlForm_Email.RepCode( inCode : string;  inData: tEmailFormatMSG ) : string;
var
   custRec : tCustRec;
begin
   result := '';
   //
   custRec := Customer_GetCustomerByCustID( inData.c_id );
   //
   inCode := UpperCase(InCode);
   //
   if ( inCode = '{$CUST_FNAME}' ) then
      result := custRec.FNAME;
   if ( inCode = '{$CUST_MNAME}' ) then
      result := custRec.MNAME;
   if ( inCode = '{$CUST_LNAME}' ) then
      result := custRec.LNAME;
   if ( inCode = '{$CUST_FULLNAME}' ) then
      result := custRec.FULLNAME;
   if ( inCode = '{$CUST_ADDR1}' ) then
      result := custRec.ADDR1;
   if ( inCode = '{$CUST_ADDR2}' ) then
      result := custRec.ADDR2;
   if ( inCode = '{$CUST_CITY}' ) then
      result := custRec.CITY;
   if ( inCode = '{$CUST_STATE}' ) then
      result := custRec.STATE;
   if ( inCode = '{$CUST_CITYSTATEZIP}' ) then
      result := custRec.CITYSTATEZIP;
   if ( inCode = '{$CUST_ZIPPOST}' ) then
      result := custRec.ZIP;
   if ( inCode = '{$CUST_PHONEH}' ) then
      result := custRec.PHONEH;
   if ( inCode = '{$CUST_PHONEC}' ) then
      result := custRec.PHONEC;
   if ( inCode = '{$CUST_PHONEW}' ) then
      result := custRec.PHONEW;
   if ( inCode = '{$ORD_CYCLE}' ) then
      result := Cycle_GetCycleNameByCycleID( inData.cycle_id );
   if ( inCode = '{$ORD_ORG}' ) then
      result := Org_GetOrgNameByOrgID( inData.org_id );
   if ( inCode = '{$ORD_ONUM}' ) then
      result := Order_GetOrderNumberByOrderID( indata.order_id );
   if ( inCode = '{$ORD_ODATE}' ) then
      result := DateToStr(order_GetOrderDateByOrderID( inData.order_id ));
   if ( inCode = '{$ORD_OTYPE}' ) then
      result := Order_GetOrderTypeNameByOrderID( inData.order_id );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.FormatEmailMessage(var intIDMsg: tIDMessage; inData: tEmailFormatMSG);
var
   convertString : String;
   outString : String;
   GlobalDone : Boolean;
   Code : String;
   BackCode : String;
   X : Integer;
   BadCode : Integer;
begin
   GlobalDone := False;
   Code := '';
   //
   if ( Order_GetOrderTypeByOrderID( inData.order_id ) = OrdTypeOrder ) then
      convertString := Pref_GetMemo(tPrefConstants.SMTPORDMSG, '');
   if ( Order_GetOrderTypeByOrderID( inData.order_id ) = OrdTypeReturn ) then
      convertString := Pref_GetMemo(tPrefConstants.SMTPRETMSG, '');
   //
   outString := '';
   BadCode := 0;
   //
   Repeat
      if Length(convertString) >= 1 then
      begin
         if convertString[1] <> '{' then
         begin
            outString := outString + convertString[1];
            Delete(convertString,1,1);
         end else
            begin
               if convertString[2] <> '$' then
               begin
                  outString := outString + convertString[1];
                  Delete(convertString,1,1);
               end else
                  begin
                     X := POS('}', convertString);
                     if X <> 0 then
                     begin
                        Code := Copy(convertString, 1, X);
                        Delete(convertString, 1, x);
                        { We have a code, see if we need to replace it with something else }
                        BackCode := RepCode(Code, inData);
                        if BackCode <> '' then
                           Insert(BackCode, convertString, 1)
                        else
                           outString := outString + Code;
                     end else
                        begin
                           outString := outString + convertString[1];
                           Delete(convertString,1,1);
                        end;
                  end;
            end;
      end;
      // Finish off
      if Length(convertString) <= 0 then
         GlobalDone := True;
      // Just For Test
      Inc(BadCode);
      if BadCode > 99999 then
         GlobalDone := True;
   until (GlobalDone);
   //
   // Now Add It
   intIDMsg.Body.Add(outString);
   //
   // We always add this.
   intIDMsg.Body.Add('');
   intIDMsg.Body.Add('Sent Via ' + AVOBASE_NAME + ' ' + VER_NUM + ' - ' + AVOBASE_WEBSITE);
end;



//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TControlForm_Email.Email_SendSingleEmail( inID : string): tErrorResult;
var
   indySMTP : TIdSMTP;
   indyAttach : TIdAttachmentFile;
   indyMsg : tIDMessage;
   //
   errMsg : string;
   emailDir : string;
   emailRec : tEmailRec;
   emailSettings : tEmailSettings;
   emailFile : string;
   errResult : tErrorResult;
   emFmt : tEmailFormatMSG;
begin
   result := Error_Init;
   errMsg := Email_ValidateEmailSettings();
   //
   if ( errMsg = '' ) then
   begin
      PercentForm_Create('Sending Email - One Moment Please...', 0, 8);
      emailRec := Email_GetEmailRecord( inID );
      emailSettings := Email_GetEmailSettings();
      emailDir := Pref_GetEmailDir();
      //
      PercentForm_Update();
      //
      indySMTP := TIdSMTP.Create( Application );
      indyMsg := tIDMessage.Create( Application );
      //
      //
      PercentForm_Update();
      errResult := Email_GenerateEmailFile( emailRec.order_id );
      emailFile := errResult.errorMessage; // <- the file was put into the errorMessage if NO error
      if ( NOT errResult.errorResult ) then
      begin
         //
         // INDY ATTACHMENT
         //
         indyAttach := TIdAttachmentFile.Create(indyMsg.MessageParts, emailDir + '\' + emailFile);
         indyAttach.FileName := emailFile;
         indyAttach.DisplayName := emailFile;
         indyAttach.ContentType := 'application/pdf';
         indyAttach.ContentDisposition := 'attachment; filename="' + emailFile + '"';
         //
         PercentForm_Update();
         //
         //
         // INDY BODY
         //
         // Now, format the message by the way the person wants
         with emFmt do
         begin
            order_id := emailRec.order_id;
            c_id := emailRec.c_id;
            cycle_id := Cycle_GetCycleIDByOrderID( emailRec.order_id );
            org_id := Order_GetOrgIDByOrderID( emailRec.order_id );
         end;
         FormatEmailMessage( indyMsg, emFmt );
         //
         PercentForm_Update();
         //
         // INDY MESSAGE
         //
         indyMsg.Subject := Org_GetOrgNameByOrgID( emFmt.org_id ) + ' ' +
            Order_GetOrderTypeNameByOrderID( emailRec.order_id ) + ' #' +
            Order_GetOrderNumberNameByOrderID( emailRec.order_id );
         indyMsg.From.Address := emailSettings.SMTPF;
         indyMsg.Recipients.EmailAddresses := Customer_GetEmailByCustID( emailRec.c_id );
         //
         PercentForm_Update();
         //
         // INDY SMTP
         //
         indySMTP.Host := emailSettings.SMTPS;
         indySMTP.Port := emailSettings.SMTPORT;
         //  DO NOT USE BOUNDPORT!!!! -------> indySMTP.BoundPort := emailSettings.SMTPORT; <--- DO NOT USE BOUNDPORT!!!
         indySMTP.UserName := emailSettings.SMTPUSER;
         indySMTP.Password := emailSettings.SMTPPW;
         case emailSettings.SMTPAUTHTYPE of
            integer(EmailAuthDefault): indySMTP.AuthType := satDefault;
            integer(EmailAuthSASL): indySMTP.AuthType := satSASL;
            integer(EmailAuthNone): indySMTP.AuthType := satNone;
         end;
         //
         PercentForm_Update();
         //
         // INDY SEND
         //
         try
            PercentForm_UpdateHeader('SMTP Connecting');
            indySMTP.Connect;
            PercentForm_UpdateHeader('SMTP Sending Email');
            indySMTP.Send(indyMsg);
            PercentForm_UpdateHeader('SMTP Disconnecting');
            indySMTP.Disconnect;
            PercentForm_UpdateHeader('Finishing Email Send - One Moment Please...');
            //
            PercentForm_Update();
         except
            on E: Exception do
            begin
               if (indySMTP.Connected) then
                  indySMTP.Disconnect;
               result.errorResult := true;
               result.errorMessage := errResult.errorMessage;
               Email_SetStatus( inID, EmailError );
               Email_SetRetries( inID, emailRec.ret + 1 );
            end;
         end;
         //
         FreeAndNil( indyAttach );
      end else
         result := errResult;
      //
      FreeAndNil(indyMsg);
      FreeAndNil(indySMTP);
      //
      PercentForm_Update();
      //
      if ( NOT result.errorResult ) then
      begin
         // No error occured in all of the above, so we can mark the id as sent
         Email_SetStatus( inID, EmailSent );
         Email_SetRetries( inID, 0 );
         frm_EmailList.GlobalRefreshEvent();
      end;
      //
      PercentForm_Free();
   end else
      AvoBaseDialog('Email Configuration Error', 'There are issues with your Email Settings:\n\n' +
         errMsg + '\n\nPlease click the Email Settings button to adjust your ' +
         'email settings.', mtError, [mbok], 0);
end;


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

function TControlForm_Email.Email_SendAllEmail: tErrorResult;
var
   indySMTP : TIdSMTP;
   indyAttach : TIdAttachmentFile;
   indyMsg : tIDMessage;
   //
   errMsg : string;
   emailDir : string;
   emailRec : tEmailRec;
   emailSettings : tEmailSettings;
   emailFile : string;
   errResult : tErrorResult;
   emFmt : tEmailFormatMSG;
   emailListQuery : tMasterDataEmailList;
   done : boolean;
   inID : string;
begin
   result := Error_Init;
   errMsg := Email_ValidateEmailSettings();
   //
   if ( errMsg = '' ) then
   begin
      PercentForm_Create('Setting Up Emails...', 0, 1);
      emailSettings := Email_GetEmailSettings();
      //
      //
      // INDY SMTP
      //
      indySMTP := TIdSMTP.Create( Application );
      indySMTP.Host := emailSettings.SMTPS;
      indySMTP.Port := emailSettings.SMTPORT;
      //  DO NOT USE BOUNDPORT!!!! -------> indySMTP.BoundPort := emailSettings.SMTPORT; <--- DO NOT USE BOUNDPORT!!!
      indySMTP.UserName := emailSettings.SMTPUSER;
      indySMTP.Password := emailSettings.SMTPPW;
      case emailSettings.SMTPAUTHTYPE of
         integer(EmailAuthDefault): indySMTP.AuthType := satDefault;
         integer(EmailAuthSASL): indySMTP.AuthType := satSASL;
         integer(EmailAuthNone): indySMTP.AuthType := satNone;
      end;
      PercentForm_UpdateHeader('SMTP Connecting');
      indySMTP.Connect;
      //
      emailListQuery := tMasterDataEmailList.Create( masterData );
      emailListQuery.Open();
      PercentForm_IncreaseTotal( emailListQuery.RecordCount );
      //
      emailDir := Pref_GetEmailDir();
      //
      done := false;
      repeat
         inID := emailListQuery.FieldByName('ID').AsString;
         //
         emailRec := Email_GetEmailRecord( inID );
         //
         indyMsg := tIDMessage.Create( Application );
         //
         errResult := Email_GenerateEmailFile( emailRec.order_id );
         emailFile := errResult.errorMessage; // <- the file was put into the errorMessage if NO error
         if ( NOT errResult.errorResult ) then
         begin
            PercentForm_UpdateHeader('SMTP Setting Up Email');
            //
            // INDY ATTACHMENT
            //
            indyAttach := TIdAttachmentFile.Create(indyMsg.MessageParts, emailDir + '\' + emailFile);
            indyAttach.FileName := emailFile;
            indyAttach.DisplayName := emailFile;
            indyAttach.ContentType := 'application/pdf';
            indyAttach.ContentDisposition := 'attachment; filename="' + emailFile + '"';
            //
            // INDY BODY
            //
            // Now, format the message by the way the person wants
            with emFmt do
            begin
               order_id := emailRec.order_id;
               c_id := emailRec.c_id;
               cycle_id := Cycle_GetCycleIDByOrderID( emailRec.order_id );
               org_id := Order_GetOrgIDByOrderID( emailRec.order_id );
            end;
            FormatEmailMessage( indyMsg, emFmt );
            //
            // INDY MESSAGE
            //
            indyMsg.Subject := Org_GetOrgNameByOrgID( emFmt.org_id ) + ' ' +
               Order_GetOrderTypeNameByOrderID( emailRec.order_id ) + ' #' +
               Order_GetOrderNumberNameByOrderID( emailRec.order_id );
            indyMsg.From.Address := emailSettings.SMTPF;
            indyMsg.Recipients.EmailAddresses := Customer_GetEmailByCustID( emailRec.c_id );
            //
            // INDY SEND
            //
            try
               PercentForm_UpdateHeader('SMTP Sending Email');
               indySMTP.Send(indyMsg);
            except
               on E: Exception do
               begin
                  if (indySMTP.Connected) then
                     indySMTP.Disconnect;
                  result.errorResult := true;
                  result.errorMessage := errResult.errorMessage;
                  Email_SetStatus( inID, EmailError );
                  Email_SetRetries( inID, emailRec.ret + 1 );
               end;
            end;
            //
            FreeAndNil( indyAttach );
         end else
            result := errResult;
         //
         FreeAndNil(indyMsg);
         //
         if ( NOT result.errorResult ) then
         begin
            // No error occured in all of the above, so we can mark the id as sent
            Email_SetStatus( inID, EmailSent );
            Email_SetRetries( inID, 0 );
            frm_EmailList.GlobalRefreshEvent();
         end;
         //
         emailListQuery.Next;
         //
         if ( emailListQuery.EOF ) then
            done := true;
         //
         if ( result.errorResult ) then
            done := true;
            //
            PercentForm_Update();
      until done;
      //
      PercentForm_UpdateHeader('SMTP Disconnecting');
      indySMTP.Disconnect;
      //
      emailListQuery.Close();
      FreeAndNil( emailListQuery );
      FreeAndNil(indySMTP);
      //
      PercentForm_Free();
   end else
      AvoBaseDialog('Email Configuration Error', 'There are issues with your Email Settings:\n\n' +
         errMsg + '\n\nPlease click the Email Settings button to adjust your ' +
         'email settings.', mtError, [mbok], 0);
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

{ This should pop up a menu and give options for what items to delete from the email list. }

procedure TControlForm_Email.EmailClean;
var
   EmailCleanForm : TEmailCleanEmailSelectForm;
   db_CleanDeleted : boolean;
   db_CleanError : boolean;
   db_Cleanfailed : boolean;
   db_Cleanpending : boolean;
   db_Cleansent : boolean;

begin
   EmailCleanForm := TEmailCleanEmailSelectForm.Create( Application );
   EmailCleanForm.ShowModal();
   // grab these before the form gets GCOL'd free
   db_CleanDeleted := EmailCleanForm.CleanDeleted;
   db_CleanError := EmailCleanForm.CleanError;
   db_Cleanfailed := EmailCleanForm.Cleanfailed;
   db_Cleanpending := EmailCleanForm.Cleanpending;
   db_Cleansent := EmailCleanForm.Cleansent;
   //
   if ( EmailCleanForm.CloseAction = actionOK ) then
   begin
      if ( db_CleanDeleted ) then
      begin
         PercentForm_Create('Deleting Deleted Emails - One Moment Please...', 0, 0);
         Email_DeleteEmailsByStatus( EmailDeleted );
         PercentForm_Free();
      end;
      if ( db_CleanError ) then
      begin
         PercentForm_Create('Deleting Error Emails - One Moment Please...', 0, 0);
         Email_DeleteEmailsByStatus( EmailError );
         PercentForm_Free();
      end;
      if ( db_Cleanfailed ) then
      begin
         PercentForm_Create('Deleting Failed Emails - One Moment Please...', 0, 0);
         Email_DeleteEmailsByStatus( EmailFailed );
         PercentForm_Free();
      end;
      if ( db_Cleanpending ) then
      begin
         PercentForm_Create('Deleting Pending Emails - One Moment Please...', 0, 0);
         Email_DeleteEmailsByStatus( EmailPending );
         PercentForm_Free();
      end;
      if ( db_Cleansent ) then
      begin
         PercentForm_Create('Deleting Sent Emails - One Moment Please...', 0, 0);
         Email_DeleteEmailsByStatus( EmailSent );
         PercentForm_Free();
      end;
      //
      frm_EmailList.GlobalRefreshEvent();
   end;
   // DO NOT FREE, it is a CaFREE form. ---> FreeAndNil();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

// This comes from outside the controlform and passes us an ID
procedure TControlForm_Email.EmailQueueOrder(InOrderID: string);
var
   emailError : string;
   wantEmail : boolean;
   custID : string;
   emailID : string;
   errResult : tErrorResult;
begin
   PercentForm_Free();
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#79 + #110 + #108 + #121 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 +
         #114 + #101 + #100 + #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 +
         #102 + #32 + #111 + #102 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 +
         #110 + #32 + #113 + #117 + #101 + #117 + #101 + #32 + #79 + #114 + #100 + #101 + #114 + #32 + #80 +
         #68 + #70 + #32 + #73 + #110 + #118 + #111 + #105 + #99 + #101 + #115 + #32 + #102 + #111 + #114 +
         #32 + #69 + #109 + #97 + #105 + #108 + #105 + #110 + #103 + #46);
      {Only Registered versions of of AvoBase can queue Order PDF Invoices for Emailing.}
      Exit;
   end;
   // check settings
   emailError := Pref_CheckEmailSettings();
   if (  emailError <> '' ) then
   begin
      AvoBaseDialog('Unable To Email Order', 'There is a configuration issue with your Email Settings:' + #13 + #13 +
         emailError + #13 + #13 + 'Please check Settings ~ Email Configuration for details.', mtError, [mbOk], 0);
      exit;
   end;
   // We can send
   wantEmail := true;
   custID := Order_GetCustomerIdByOrderID( inOrderID );
   if ( Customer_GetEmailByCustID( custID ) = '' ) then
   begin
      AvoBaseDialog('Invalid Customer Email', 'Customer ' + Customer_GetCustomerNameByCustID( custID ) +
         ' does not have a valid Email address.' + #13 + #13 +
         'Please edit this Customer and add a valid Email address.', mtError, [mbOk], 0);
      wantEmail := False;
   end;
   if ( Order_GetOrderStatusByOrderID( inOrderID ) <> OrderStatusOpen ) then
      if AvoBaseDialog('Order/Return Closed Warning',
         Order_GetOrderTypeNameByOrderID( inOrderID ) + ' # ' +
         Order_GetOrderNumberByOrderID( inOrderID ) + ' is marked as Closed.' + #13 + #13 +
         'Are you sure you want to Email a Closed ' + Order_GetOrderTypeNameByOrderID( inOrderID ) +
         '?', mtWarning, [mbyes, mbNo], 0) = mbNo then
            wantEmail := false;
   //
   if ( wantEmail ) then
      if AvoBaseDialog('Confirm Email Creation',
         'Create an Email for ' + Order_GetOrderTypeNameByOrderID( inOrderID ) + ' # ' +
         Order_GetOrderNumberByOrderID( inOrderID ) + '?', mtConfirmation, [mbyes, mbno], 0) = mbNO then
      wantEmail := false;
   // check to see if the incomming already exists, all is handled by the check, we do nothing here.
   emailError := Check_Prior_EmailInQueue( InOrderID, custID );
   if ( emailError <> '' ) then
      wantEmail := false;
   // Ok, finally
   if ( wantEmail ) then
   begin
      errResult := Email_ValidateDropDirectory();
      if ( errResult.errorResult ) then
         Error_Log( errResult, true)
      else
         begin
            Email_CreateOrderEmail( inOrderID,  Order_GetCustomerIdByOrderID( inOrderID ));
            //
            AvoBaseDialog('Email Queued', 'An Email has been queued.' + #13 + #13 + 'You will need to send the Email in the Email Manager.', mtInformation, [mbok], 0);
            //
            if Assigned( eEmailUpdateEvent ) then
               eEmailUpdateEvent();
         end;
   end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

procedure TControlForm_Email.EmailCycle(inCycleID: string);
var
   emailError : string;
   wantEmail : boolean;
   errResult : tErrorResult;
   emailQuery : tMasterDataEmailQueueListByCycleID;
   fOrderID : string;
   fCustID : string;
begin
   if ( tygHjehtU88jge.noKey ) OR ( tygHjehtU88jge.exKey ) then
   begin
      PercentForm_Free();
      AvoBaseRegisterDialog(#79 + #110 + #108 + #121 + #32 + #82 + #101 + #103 + #105 + #115 + #116 + #101 +
         #114 + #101 + #100 + #32 + #118 + #101 + #114 + #115 + #105 + #111 + #110 + #115 + #32 + #111 +
         #102 + #32 + #111 + #102 + #32 + #65 + #118 + #111 + #66 + #97 + #115 + #101 + #32 + #99 + #97 +
         #110 + #32 + #113 + #117 + #101 + #117 + #101 + #32 + #79 + #114 + #100 + #101 + #114 + #32 + #80 +
         #68 + #70 + #32 + #73 + #110 + #118 + #111 + #105 + #99 + #101 + #115 + #32 + #102 + #111 + #114 +
         #32 + #69 + #109 + #97 + #105 + #108 + #105 + #110 + #103 + #46);
      {Only Registered versions of of AvoBase can queue Order PDF Invoices for Emailing.}
      Exit;
   end;

   // Validate email drop directory
   errResult := Email_ValidateDropDirectory();
   if ( errResult.errorResult ) then
   begin
      Error_Log( errResult, true);
      exit;
   end;

   // check settings
   emailError := Pref_CheckEmailSettings();
   if (  emailError <> '' ) then
   begin
      AvoBaseDialog('Unable To Email Order', 'There is a configuration issue with your Email Settings:' + #13 + #13 +
         emailError + #13 + #13 + 'Please check Settings ~ Email Configuration for details.', mtError, [mbOk], 0);
      exit;
   end;

   // Bring in our query
   emailQuery :=  tMasterDataEmailQueueListByCycleID.Create( masterData, inCycleID );
   emailQuery.Open();

   // Are there any records?
   if ( emailQuery.RecordCount = 0 ) then
   begin
      FreeAndNil( emailQuery );
      AvoBaseDialog('Unable To Email', 'There are no Orders or Returns in Sales Cycle ' +
         Cycle_GetCycleNameByCycleID( inCycleID) + '.', mtError, [mbOk], 0);
      exit;
   end;

   // Go through the count
   EmailPercentForm_Create('Email Processing - One Moment Please...', 0, emailQuery.RecordCount);

   repeat
      fOrderID := emailQuery.FieldByName('ID').AsString;
      fCustID := emailQuery.FieldByName('C_STID').AsString;

      // Set to Send
      wantEmail := true;

      // Validate customer Email
      if ( Customer_GetEmailByCustID( fCustID ) = '' ) then
      begin
         EmailPercentForm_Memo('* Email for ' + Customer_GetCustomerNameByCustID( fCustID ) +
            ' - ' + Order_GetOrderTypeNameByOrderID( fOrderID ) + ' # ' +
               Order_GetOrderNumberByOrderID( fOrderID ) + ' does not have a valid Email address. ' +
               'Email not generated.');
         wantEmail := False;
      end;

      // Validate order Status
      if ( Order_GetOrderStatusByOrderID( fOrderID ) <> OrderStatusOpen ) then
      begin
         if AvoBaseDialog('Order/Return Closed Warning', Order_GetOrderTypeNameByOrderID( fOrderID ) + ' # ' +
            Order_GetOrderNumberByOrderID( fOrderID ) + ' is marked as Closed.' + #13 + #13 +
            Order_GetOrderTypeNameByOrderID( fOrderID ) + ' # ' + Order_GetOrderNumberByOrderID( fOrderID ) +
            ' - Customer: ' + Customer_GetCustomerNameByCustID( fCustID ) + #13 + #13 +
            'Are you sure you want to Email a Closed ' + Order_GetOrderTypeNameByOrderID( fOrderID ) +
            '?', mtWarning, [mbyes, mbNo], 0) = mbNo then
         begin
            wantEmail := false;
            EmailPercentForm_Memo('* Email for ' + Customer_GetCustomerNameByCustID( fCustID ) +
            ' - ' + Order_GetOrderTypeNameByOrderID( fOrderID ) + ' # ' +
               Order_GetOrderNumberByOrderID( fOrderID ) + ' is Closed. Email not generated.');
         end;
      end;

      // check to see if the incomming already exists, all is handled by the check, we do nothing here.
      emailError := Check_Prior_EmailInQueue( fOrderID, fCustID );
      if ( emailError <> '' ) then
      begin
         EmailPercentForm_Memo('* ' + emailError + ' Email not generated.');
         wantEmail := false;
      end;

      // Now we can finally generate the email if everything is done.
      if ( wantEmail ) then
      begin
         Email_CreateOrderEmail( fOrderID, fCustID);
         EmailPercentForm_Memo('* Email for ' + Customer_GetCustomerNameByCustID( fCustID ) +
            ' - ' + Order_GetOrderTypeNameByOrderID( fOrderID ) + ' # ' +
               Order_GetOrderNumberByOrderID( fOrderID ) + ' generated.');
      end;

      // move to the next record
      emailQuery.Next();
      EmailPercentForm_Update();
   until emailQuery.EOF;

   // Done, don't free this:
   emailPercentForm_Finished();
   frm_EmailList.GlobalRefreshEvent();
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//

end.








