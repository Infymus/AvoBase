 (*
 * AvoBase - Point of Sale Management Software.
 * (c) 2011-2026 by Infymus.
 * Designed for CodeGear Embarcadero Delphi 2009 Architect.
 * Uses the Borland Database Engine (BDE) utilizing Paradox.
 * Will compile and run under Windows 10 or 11.
 *
 *)

PROGRAM  AvoBase;

uses
  ActionUnit in 'ActionUnit.pas',
  Avobase_BaseForm_ListUnit in 'Avobase_BaseForm_ListUnit.pas' {Avobase_BaseForm_List},
  AvoBase_BaseForm_MenuUnit in 'AvoBase_BaseForm_MenuUnit.pas' {AvoBase_BaseForm_Menu},
  AvoBase_BaseForm_StandardUnit in 'AvoBase_BaseForm_StandardUnit.pas' {Avobase_BaseForm_Standard},
  AvoBase_BitButtonUnit in 'AvoBase_BitButtonUnit.pas',
  AvoBase_DialogFormUnit in 'AvoBase_DialogFormUnit.pas' {AvoBaseDialogForm},
  AvoBase_EULAFormUnit in 'AvoBase_EULAFormUnit.pas' {EULAForm},
  AvoBase_GroupBoxUnit in 'AvoBase_GroupBoxUnit.pas' {AvoBaseGroupBox},
  AvoBase_PercentFormUnit in 'AvoBase_PercentFormUnit.pas' {PercentForm},
  AvoBase_PopMenuUnit in 'AvoBase_PopMenuUnit.pas',
  AvoBase_ToolBarUnit in 'AvoBase_ToolBarUnit.pas',
  AvoBase_UpdateObjectUnit in 'AvoBase_UpdateObjectUnit.pas',
  Brochure_ControlFormUnit in 'Brochure_ControlFormUnit.pas' {ControlForm_Brochure},
  Brochure_EditFormUnit in 'Brochure_EditFormUnit.pas' {BrochureEditForm},
  Brochure_ListFormUnit in 'Brochure_ListFormUnit.pas' {BrochureListForm},
  Brochure_ViewFormUnit in 'Brochure_ViewFormUnit.pas' {avobase_baseform_menu1},
  CalculatorFormUnit in 'CalculatorFormUnit.pas' {CalculatorForm},
  classes,
  ShellAPI,
  ConstantsUnit in 'ConstantsUnit.pas',
  Customer_ControlFormUnit in 'Customer_ControlFormUnit.pas' {ControlForm_Customer},
  Customer_EditFormUnit in 'Customer_EditFormUnit.pas' {CustomerEditForm},
  Customer_ListFormUnit in 'Customer_ListFormUnit.pas' {CustomerListForm},
  Customer_ViewOrdersFormUnit in 'Customer_ViewOrdersFormUnit.pas' {Customer_ViewForm},
  Cycle_ControlFormUnit in 'Cycle_ControlFormUnit.pas' {ControlForm_Cycle},
  Cycle_EditFormUnit in 'Cycle_EditFormUnit.pas' {CycleEditForm},
  Cycle_ListFormUnit in 'Cycle_ListFormUnit.pas' {CycleListForm},
  dialogs,
  ErrorResultUnit in 'ErrorResultUnit.pas',
  forms,
  IMG_StorageFormUnit in 'IMG_StorageFormUnit.pas' {IMG_StorageForm},
  INIFileUnit in 'INIFileUnit.pas',
  Invoice_FEEItemControlObjectUnit in 'Invoice_FEEItemControlObjectUnit.pas',
  Invoice_LineItemControlObjectUnit in 'Invoice_LineItemControlObjectUnit.pas',
  Invoice_LineItem_InterfaceUnit in 'Invoice_LineItem_InterfaceUnit.pas',
  mainform_formcontrolunit in 'mainform_formcontrolunit.pas',
  MAIN_FORM_UNIT in 'MAIN_FORM_UNIT.pas' {MainForm},
  MasterDataInterfaceUnit in 'MasterDataInterfaceUnit.pas',
  MasterDataUnit in 'MasterDataUnit.pas',
  MasterData_BaseGridUnit in 'MasterData_BaseGridUnit.pas',
  MasterData_BrochureListUnit in 'MasterData_BrochureListUnit.pas',
  Toolbox_BrochureToolBoxUnit in 'Toolbox_BrochureToolBoxUnit.pas',
  MasterData_CustomerListUnit in 'MasterData_CustomerListUnit.pas',
  MasterData_CustomerOrderDetailsListUnit in 'MasterData_CustomerOrderDetailsListUnit.pas',
  MasterData_CycleListUnit in 'MasterData_CycleListUnit.pas',
  Toolbox_CycleToolBoxUnit in 'Toolbox_CycleToolBoxUnit.pas',
  MasterData_NavigationToolUnit in 'MasterData_NavigationToolUnit.pas',
  MasterData_OrderListUnit in 'MasterData_OrderListUnit.pas',
  Toolbox_OrgToolBoxUnit in 'Toolbox_OrgToolBoxUnit.pas',
  MasterData_OrgWelcomeFormListUnit in 'MasterData_OrgWelcomeFormListUnit.pas',
  Toolbox_PreferenceToolBoxUnit in 'Toolbox_PreferenceToolBoxUnit.pas',
  MasterData_ProductListUnit in 'MasterData_ProductListUnit.pas',
  MasterData_ProductUnit in 'MasterData_ProductUnit.pas',
  Order_EditFormUnit in 'Order_EditFormUnit.pas' {OrderEditForm},
  Order_InvoiceObjectUnit in 'Order_InvoiceObjectUnit.pas',
  Order_ListFormUnit in 'Order_ListFormUnit.pas' {OrderListForm},
  Preference_BaseFormUnit in 'Preference_BaseFormUnit.pas' {PrefBaseForm},
  Preference_MenuFormUnit in 'Preference_MenuFormUnit.pas' {PreferencesForm},
  Preference_RegistrationFormUnit in 'Preference_RegistrationFormUnit.pas' {Pref_RegistrationForm},
  Product_ControlFormUnit in 'Product_ControlFormUnit.pas' {ControlForm_Product},
  Product_EditFormUnit in 'Product_EditFormUnit.pas' {ProductEditForm},
  Product_ListFormUnit in 'Product_ListFormUnit.pas' {ProductListForm},
  Product_ViewFormUnit in 'Product_ViewFormUnit.pas' {Product_ViewForm},
  sysutils,
  Tax_InterfaceUnit in 'Tax_InterfaceUnit.pas',
  ToolBoxUnit in 'ToolBoxUnit.pas',
  VerificationUnit in 'VerificationUnit.pas',
  Verification_KeysUnit in 'Verification_KeysUnit.pas',
  WelcomeFormUnit in 'WelcomeFormUnit.pas' {WelcomeForm},
  windows,
  zz_base_design_item_form in 'zz_base_design_item_form.pas' {Form2},
  zz_testformunit in 'zz_testformunit.pas' {Form1},
  Invoice_MOPItem_FormUnit in 'Invoice_MOPItem_FormUnit.pas' {Invoice_MOPItem_Form},
  Invoice_MOPItemControlObjectUnit in 'Invoice_MOPItemControlObjectUnit.pas',
  Invoice_MOPItem_InterfaceUnit in 'Invoice_MOPItem_InterfaceUnit.pas',
  Invoice_LineItem_Quick_FormUnit in 'Invoice_LineItem_Quick_FormUnit.pas' {Invoice_LineItem_Quick_Form},
  Invoice_LineItem_NoFormUnit in 'Invoice_LineItem_NoFormUnit.pas',
  Invoice_MOPItem_NoFormUnit in 'Invoice_MOPItem_NoFormUnit.pas',
  Invoice_FEEItem_NoFormUnit in 'Invoice_FEEItem_NoFormUnit.pas',
  Invoice_FEEItem_FormUnit in 'Invoice_FEEItem_FormUnit.pas' {Invoice_FEEItem_Form},
  Invoice_FEEItem_InterfaceUnit in 'Invoice_FEEItem_InterfaceUnit.pas',
  Cycle_ViewOrderListUnit in 'Cycle_ViewOrderListUnit.pas' {CycleViewOrderListForm},
  MasterData_CycleOrderListUnit in 'MasterData_CycleOrderListUnit.pas',
  Toolbox_OrderToolBoxUnit in 'Toolbox_OrderToolBoxUnit.pas',
  MasterData_CycleSelectUnit in 'MasterData_CycleSelectUnit.pas',
  Toolbox_CustomerToolBoxUnit in 'Toolbox_CustomerToolBoxUnit.pas',
  MasterData_CustSelectUnit in 'MasterData_CustSelectUnit.pas',
  Toolbox_TaxToolBoxUnit in 'Toolbox_TaxToolBoxUnit.pas',
  Toolbox_ShippingToolBoxUnit in 'Toolbox_ShippingToolBoxUnit.pas',
  Preference_ShippingFormUnit in 'Preference_ShippingFormUnit.pas' {Pref_ShippingForm},
  Preference_OrganizationsFormUnit in 'Preference_OrganizationsFormUnit.pas' {Pref_OrganizationsForm},
  MasterData_OrgListUnit in 'MasterData_OrgListUnit.pas',
  Preference_OrganizationsEditFormUnit in 'Preference_OrganizationsEditFormUnit.pas' {Preference_OrgEditForm},
  MasterData_TaxListUnit in 'MasterData_TaxListUnit.pas',
  Preference_TaxesFormUnit in 'Preference_TaxesFormUnit.pas' {Pref_TaxesForm},
  Preference_TaxesEditFormUnit in 'Preference_TaxesEditFormUnit.pas' {Pref_TaxEditForm},
  masterdata_BaseDataClassUnit in 'masterdata_BaseDataClassUnit.pas',
  Preference_ShippingEditFormUnit in 'Preference_ShippingEditFormUnit.pas' {Pref_ShippingEditForm},
  MasterData_ShippingListUnit in 'MasterData_ShippingListUnit.pas',
  MasterData_UpdateUnit in 'MasterData_UpdateUnit.pas',
  Preference_FeesFormUnit in 'Preference_FeesFormUnit.pas' {Pref_FeesForm},
  MasterData_FeeListUnit in 'MasterData_FeeListUnit.pas',
  Preference_FeeEditFormUnit in 'Preference_FeeEditFormUnit.pas' {Pref_FeeEditForm},
  AvoBase_BaseForm_SelectUnit in 'AvoBase_BaseForm_SelectUnit.pas' {AvoBase_BaseForm_Select},
  Cycle_SelectFormUnit in 'Cycle_SelectFormUnit.pas' {Cycle_SelectForm},
  Toolbox_PaymentToolBoxUnit in 'Toolbox_PaymentToolBoxUnit.pas',
  Report_BaseForm in 'Report_BaseForm.pas' {AvoBase_ReportBase},
  Report_InvoiceFormUnit in 'Report_InvoiceFormUnit.pas' {Report_ReturnForm},
  Order_OrderNumberInputFormUnit in 'Order_OrderNumberInputFormUnit.pas' {OrderNumberInputForm},
  Preference_GeneralSettingsFormUnit in 'Preference_GeneralSettingsFormUnit.pas' {Pref_GeneralSettingsForm},
  Customer_SelectFormUnit in 'Customer_SelectFormUnit.pas' {CustomerSelectForm},
  Preference_RepresentativeFormUnit in 'Preference_RepresentativeFormUnit.pas' {Pref_RepresentativeForm},
  Preference_EmailFormUnit in 'Preference_EmailFormUnit.pas' {Pref_EmailSettingsForm},
  EncryptUnit in 'EncryptUnit.pas' {EncryptObj: TDataModule},
  Toolbox_CreditToolBoxUnit in 'Toolbox_CreditToolBoxUnit.pas',
  Product_SelectFormUnit in 'Product_SelectFormUnit.pas' {ProductSelectForm},
  Toolbox_ProductToolBoxUnit in 'Toolbox_ProductToolBoxUnit.pas',
  MasterData_ProductSelectListUnit in 'MasterData_ProductSelectListUnit.pas',
  Order_TakeMethodOfPaymentEditFormUnit in 'Order_TakeMethodOfPaymentEditFormUnit.pas' {OrderTakeMethodOfPaymentForm},
  Order_OrderSelectOrderByCustIDFormUnit in 'Order_OrderSelectOrderByCustIDFormUnit.pas' {OrderSelectOrderByCustIDForm},
  DiscountFormUnit in 'DiscountFormUnit.pas' {DiscountForm},
  Order_ControlFormUnit in 'Order_ControlFormUnit.pas' {ControlForm_Order},
  Payment_SelectPaymentFormUnit in 'Payment_SelectPaymentFormUnit.pas' {Payment_SelectPaymentForm},
  MasterData_PaymentListUnit in 'MasterData_PaymentListUnit.pas',
  Payment_VoidPaymentFormUnit in 'Payment_VoidPaymentFormUnit.pas' {Payment_VoidPaymentForm},
  MasterData_TransactionListUnit in 'MasterData_TransactionListUnit.pas',
  Customer_ViewAccountFormUnit in 'Customer_ViewAccountFormUnit.pas' {Customer_AccountViewForm},
  Order_SelectOrderToReturnFormUnit in 'Order_SelectOrderToReturnFormUnit.pas' {OrderSelectOrderToReturnForm},
  MasterData_OrderSelectClosedOnlyListUnit in 'MasterData_OrderSelectClosedOnlyListUnit.pas',
  Return_InvoiceObjectUnit in 'Return_InvoiceObjectUnit.pas',
  Return_EditFormUnit in 'Return_EditFormUnit.pas' {OrderReturnEditForm},
  Return_LineItem_InterfacEunit in 'Return_LineItem_InterfacEunit.pas',
  Return_FeeItem_InterfaceUnit in 'Return_FeeItem_InterfaceUnit.pas',
  Return_LineItemControlObjectUnit in 'Return_LineItemControlObjectUnit.pas',
  Return_FEEItem_FormUnit in 'Return_FEEItem_FormUnit.pas' {Return_FEEItem_Form},
  Return_FEEItem_NoFormUnit in 'Return_FEEItem_NoFormUnit.pas',
  Return_LineItem_FormUnit in 'Return_LineItem_FormUnit.pas' {Return_LineItem_Form},
  Return_LineItem_NoFormUnit in 'Return_LineItem_NoFormUnit.pas',
  Return_FEEItemControlObjectUnit in 'Return_FEEItemControlObjectUnit.pas',
  Expense_ControlFormUnit in 'Expense_ControlFormUnit.pas' {ControlForm_Expense},
  Expense_ListFormUnit in 'Expense_ListFormUnit.pas' {ExpenseListForm},
  MasterData_ExpenseListUnit in 'MasterData_ExpenseListUnit.pas',
  Preference_ExpenseTypeFormUnit in 'Preference_ExpenseTypeFormUnit.pas' {Pref_ExpenseTypesForm},
  MasterData_ExpenseTypeListUnit in 'MasterData_ExpenseTypeListUnit.pas',
  Preference_ExpenseTypeEditFormUnit in 'Preference_ExpenseTypeEditFormUnit.pas' {Pref_ExpenseTypeEditForm},
  Preference_EarningTypeFormUnit in 'Preference_EarningTypeFormUnit.pas' {Pref_EarningTypesForm},
  Preference_EarningTypeEditFormUnit in 'Preference_EarningTypeEditFormUnit.pas' {Pref_EarningTypeEditForm},
  MasterData_EarningTypeListUnit in 'MasterData_EarningTypeListUnit.pas',
  Cycle_SelectOrgAndCycleFormUnit in 'Cycle_SelectOrgAndCycleFormUnit.pas' {OrgSelectOrgAndCycleForm},
  Toolbox_ExpenseToolBoxUnit in 'Toolbox_ExpenseToolBoxUnit.pas',
  MasterData_ExpenseListEditUnit in 'MasterData_ExpenseListEditUnit.pas',
  Expense_ListEditFormUnit in 'Expense_ListEditFormUnit.pas' {ExpenseList_EditForm},
  Toolbox_EarningToolBoxUnit in 'Toolbox_EarningToolBoxUnit.pas',
  Expense_ItemEditFormUnit in 'Expense_ItemEditFormUnit.pas' {Expense_EditForm},
  Expense_ViewExpensesFormUnit in 'Expense_ViewExpensesFormUnit.pas' {Expense_ViewExpensesForm},
  MasterData_EarningListUnit in 'MasterData_EarningListUnit.pas',
  MasterData_EarningListEditUnit in 'MasterData_EarningListEditUnit.pas',
  Earning_ControlFormUnit in 'Earning_ControlFormUnit.pas' {ControlForm_Earning},
  Earning_ListFormUnit in 'Earning_ListFormUnit.pas' {EarningListForm},
  Earning_ListEditFormUnit in 'Earning_ListEditFormUnit.pas' {EarningList_EditForm},
  Earning_ItemEditFormUnit in 'Earning_ItemEditFormUnit.pas' {Earning_EditForm},
  Earning_ViewEarningsFormUnit in 'Earning_ViewEarningsFormUnit.pas' {Earning_ViewEarningsForm},
  MasterData_ProductBOListUnit in 'MasterData_ProductBOListUnit.pas',
  BackOrder_ManagerFormUnit in 'BackOrder_ManagerFormUnit.pas' {BackOrder_ManagerForm},
  Email_ControlFormUnit in 'Email_ControlFormUnit.pas' {ControlForm_Email},
  Toolbox_EmailToolBoxUnit in 'Toolbox_EmailToolBoxUnit.pas',
  Email_ListFormUnit in 'Email_ListFormUnit.pas' {EmailListForm},
  MasterData_EmailListUnit in 'MasterData_EmailListUnit.pas',
  Order_ViewOrderFormUnit in 'Order_ViewOrderFormUnit.pas' {OrderViewOrderForm},
  Fee_SelectFormUnit in 'Fee_SelectFormUnit.pas' {FeeSelectForm},
  MasterData_FeeSelectListUnit in 'MasterData_FeeSelectListUnit.pas',
  Report_ReturnFormUnit in 'Report_ReturnFormUnit.pas' {Report_Return},
  Escrow_SelectEscrowFormUnit in 'Escrow_SelectEscrowFormUnit.pas' {Escrow_SelectEscrow},
  Order_FinalizationFormUnit in 'Order_FinalizationFormUnit.pas' {Order_FinalizationForm},
  Return_FinalizationFormUnit in 'Return_FinalizationFormUnit.pas' {Return_FinalizationForm},
  ReturnProduct_ManagerFormUnit in 'ReturnProduct_ManagerFormUnit.pas' {ReturnProduct_Manager},
  MasterData_ProductReturnListUnit in 'MasterData_ProductReturnListUnit.pas',
  ToolBox_EscrowToolBoxUnit in 'ToolBox_EscrowToolBoxUnit.pas',
  Transaction_Object in 'Transaction_Object.pas',
  Transaction_PaymentsObjectUnit in 'Transaction_PaymentsObjectUnit.pas',
  Transaction_ReversalsObjectUnit in 'Transaction_ReversalsObjectUnit.pas',
  Transaction_EscrowObjectUnit in 'Transaction_EscrowObjectUnit.pas',
  Transaction_TransObjectUnit in 'Transaction_TransObjectUnit.pas',
  Transaction_Payments_SubObjectUnit in 'Transaction_Payments_SubObjectUnit.pas',
  MasterData_OrderConfirmationListUnit in 'MasterData_OrderConfirmationListUnit.pas',
  Toolbox_FeeToolboxUnit in 'Toolbox_FeeToolboxUnit.pas',
  Return_ViewReturnFormUnit in 'Return_ViewReturnFormUnit.pas' {ReturnViewReturnForm},
  MasterData_ReturnConfirmationListUnit in 'MasterData_ReturnConfirmationListUnit.pas',
  Invoice_MOP_SelectEscrowFormUnit in 'Invoice_MOP_SelectEscrowFormUnit.pas' {Invoice_MOP_SelectEscrowForm},
  Preference_InvoiceSettingsForm in 'Preference_InvoiceSettingsForm.pas' {Pref_InvoiceSettingsForm},
  Preference_ProductSettingsForm in 'Preference_ProductSettingsForm.pas' {Pref_ProductSettingsForm},
  Product_InvoiceLineItemProductLookupUnit in 'Product_InvoiceLineItemProductLookupUnit.pas' {InvoiceLineItemProductLookupForm},
  MasterData_InvoiceLineItemProductLookupUnit in 'MasterData_InvoiceLineItemProductLookupUnit.pas',
  Preference_TaxMasterFormUnit in 'Preference_TaxMasterFormUnit.pas' {Pref_TaxesMasterForm},
  MasterData_TaxMasterListUnit in 'MasterData_TaxMasterListUnit.pas',
  Preference_TaxMasterEditFormUnit in 'Preference_TaxMasterEditFormUnit.pas' {Pref_TaxMasterEditForm},
  Preference_TaxMasterSetDefaultFormUnit in 'Preference_TaxMasterSetDefaultFormUnit.pas' {Pref_TaxesMasterSetDefaultForm},
  Accounting_EscrowFormUnit in 'Accounting_EscrowFormUnit.pas' {AccountingEscrowForm},
  MasterData_AccountingEscrowListUnit in 'MasterData_AccountingEscrowListUnit.pas',
  Accounting_EscrowModifyFormUnit in 'Accounting_EscrowModifyFormUnit.pas' {EscrowModifyForm},
  Report_ControlFormUnit in 'Report_ControlFormUnit.pas' {ControlForm_Report},
  Report_InterfaceFormUnit in 'Report_InterfaceFormUnit.pas' {Report_InterfaceForm},
  Report_CustomerListUnit in 'Report_CustomerListUnit.pas' {Report_Customer_List},
  Report_CustomerTopCustomerByOrdersFormUnit in 'Report_CustomerTopCustomerByOrdersFormUnit.pas' {Report_Customer_TopCustByOrder},
  MasterData_ReportCustomerTopCustByOrdUnit in 'MasterData_ReportCustomerTopCustByOrdUnit.pas',
  MasterData_ReportCustomerTopCustByOrdAmountUnit in 'MasterData_ReportCustomerTopCustByOrdAmountUnit.pas',
  Report_CustomerTopCustomerByOrderAmountFormUnit in 'Report_CustomerTopCustomerByOrderAmountFormUnit.pas' {Report_Customer_TopCustByOrderAmount},
  MasterData_ReportOrderListUnit in 'MasterData_ReportOrderListUnit.pas',
  Report_OrderListFormUnit in 'Report_OrderListFormUnit.pas' {Report_Order_List},
  MasterData_EmailQueueUnit in 'MasterData_EmailQueueUnit.pas',
  AvoBase_CodeTextEditorFormUnit in 'AvoBase_CodeTextEditorFormUnit.pas' {AvoBase_CodeTextEditor},
  Email_CleanEmailSelectFormUnit in 'Email_CleanEmailSelectFormUnit.pas' {EmailCleanEmailSelectForm},
  AvoBase_StartupFormUnit in 'AvoBase_StartupFormUnit.pas' {StartupForm},
  Report_Customer_OrderTransactionHistoryFormUnit in 'Report_Customer_OrderTransactionHistoryFormUnit.pas' {Report_Customer_OrderTransactionHistory},
  Report_Customer_OrderHistoryFormUnit in 'Report_Customer_OrderHistoryFormUnit.pas' {Report_Customer_OrderHistory},
  Report_Customer_SingleCustomerFormUnit in 'Report_Customer_SingleCustomerFormUnit.pas' {Report_Customer_SingleCustomer},
  Report_Customer_LabelsFormUnit in 'Report_Customer_LabelsFormUnit.pas' {Report_Customer_Labels},
  Report_Cycle_CycleListByOrgFormUnit in 'Report_Cycle_CycleListByOrgFormUnit.pas' {Report_Cycle_CycleListByOrg},
  Report_Order_LabelsFormUnit in 'Report_Order_LabelsFormUnit.pas' {Report_Order_Labels},
  Report_Order_BackOrderListFormUnit in 'Report_Order_BackOrderListFormUnit.pas' {Report_Order_BackOrderList},
  Report_Earning_TypesFormUnit in 'Report_Earning_TypesFormUnit.pas' {Report_Earning_Types},
  Report_Earning_EarningByCycleFormUnit in 'Report_Earning_EarningByCycleFormUnit.pas' {Report_Earning_EarningByCycle},
  Report_Earning_ListByCycleFormUnit in 'Report_Earning_ListByCycleFormUnit.pas' {Report_Earning_ListByCycle},
  Report_Expense_TypeFormUnit in 'Report_Expense_TypeFormUnit.pas' {Report_Expense_Type},
  Report_Expense_ByCycleFormUnit in 'Report_Expense_ByCycleFormUnit.pas' {Report_Expense_ByCycle},
  Report_Expense_ListByCycleFormUnit in 'Report_Expense_ListByCycleFormUnit.pas' {Report_Expense_ListByCycle},
  Report_EarningVsExpenseByCycleFormUnit in 'Report_EarningVsExpenseByCycleFormUnit.pas' {Report_EarningVsExpenseByCycle},
  Report_Product_SingleProductFormUnit in 'Report_Product_SingleProductFormUnit.pas' {Report_Product_SingleProduct},
  Report_Product_QuantityOnHandFormUnit in 'Report_Product_QuantityOnHandFormUnit.pas' {Report_Product_QuantityOnHand},
  Report_Product_ProductListFormUnit in 'Report_Product_ProductListFormUnit.pas' {Report_Product_ProductList},
  Report_Accounting_FeesCollectedByCycleFormUnit in 'Report_Accounting_FeesCollectedByCycleFormUnit.pas' {Report_Accounting_FeesCollectedByCycle},
  Report_Accounting_ShippingCollectedByCycleFormUnit in 'Report_Accounting_ShippingCollectedByCycleFormUnit.pas' {Report_Accounting_ShippingCollectedByCycle},
  Report_Accounting_TaxesCollectedByCycleFormUnit in 'Report_Accounting_TaxesCollectedByCycleFormUnit.pas' {Report_Accounting_TaxesCollectedByCycle},
  Report_Accounting_DepositSlipByCycleFormUnit in 'Report_Accounting_DepositSlipByCycleFormUnit.pas' {Report_Accounting_DepositSlipByCycle},
  Report_Accounting_VoidNSFByCycleFormUnit in 'Report_Accounting_VoidNSFByCycleFormUnit.pas' {Report_Accounting_VoidNSFByCycle},
  Report_Accounting_ReturnsByCycleFormUnit in 'Report_Accounting_ReturnsByCycleFormUnit.pas' {Report_Accounting_ReturnsByCycle},
  Report_Accounting_TransactionLogByCycleFormUnit in 'Report_Accounting_TransactionLogByCycleFormUnit.pas' {Report_Accounting_TransactionLogByCycle},
  Report_Accounting_TaxExemptByCycleFormUnit in 'Report_Accounting_TaxExemptByCycleFormUnit.pas' {Report_Accounting_TaxExemptByCycle},
  Report_Order_OrderProductFormUnit in 'Report_Order_OrderProductFormUnit.pas' {Report_Order_OrderProduct},
  MasterData_ReportOrderProductListUnit in 'MasterData_ReportOrderProductListUnit.pas',
  MasterData_ReportCycleListUnit in 'MasterData_ReportCycleListUnit.pas',
  MasterData_ReportProductQuantityOnHandUnit in 'MasterData_ReportProductQuantityOnHandUnit.pas',
  Report_Product_ReturnProductListFormUnit in 'Report_Product_ReturnProductListFormUnit.pas' {Report_Product_ReturnProductList},
  MasterData_ReportProductReturnListUnit in 'MasterData_ReportProductReturnListUnit.pas',
  MasterData_ReportEarningByCycleUnit in 'MasterData_ReportEarningByCycleUnit.pas',
  MasterData_ReportExpenseByCycleUnit in 'MasterData_ReportExpenseByCycleUnit.pas',
  MasterData_ReportEarningListByCycleUnit in 'MasterData_ReportEarningListByCycleUnit.pas',
  MasterData_ReportExpenseListByCycleUnit in 'MasterData_ReportExpenseListByCycleUnit.pas',
  MasterData_ReportEarningVsExpenseByCycleUnit in 'MasterData_ReportEarningVsExpenseByCycleUnit.pas',
  MasterData_ReportAccountingFeesCollectedByCycleUnit in 'MasterData_ReportAccountingFeesCollectedByCycleUnit.pas',
  MasterData_ReportAccountingShippingCollectedByCycleUnit in 'MasterData_ReportAccountingShippingCollectedByCycleUnit.pas',
  MasterData_ReportAccountingTaxesCollectedByCycleUnit in 'MasterData_ReportAccountingTaxesCollectedByCycleUnit.pas',
  MasterData_ReportAccountingTaxExemptByCycleUnit in 'MasterData_ReportAccountingTaxExemptByCycleUnit.pas',
  MasterData_ReportInvoiceUnit in 'MasterData_ReportInvoiceUnit.pas',
  AvoBase_BaseForm_DateMaskEdit in 'AvoBase_BaseForm_DateMaskEdit.pas' {AvoDateEdit},
  MasterData_ReportAccountingTransactionLogByCycleUnit in 'MasterData_ReportAccountingTransactionLogByCycleUnit.pas',
  Report_Accounting_FeesReturnedFormUnit in 'Report_Accounting_FeesReturnedFormUnit.pas' {Report_Accounting_FeesReturned},
  MasterData_ReportReturnsByCycleUnit in 'MasterData_ReportReturnsByCycleUnit.pas',
  MasterData_ReportVoidNSFByCycleUnit in 'MasterData_ReportVoidNSFByCycleUnit.pas',
  MasterData_ReportProductSingleProductUnit in 'MasterData_ReportProductSingleProductUnit.pas',
  MasterData_Report_ProductListUnit in 'MasterData_Report_ProductListUnit.pas',
  AvoBase_HelpFormUnit in '..\HelpMaker\AvoBase_HelpFormUnit.pas' {AvoBaseHelpForm},
  MasterData_HelpUnit in '..\HelpMaker\MasterData_HelpUnit.pas',
  ASN1 in '..\Encryption\ASN1.pas',
  CPU in '..\Encryption\CPU.pas',
  CRC in '..\Encryption\CRC.pas',
  DECCipher in '..\Encryption\DECCipher.pas',
  DECData in '..\Encryption\DECData.pas',
  DECFmt in '..\Encryption\DECFmt.pas',
  DECHash in '..\Encryption\DECHash.pas',
  DECRandom in '..\Encryption\DECRandom.pas',
  DECUtil in '..\Encryption\DECUtil.pas',
  TypInfoEx in '..\Encryption\TypInfoEx.pas',
  Avobase_RegisterDialogFormUnit in 'Avobase_RegisterDialogFormUnit.pas' {AvoBaseRegisterDialogForm},
  MaskAmountEdit in '..\MaskAmountEdit\MaskAmountEdit.pas',
  AvoBase_UpdateViewerFormUnit in 'AvoBase_UpdateViewerFormUnit.pas' {AvoBase_UpdateViewer},
  Customer_NoteListFormUnit in 'Customer_NoteListFormUnit.pas' {Customer_NoteListForm},
  MasterData_CustomerNoteListUnit in 'MasterData_CustomerNoteListUnit.pas',
  AvoBase_TextEditorFormUnit in 'AvoBase_TextEditorFormUnit.pas' {AvoBaseTextEditor},
  Report_Customer_OutstandingBalanceFormUnit in 'Report_Customer_OutstandingBalanceFormUnit.pas' {Report_Customer_OutstandingBalance},
  MasterData_ReportCustomerBalanceDueUnit in 'MasterData_ReportCustomerBalanceDueUnit.pas',
  MasterData_TransactionQueryUnit in 'MasterData_TransactionQueryUnit.pas',
  Report_Accounting_OrderBreakDowNByCycleFormUnit in 'Report_Accounting_OrderBreakDowNByCycleFormUnit.pas' {Report_Accounting_OrderAmountBreakDownByCycle},
  MasterData_ReportAccountingOrderAmountByCycleUnit in 'MasterData_ReportAccountingOrderAmountByCycleUnit.pas',
  MasterData_EmailQueueListByCycleIDUnit in 'MasterData_EmailQueueListByCycleIDUnit.pas',
  AvoBase_EmailDialogFormUnit in 'AvoBase_EmailDialogFormUnit.pas' {EmailDialogForm},
  Cycle_SelectOrgAndMultipleCycleFormUnit in 'Cycle_SelectOrgAndMultipleCycleFormUnit.pas' {OrgSelectOrgAndMultieCycleForm},
  Customer_ProdHistoryFormUnit in 'Customer_ProdHistoryFormUnit.pas' {Customer_ProdHistoryForm},
  MasterData_CustomerProdHistoryUnit in 'MasterData_CustomerProdHistoryUnit.pas',
  CustOrd_CustLineControlObjectUnit in 'CustOrd_CustLineControlObjectUnit.pas',
  CustOrd_CustFormUnit in 'CustOrd_CustFormUnit.pas' {CustOrd_CustForm},
  CustOrd_ProdLineControlObjectUnit in 'CustOrd_ProdLineControlObjectUnit.pas',
  CustOrd_CustProdFormUnit in 'CustOrd_CustProdFormUnit.pas' {Form5},
  CustOrd_MainFormUnit in 'CustOrd_MainFormUnit.pas' {CustOrd_MainForm},
  MasterData_SelectOrderByCustIDUnit in 'MasterData_SelectOrderByCustIDUnit.pas',
  Report_Customer_EscrowBalances in 'Report_Customer_EscrowBalances.pas' {Report_CustomerEscrowBalance},
  MasterData_Report_CustomerEscrowBalances in 'MasterData_Report_CustomerEscrowBalances.pas',
  MasterData_ReportShippingReturns in 'MasterData_ReportShippingReturns.pas',
  Report_Accounting_ShippingReturnedFormUnit in 'Report_Accounting_ShippingReturnedFormUnit.pas' {Report_Accounting_ShippingReturns},
  HintsUnit in 'HintsUnit.pas',
  AvoBase_RTF_ReaderFormUnit in 'AvoBase_RTF_ReaderFormUnit.pas' {AvoBaseRTFReader},
  AvoBase_FindKeyWebDialogFormUnit in 'AvoBase_FindKeyWebDialogFormUnit.pas' {AvoBaseWebKeyDialogForm},
  Product_ImportProductFormUnit in 'Product_ImportProductFormUnit.pas' {Product_ImportProductForm},
  Product_ImportProductObject in 'Product_ImportProductObject.pas',
  Product_ImportProductLineItemFormUnit in 'Product_ImportProductLineItemFormUnit.pas' {ImportProduct_LineItem_Form},
  Preference_Taxes_SetDefaultRoundingFormUnit in 'Preference_Taxes_SetDefaultRoundingFormUnit.pas' {Pref_Taxes_SetDefaultRoundingForm},
  Customer_ExportFormUnit in 'Customer_ExportFormUnit.pas' {Export_Customer},
  Customer_ExportSelectTypeFormUnit in 'Customer_ExportSelectTypeFormUnit.pas' {Customer_ExportSelectTypeForm},
  QrTee in '..\tqrchart\QrTee.pas',
  RecordStructureUnit in 'RecordStructureUnit.pas',
  Invoice_LineItem_Simple_FormUnit in 'Invoice_LineItem_Simple_FormUnit.pas' {Invoice_LineItem_SimpleForm},
  Invoice_LineItem_FormUnit in 'Invoice_LineItem_FormUnit.pas' {Invoice_LineItem_Full_Form},
  Invoice_lineItem_QuickPop_FormUnit in 'Invoice_lineItem_QuickPop_FormUnit.pas' {LineItem_QuickPop};

