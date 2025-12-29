ENV['sub'] = '1'

platform :ios, '16.0'

target 'XAuth' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for XAuth

end

# =======================================================
# TAMBAHKAN SCRIPT DI BAWAH INI (POST INSTALL HOOK)
# =======================================================
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        # Paksa semua target Pods untuk menggunakan iOS 16.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end