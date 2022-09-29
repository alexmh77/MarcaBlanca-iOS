# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://gitlab.com/na-at_technologies/fadsdk4/nshare/mobilecard/specs.git'

target 'MarcaBlanca' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # pod 'LBTATools', '1.0.12'
  # pod 'SDWebImage'
  # pod 'ActionSheetPicker-3.0'
  # pod 'JGProgressHUD'
  # pod 'AWSS3'#, '2.13.3'
  # pod 'AWSCore'#, '2.13.3'
  # pod 'Firebase/Analytics'
  # pod 'Firebase/Auth'
  # pod 'Firebase/Messaging', '6.34.0'
  # pod 'SideMenu'
  # pod 'CardScan'
  # pod 'CryptoSwift'
  # pod 'FSCalendar', '2.8.1'
  # pod 'BarcodeScanner', '4.1.3'
  # pod 'OpenTok'
  # pod 'Starscream'
  # pod 'IQKeyboardManagerSwift'
  # pod 'ReachabilitySwift'
  # pod 'SwipeCellKit'
  # pod 'RealmSwift', '4.3.1'
  # pod 'MaterialComponents/TextControls+OutlinedTextAreas'
  # pod 'MaterialComponents/TextControls+OutlinedTextFields'
  # pod 'MaterialComponents/Chips'
  # pod 'MDFInternationalization','~>2.0'
  # pod 'Charts', '3.5.0'
  # pod 'lottie-ios'
  # pod 'UIDrawer', :git => 'https://github.com/Que20/UIDrawer.git', :tag => '1.0'
  # pod 'CCValidator'
  # pod 'CreditCardValidator'
  # pod 'MBCircularProgressBar'
  # pod 'SwipeCellKit'
  # pod 'MGPBarcodeScanner'
  # #pod 'GoogleMaps', '6.0.1'
  # #pod 'GooglePlaces', '6.0.0'
  # pod 'MBRadioButton'
  # pod 'RadioGroup'
  # pod "MediaWatermark"
  #pod 'C60SSDK', :git => 'https://github.com/ProsperasTeam/C60S-iOS.git', :branch => 'claro360sdkV2'
  pod 'C60SSDK', :git => 'https://github.com/ProsperasTeam/C60S-iOS.git', :branch => 'sdk-prosperas' 

  
  #MOBILE CARD
  
  pod 'SrPago-Ecommerce', '1.2.1'
  # pod 'MCVISASDK', :git => 'https://PamelaReyes27@bitbucket.org/mobilecard-workspace/360-sdk-ios.git', :branch => 'main' # M2thETreZE5FG8LEUFyB
  # pod "KRProgressHUD"
  
  target 'MarcaBlancaTests' do
     inherit! :search_paths
     # Pods for testing
   end

   target 'MarcaBlancaUITests' do
     # Pods for testing
   end
   post_install do |installer|
     installer.pods_project.targets.each do |target|
       installer.pods_project.build_configurations.each do |config|
         config.build_settings['ENABLE_BITCODE'] = 'NO'
         config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
         config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
         config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
         config.build_settings['SWIFT_INSTALL_OBJC_HEADER'] = 'NO'
       end

       target.build_configurations.each do |config|
         config.build_settings['ENABLE_BITCODE'] = 'NO'
         config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
         config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
         config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
         config.build_settings['SWIFT_INSTALL_OBJC_HEADER'] = 'NO'
         
         
       end
     end
   end
   
   dynamic_frameworks = ['MobileCardFADModuleManagerPod'] # <- swift libraries names

   # Make all the other frameworks into static frameworks by overriding the static_framework? function to return true
   pre_install do |installer|
     installer.pod_targets.each do |pod|
       if dynamic_frameworks.include?(pod.name)
         puts "Overriding the static_framework? method for #{pod.name}"
         def pod.static_framework?;
           true
         end
         def pod.build_type;
           Pod::BuildType.static_library
         end
       end
     end
   end
 end
