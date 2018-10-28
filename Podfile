platform :ios, '9.0'

target 'RiverOakRegistration' do
  use_frameworks!

  # Pods for RiverOakRegistration
pod 'RealmSwift'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = false
        end
    end
end
