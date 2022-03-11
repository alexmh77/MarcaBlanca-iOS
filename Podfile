# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://gitlab.com/na-at_technologies/fadsdk4/nshare/mobilecard/specs.git'
target 'MarcaBlanca' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'C60SSDK', :git => 'https://github.com/Soluciones-de-Buro-Moviles-S-A-de-C-V/C60S-iOS.git', :branch => 'claro360'
  # Pods for MarcaBlanca

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
      end

      target.build_configurations.each do |config|
        config.build_settings['ENABLE_BITCODE'] = 'NO'
        config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
      end
    end
  end
end
