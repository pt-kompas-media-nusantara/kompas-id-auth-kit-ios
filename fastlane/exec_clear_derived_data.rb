default_platform(:ios)

platform :ios do

  desc "fastlane exec_clear_cache_pods"
  lane :exec_clear_cache_pods do
    clear_derived_data
    sh "rm -rf Podfile.lock Pods"
    sh "rm -rf kompasid.xcworkspace"
    cocoapods(
      repo_update: true,
      clean_install: true,
      verbose: true,
      use_bundle_exec: true,
    )
  end
end