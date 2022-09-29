#ifndef SrPagoDefinitions_h
#define SrPagoDefinitions_h

/*!
 *  @typedef SPStatusCode
 *  @brief Enumeration for the different status that are handled inside multiple operations.
 *  @constant SPSuccess Successful operation.
 *  @constant SPUnsuccessful Unsuccessful operation.
 *  @constant SPBatteryLow Card reader battery is running low.
 *  @constant SPReaderStatusWaiting Card reader is waiting for a card to be swiped or inserted.
 *  @constant SPReaderReady Card reader is ready to start reading cards.
 *  @since Version 1.0
 */
typedef NS_ENUM(NSUInteger, SPStatusCode){
    SPSuccess,
    SPUnsuccessful,
    SPBatteryLow,
    SPReaderStatusWaiting,
    SPReaderReady,
};

typedef NS_ENUM(NSUInteger, SPStatusErrorCode){
    SPErrorCardRead,
    SPErrorAuthTokenExpired,
    SPErrorAuthNoToken,
    SPErrorReaderNotPresent,
    SPErrorLocationNotAuthorized,
    SPErrorReaderUnknown,
    SPErrorReaderSoundInterference1,
    SPErrorReaderSoundInterference2,
    SPErrorReaderCommunicationError,
    SPErrorPaymentAmountLessThanMinimum,
    SPErrorCardNotDetected,
    SPErrorResult_IccCardRemoved,
    SPErrorCardWithChip,
    SPErrorReaderOtherAudioPlaying,
    SPErrorReaderTimeout,
    SPErrorUnknown,
    SPErrorReaderAudioPermissionDenied,
    SPErrorReaderCommandNotAvailable,
    SPErrorReaderIllegalState,
    SPErrorReaderAudioFailedToStart,
    SPErrorConnection400,
    SPErrorConection500,
    SPErrorAppInvalidBundleIdentifier,
    SPErrorAuthUserNotFound,
    SPErrorPaymentNotAuthorized,
    SPErrorPaymentAmountNotAllowed,
    SPErrorAuthNoSecretOrToken,
    SPNoError,
    SPErrorAlreadyAssociatedException,
    SPErrorAlreadyExistsException,
    SPErrorBankAccountAlreadyDeletedException,
    SPErrorCardInformationNotFoundException,
    SPErrorCfdiException,
    SPErrorCreateInvoiceException,
    SPErrorInactiveClientException,
    SPErrorInactiveUserException,
    SPErrorInternalException,
    SPErrorAccountInvalidException,
    SPErrorAccountInvalidTypeException,
    SPErrorInvalidAuthCodeException,
    SPErrorInvalidAuthTokenException,
    SPErrorInvalidAuthInformationException,
    SPErrorInvalidBalanceException,
    SPErrorInvalidCredentialsException,
    SPErrorInvalidEncryptionException,
    SPErrorInvalidNotificationException,
    SPErrorInvalidParamException,
    SPErrorInvalidRestrictionException,
    SPErrorInvalidTransactionException,
    SPErrorInvoiceNotFoundException,
    SPErrorInvalidMessageDeliveryException,
    SPErrorMethodNotAllowedException,
    SPErrorBankAccountNotAuthorizedException,
    SPErrorOperatorNotFoundException,
    SPErrorPaymentException,
    SPErrorReceiptNotFoundException,
    SPErrorRemoteCommunicationException,
    SPErrorServiceUnavailableException,
    SPErrorSignatureNotFoundException,
    SPErrorSwitchException,
    SPErrorVoucherNotFoundException,
    SPErrorNoBTDevicesFound,
    SPErrorValueOutOfRange,
    SPErrorRequestPINEntry,
    SPErrorBluetoothInactive,
    SPErrorPOSNoResponse
};

typedef NS_ENUM(NSInteger, SPReaderType){
    SP_READER_NONE,
    SP_READER_AUDIO,
    SP_READER_BLUETOOTH,
    SP_READER_AUDIO_QPOS
};

//typedef void (^SPOnSuccess)(NSObject* responseObject);
//typedef void (^SPOnError)(NSError *error);

#endif /* SrPagoDefinitions_h */
