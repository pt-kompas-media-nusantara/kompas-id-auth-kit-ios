default_platform(:ios)

platform :ios do

  # reference :
  # - https://docs.fastlane.tools/actions/run_tests/
  # - https://timife.hashnode.dev/streamline-your-workflow-automating-app-deployment-to-google-drive-with-github-actions
  # - https://github.com/logickoder/google-drive-upload
  desc "bundle exec fastlane exec_build_app_to_gdrive_by_github"
  lane :exec_build_app_to_gdrive_by_github do
    lane_get_version_number
    lane_get_build_number

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    scan(
      scheme: DEBUG_SCHEME_QA_ID,
      workspace: WORKSPACE_APP,
      configuration: DEBUG_CONFIGURATION,
      clean: true,
      code_coverage: false,
      derived_data_path: "./automation/scan/build_app/#{context_version_number}_#{context_build_number}/derived_data_path",
      output_directory: "./automation/scan/build_app/#{context_version_number}_#{context_build_number}/output_directory",
      buildlog_path: "./automation/scan/build_app/#{context_version_number}_#{context_build_number}/buildlog_path",
      result_bundle: false,
      ensure_devices_found: false,
      build_for_testing: true
    )

    send_to_github_scheme(scheme: DEBUG_SCHEME)
    send_to_github_build_version(buildVersion: context_version_number)
    send_to_github_build_number(buildNumber: context_build_number)
    send_to_github_configuration(configuration: DEBUG_CONFIGURATION_QA_ID)

  end

  desc "bundle exec fastlane exec_build_app_release_app_by_github"
  lane :exec_build_app_release_app_by_github do

    lane_setup_app_version

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]
    
    scan(
      scheme: DEBUG_SCHEME_QA_ID,
      workspace: WORKSPACE_APP,
      configuration: DEBUG_CONFIGURATION_QA_ID,
      clean: true,
      code_coverage: false,
      derived_data_path: "./automation/scan/build_app/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/scan/build_app/#{context_version_number}_#{context_build_number}/output_directory",
      buildlog_path: "./automation/scan/build_app/#{context_version_number}_#{context_build_number}/buildlog_path",
      result_bundle: false,
      ensure_devices_found: false,
      build_for_testing: true
    )

    send_to_github_scheme(scheme: DEBUG_SCHEME_QA_ID)
    send_to_github_build_version(buildVersion: lane_get_app_version[:result_version_number])
    send_to_github_build_number(buildNumber: lane_get_app_version[:result_build_number])
    send_to_github_configuration(configuration: DEBUG_QA_CONFIGURATION)
    send_to_github_app_path_output

  end
    
end

# path app in local laptop use fastlane : /Users/kompasdigital/Documents/work/nurirppan/ios/poc_gdrive/automation/scan/build_app/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app
# path app in local laptop use xcode : /Users/kompasdigital/Library/Developer/Xcode/DerivedData/kompasid-dtenrocxytkkclgdmblzrvrfncyh/Build/Products/Debug-iphonesimulator/dev.app

# qeomid-qe@qeomid-tech.iam.gserviceaccount.com
# 115811961254481149464
# https://drive.google.com/drive/u/5/folders/1EYC5PX9O24VrcHqA18UrmMCAoGh4kfqN -> Debug

# buat :
# - DRIVE_FOLDER_ID_AUTOMATION_TESTS_DEBUG
