platform :ios, '7.0'

inhibit_all_warnings!

target 'Jettison' do
  pod 'BZGFormField', '~> 1.1.2'
  pod 'BZGFormViewController', '~> 2.3.2'
  pod 'Facebook-iOS-SDK', '~> 3.13.1'
  pod 'FormatterKit', '~> 1.4.2'
  pod 'FTiCloudSync', '~> 0.0.1'
  pod 'InAppSettingsKit', '~> 2.0.1'
  pod 'MZFormSheetController', '~> 2.3.4'
  pod 'NewRelicAgent', '~> 3.289'
  pod 'UICKeyChainStore', '~> 1.0.5'
  pod 'VPPLocation', '~> 3.0.0'
end

post_install do | installer |
    require 'fileutils'
    FileUtils.cp_r('Pods/Pods-Jettison-acknowledgements.plist', 'Jettison/InAppSettings.bundle/Acknowledgements.plist', :remove_destination => true)
end