{$R *.res}

(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)
(* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *)

var
	hMutex : tHandle;
   avoMasterDataUpdate : tMasterDataUpdate;
   errResult : tErrorResult;
   checkUpdates : tUpdateAvoBase;
   checkUpdateResult : tCheckUpdateTypes;
   runUpdateProgram : boolean;
   runUpdateProgramOnExit : boolean;
   fileRunPath : string;
   CheckDays : integer;

procedure HandleRibbonControlChangeEvent( sender : tObject; inRibbon : tRibbonGroups );
begin
	if Assigned( mainForm ) then
   	mainForm.ChangeRibbonIndex( inRibbon );
end;

procedure HandleFormControlCheckUpdate( sender : tObject );
begin
	if Assigned( mainForm ) then
   	mainForm.CheckForUpdates();
end;

function UpdateExecuteFile(const FileName, Params, DefaultDir: string; ShowCmd: Integer): integer;
begin
  result := ShellExecute( Application.Handle, 'open', PChar(FileName), nil, nil, SW_SHOWNORMAL) ;
end;

begin
   Application.Initialize;
   Application.MainFormOnTaskbar := True;
   Application.Title := 'AvoBase';
   Application.CreateForm(TMainForm, MainForm); { YES THIS STAYS }
   Application.CreateForm(TEncryptObj, EncryptObj); { YES THIS STAYS }
   img_storageform := tIMG_StorageForm.Create(application); { YES THIS STAYS }
   //
   // check for double instances
   hMutex := CreateMutex(nil, false, AVOBASE_NAME + '2'); { remove this "2" before release }
   if (WaitForSingleObject(hMutex,0) <> wait_TimeOut) then
   begin

   	// forms that we need access to from the start
      try
         masterData := tMasterData.Create();
      except
         on E:Exception do
         begin
            errResult := Error_Init();
            errResult.errorResult := true;
            errResult.errorMessage := E.Message;
            Error_Log( errResult, true );
            Halt;
         end;
      end;

      // Our Special Percentform
      StartPercentForm_Create('Initializing AvoBase', 1, 17);

      // Is AvoBase being run from C:\AvoBase2 directory?
      (*
      fileRunPath := UpperCase(GetCurrentDir());
      if (  AvoINIReadString(AVOBASE_NAME, 'DevMode', 'False') ) = 'False' then
         if ( fileRunPath <> 'C:\AVOBASE2' ) then
         begin
            StartPercentForm_Free();
            AvoBaseDialog('AvoBase Directory Error',
               'AvoBase is being run from "' + GetCurrentDir() + '"\n\nAvoBase can only run from ' +
               '"C:\AvoBase2" directory.\n\nIf you are running a Beta copy, make sure to copy the "avobase.exe" ' +
               'file to C:\AvoBase2 and run it from there.', mtError, [mbok], 0);
            HALT;
         end; *)

      //create the INI file, create the database and do all the essential upgrades
      try
      	avoMasterDataUpdate := tMasterDataUpdate(nil);
         errResult := avoMasterDataUpdate.UpdateTables();
         if (errResult.errorResult) then
         begin
            StartPercentForm_Free();
            Error_Log( errResult, true );
            HALT; // HALTENZIEEEEEEEEEEEEEE NO PAPERS!
         end;
      finally
      	FreeAndNil(avoMasterDataUpdate);
      end;

      // check to ensure the EULA is in place and ONLY run if it has been accepted
      runUpdateProgram := false;
      runUpdateProgramOnExit := false;
      //IF (CheckEULA) then
      //begin

      	// check for updates to AvoBase from http://www.avobase.com
         if (Pref_GetBoolean(tPrefConstants.CheckForUpdates, True) = True ) then
         begin
         	try
            	checkUpdates := tUpdateAvoBase.Create();
               // we do a "run silent" so it doesn't ask them
               checkUpdateResult := checkUpdates.CheckUpdates( checkUpdateSilent );
            finally
            	FreeAndNil(checkUpdates);
            end;
            //
            if ( checkUpdateResult = checkUpdateFound ) then
            begin
               if AvoBaseDialog('AvoBase Version Update',
                  'A new version of AvoBase is now available.\n\nUpdates can be turned off in Preferences' +
                  ' ~ General Preferences.\n\nWould you like to download and install the new version?',
                  mtInformation, [mbYes, mbNo], 0) = mbYes then
                     runUpdateProgram := true;
            end;
         end;

         if NOT ( runUpdateProgram ) then
         begin

            // our main form control that handles ALL menu options and ALL forms
            formControl := tFormControl.Create();
            formControl.OnRibbonChangeEvent := HandleRibbonControlChangeEvent;
            formControl.OnCheckForUpdatesEvent := HandleFormControlCheckUpdate;


            // run AvoBase
            mainForm.StartForm();
            if ( AvoINIReadBoolean(AVOBASE_NAME,'AVONEWINST',True) = FALSE ) then
            begin
               mainForm.CheckNewUpdateMessage();
               mainForm.CheckNewAvoBaseUpdater();
            end;

            // Donation Nag every 30th time they run AvoBase
            CheckDays := AvoINIReadInteger(AVOBASE_NAME, 'TK7', 0);
            Inc(CheckDays);
            if (CheckDays >= DONATE_NAG_TIME ) then
            begin
               CheckDays := 0;
               //AvoBaseDialog(St31, St32, mtinformation, [mbok], 0);
               AvoBaseNagDonate();
            end;
            AvoINIWriteInteger(AVOBASE_NAME, 'TK7', CheckDays);


            // ==============================
            APPLICATION.RUN;
            // ==============================
            runUpdateProgramOnExit := mainForm.UpdateRequested;
            formControl.OnRibbonChangeEvent := Nil;

            // stop running AvoBase
            AvoBase_PercentFormUnit.PercentForm_Create('Closing Database...', 0, 0);

            // If the help form is still running, make sure it is gone, otherwise GCol has to crunch endlessly
            if ( AvoBaseHelpForm <> NIL ) then
               FreeAndNil( AvoBaseHelpForm );

            // We done.
            mainForm.StopForm();
            AvoBase_PercentFormUnit.PercentForm_Free();

            //
            FreeAndNil(formControl);
         end else
            begin
               // We now execute the AvoBase Update Application
               UpdateExecuteFile(ExtractFileDir(ParamStr(0)) + '\' + AVOBASE_UPDATER, '', '', 0);
            end;
      //end;

      // Finished, close out what we opened and go away.
      AvoBase_PercentFormUnit.PercentForm_Create('Shutting Down...', 0, 0);
      AvoINIWriteBoolean(AVOBASE_NAME,'AVONEWINST', False);
      FreeAndNil(masterData);

      //
      if ( runUpdateProgramOnExit ) then
      begin
         // We now execute the AvoBase Update Application
         UpdateExecuteFile(ExtractFileDir(ParamStr(0)) + '\' + AVOBASE_UPDATER, '', '', 0);
      end;

	end else
   	begin
      	// else we say we're already running
         img_StorageForm := tImg_StorageForm.Create(Application);
         AvoBaseDialog('AvoBase Already Running?', 'AvoBase appears to already be running.' + #13 + #13 + 'Are you trying to ' +
         	'open AvoBase twice? ', mtWarning, [mbOk], 0);
      end;

end.













