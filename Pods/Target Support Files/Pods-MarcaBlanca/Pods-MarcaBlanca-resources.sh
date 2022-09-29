#!/bin/sh
set -e
set -u
set -o pipefail

function on_error {
  echo "$(realpath -mq "${0}"):$1: error: Unexpected failure"
}
trap 'on_error $LINENO' ERR

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
  # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
  # resources to, so exit 0 (signalling the script phase was successful).
  exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/100.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/1024.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/114.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/120.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/128.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/144.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/152.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/16.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/167.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/172.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/180.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/196.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/20.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/216.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/256.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/29.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/32.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/40.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/48.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/50.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/512.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/55.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/57.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/58.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/60.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/64.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/72.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/76.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/80.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/87.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/88.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 102x102.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 234x234.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 66x66.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 92x92.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppleWhiteLogo.imageset/Apple Logo blanco.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/arrow_back.imageset/Back.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/arrow_back.imageset/Back@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/arrow_back.imageset/Back@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background1.imageset/60s Logo pequeño.jpg"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background2.imageset/App back.jpg"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background3.imageset/Back Home@5x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background4.imageset/Back@5x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/BackgroundHome.imageset/Back User@5x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_mail.imageset/Boton mail.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_mail.imageset/Boton mail@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_mail.imageset/Boton mail@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_verde.imageset/Boton verde.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_verde.imageset/Boton Verde@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_verde.imageset/Boton Verde@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60Sicon.imageset/prosperas-splash-image.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60SiconWhite.imageset/Sombra Logo blanca.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60SiconWhite.imageset/Sombra Logo blanca@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60SiconWhite.imageset/Sombra Logo blanca@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/clabe_icon.imageset/Cuenta clabe.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/clabe_icon.imageset/Cuenta clabe@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/clabe_icon.imageset/Cuenta clabe@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/CoinsIcon.imageset/Icono Monedas.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/CoinsIcon.imageset/Icono Monedas@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/CoinsIcon.imageset/Icono Monedas@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/col.imageset/emojione:flag-for-colombia.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/col.imageset/emojione:flag-for-colombia@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/col.imageset/emojione:flag-for-colombia@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/mex.imageset/emojione:flag-for-mexico.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/mex.imageset/emojione:flag-for-mexico@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/mex.imageset/emojione:flag-for-mexico@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/peru.imageset/emojione:flag-for-peru.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/peru.imageset/emojione:flag-for-peru@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/peru.imageset/emojione:flag-for-peru@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/usa.imageset/emojione:flag-for-united-states.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/usa.imageset/emojione:flag-for-united-states@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/usa.imageset/emojione:flag-for-united-states@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/expand_more.imageset/baseline_expand_more_black_48pt_1x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/expand_more.imageset/baseline_expand_more_black_48pt_2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/expand_more.imageset/baseline_expand_more_black_48pt_3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/FacebookLogo.imageset/Logo Facebook blanco.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/fingerprintIcon.imageset/baseline_fingerprint_black_48pt_1x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/fingerprintIcon.imageset/baseline_fingerprint_black_48pt_2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/fingerprintIcon.imageset/baseline_fingerprint_black_48pt_3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon.imageset/Validacion de identificacion.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon.imageset/Validacion de identificacion@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon.imageset/Validacion de identificacion@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon2.imageset/Verificacion de identidad.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon2.imageset/Verificacion de identidad@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon2.imageset/Verificacion de identidad@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/kycSuccess.imageset/Verificacion de identidad@1x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/kycSuccess.imageset/Verificacion de identidad@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/kycSuccess.imageset/Verificacion de identidad@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/lounch.imageset/prosperas-splash-image-1.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/lounch.imageset/prosperas-splash-image-2.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/lounch.imageset/prosperas-splash-image.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/marketplaceTest.imageset/Santander.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/money.imageset/money.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/money.imageset/money@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/money.imageset/money@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/ProfileIcon.imageset/ProfileIcon.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SettingsIcon.imageset/SettingsIcon.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Sparky1.imageset/Sparky 01.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Sparky2.imageset/Sparky 02.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SparkyFail.imageset/Sparky 03 Fail.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SparkyWelcome.imageset/Sparky Welcome.jpg"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Formal.imageset/Comercio Formal.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Formal.imageset/Comercio Formal@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Formal.imageset/Comercio Formal@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Informal.imageset/Comercio Informal.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Informal.imageset/Comercio Informal@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Informal.imageset/Comercio Informal@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Personal.imageset/Icono Personal.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Personal.imageset/Icono Personal@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Personal.imageset/Icono Personal@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/termsconditions.imageset/Terminos y condiciones.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/termsconditions.imageset/Terminos y condiciones@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/termsconditions.imageset/Terminos y condiciones@3x.png"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/Base.lproj/LaunchScreen.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/Base.lproj/Main.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/Base.lproj/SurveyFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/AmountCollectionViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/ComercialFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/ComercialFormalFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/LoanRequest.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/RegisterFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/SurveyFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/HomeCollectionViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomHeaderView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomDocumentViews.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomInstructions.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/IdPreviewStoryboard.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomSelfieInstructions.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomSelfiePreview.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CreditTypeCollectionViewCell.nib"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/C60SSDK/C60S.bundle"
  install_resource "${PODS_ROOT}/FADModuleIdPod/FADModuleIdPod.bundle"
  install_resource "${PODS_ROOT}/FADModuleOtherDocumentsPod/FADModuleOtherDocumentsPod.bundle"
  install_resource "${PODS_ROOT}/FADModuleResultsPod/FADModuleResultsPod.bundle"
  install_resource "${PODS_ROOT}/FADModuleSelfiePod/FADModuleSelfiePod.bundle"
  install_resource "${PODS_ROOT}/FADSMSPod/FADSMSPod.bundle"
  install_resource "${PODS_ROOT}/FADSurveysPod/FADSurveysPod.bundle"
  install_resource "${PODS_ROOT}/MobileCardFADModuleManagerPod/FADModuleManagerPod.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/100.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/1024.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/114.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/120.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/128.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/144.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/152.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/16.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/167.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/172.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/180.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/196.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/20.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/216.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/256.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/29.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/32.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/40.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/48.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/50.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/512.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/55.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/57.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/58.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/60.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/64.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/72.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/76.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/80.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/87.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/88.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 102x102.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 234x234.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 66x66.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppIcon.appiconset/playstore 92x92.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/AppleWhiteLogo.imageset/Apple Logo blanco.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/arrow_back.imageset/Back.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/arrow_back.imageset/Back@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/arrow_back.imageset/Back@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background1.imageset/60s Logo pequeño.jpg"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background2.imageset/App back.jpg"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background3.imageset/Back Home@5x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Background4.imageset/Back@5x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/BackgroundHome.imageset/Back User@5x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_mail.imageset/Boton mail.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_mail.imageset/Boton mail@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_mail.imageset/Boton mail@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_verde.imageset/Boton verde.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_verde.imageset/Boton Verde@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/boton_verde.imageset/Boton Verde@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60Sicon.imageset/prosperas-splash-image.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60SiconWhite.imageset/Sombra Logo blanca.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60SiconWhite.imageset/Sombra Logo blanca@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/C60SiconWhite.imageset/Sombra Logo blanca@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/clabe_icon.imageset/Cuenta clabe.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/clabe_icon.imageset/Cuenta clabe@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/clabe_icon.imageset/Cuenta clabe@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/CoinsIcon.imageset/Icono Monedas.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/CoinsIcon.imageset/Icono Monedas@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/CoinsIcon.imageset/Icono Monedas@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/col.imageset/emojione:flag-for-colombia.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/col.imageset/emojione:flag-for-colombia@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/col.imageset/emojione:flag-for-colombia@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/mex.imageset/emojione:flag-for-mexico.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/mex.imageset/emojione:flag-for-mexico@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/mex.imageset/emojione:flag-for-mexico@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/peru.imageset/emojione:flag-for-peru.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/peru.imageset/emojione:flag-for-peru@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/peru.imageset/emojione:flag-for-peru@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/usa.imageset/emojione:flag-for-united-states.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/usa.imageset/emojione:flag-for-united-states@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Countries/usa.imageset/emojione:flag-for-united-states@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/expand_more.imageset/baseline_expand_more_black_48pt_1x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/expand_more.imageset/baseline_expand_more_black_48pt_2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/expand_more.imageset/baseline_expand_more_black_48pt_3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/FacebookLogo.imageset/Logo Facebook blanco.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/fingerprintIcon.imageset/baseline_fingerprint_black_48pt_1x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/fingerprintIcon.imageset/baseline_fingerprint_black_48pt_2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/fingerprintIcon.imageset/baseline_fingerprint_black_48pt_3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon.imageset/Validacion de identificacion.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon.imageset/Validacion de identificacion@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon.imageset/Validacion de identificacion@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon2.imageset/Verificacion de identidad.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon2.imageset/Verificacion de identidad@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/id_icon2.imageset/Verificacion de identidad@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/kycSuccess.imageset/Verificacion de identidad@1x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/kycSuccess.imageset/Verificacion de identidad@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/kycSuccess.imageset/Verificacion de identidad@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/lounch.imageset/prosperas-splash-image-1.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/lounch.imageset/prosperas-splash-image-2.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/lounch.imageset/prosperas-splash-image.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/marketplaceTest.imageset/Santander.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/money.imageset/money.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/money.imageset/money@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/money.imageset/money@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/ProfileIcon.imageset/ProfileIcon.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SettingsIcon.imageset/SettingsIcon.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Sparky1.imageset/Sparky 01.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/Sparky2.imageset/Sparky 02.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SparkyFail.imageset/Sparky 03 Fail.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SparkyWelcome.imageset/Sparky Welcome.jpg"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Formal.imageset/Comercio Formal.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Formal.imageset/Comercio Formal@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Formal.imageset/Comercio Formal@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Informal.imageset/Comercio Informal.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Informal.imageset/Comercio Informal@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Comercio Informal.imageset/Comercio Informal@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Personal.imageset/Icono Personal.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Personal.imageset/Icono Personal@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/SurveyIcons/Personal.imageset/Icono Personal@3x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/termsconditions.imageset/Terminos y condiciones.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/termsconditions.imageset/Terminos y condiciones@2x.png"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets/termsconditions.imageset/Terminos y condiciones@3x.png"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/Base.lproj/LaunchScreen.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/Base.lproj/Main.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/Base.lproj/SurveyFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/AmountCollectionViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/ComercialFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/ComercialFormalFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/LoanRequest.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/RegisterFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/SurveyFlow.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/HomeCollectionViewCell.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomHeaderView.nib"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomDocumentViews.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomInstructions.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/IdPreviewStoryboard.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomSelfieInstructions.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CustomSelfiePreview.storyboardc"
  install_resource "${BUILT_PRODUCTS_DIR}/C60SSDK/C60SSDK.framework/CreditTypeCollectionViewCell.nib"
  install_resource "${PODS_ROOT}/C60SSDK/C60S/Assets.xcassets"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/C60SSDK/C60S.bundle"
  install_resource "${PODS_ROOT}/FADModuleIdPod/FADModuleIdPod.bundle"
  install_resource "${PODS_ROOT}/FADModuleOtherDocumentsPod/FADModuleOtherDocumentsPod.bundle"
  install_resource "${PODS_ROOT}/FADModuleResultsPod/FADModuleResultsPod.bundle"
  install_resource "${PODS_ROOT}/FADModuleSelfiePod/FADModuleSelfiePod.bundle"
  install_resource "${PODS_ROOT}/FADSMSPod/FADSMSPod.bundle"
  install_resource "${PODS_ROOT}/FADSurveysPod/FADSurveysPod.bundle"
  install_resource "${PODS_ROOT}/MobileCardFADModuleManagerPod/FADModuleManagerPod.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find -L "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
