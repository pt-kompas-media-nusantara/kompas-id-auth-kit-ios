default_platform(:ios)

platform :ios do

  # reference :
  # - https://docs.fastlane.tools/actions/run_tests/
  # output : 
  # - Outputs/BuildLog/kompasid-prod.log
  # - Outputs/DerivedData
  # - Outputs/DerivedData/Build/ProfileData/D866839F-5A3B-45C8-BE14-4FE13A77F143/Coverage.profdata
  # - Outputs/DerivedData/Build/Products/Debug-iphonesimulator/kompasid.app
  # - Outputs/UnitTest/prod.xcresult
  # - Outputs/UnitTest/compile_commands.json
  # - Outputs/UnitTest/report.html
  # - Outputs/UnitTest/report.junit
  # [16:13:02]: scan output SCAN_DERIVED_DATA_PATH : ./automation/scan/derived_data_path
  # [16:13:02]: scan output SCAN_GENERATED_XCRESULT_PATH : /Users/kompasdigital/Documents/work/nurirppan/ios/kompas-id-ios-cicd/automation/scan/output_directory/dev.xcresult
  # outputnya wajib di simpan di github untuk show and send code coverage
  # ini bisa running via local, hosted, dan github
  desc "bundle exec fastlane exec_unit_tests_by_all_runner"
  lane :exec_unit_tests_by_all_runner do

    lane_get_version_number
    lane_get_build_number

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    send_to_github_scheme(scheme: DEBUG_SCHEME)
    send_to_github_build_version(buildVersion: context_version_number)
    send_to_github_build_number(buildNumber: context_build_number)
    send_to_github_configuration(configuration: DEBUG_CONFIGURATION)

    scan(
      scheme: RELEASE_SCHEME,
      workspace: WORKSPACE_APP,
      configuration: DEBUG_CONFIGURATION,
      clean: true,
      code_coverage: true,
      derived_data_path: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/output_directory",
      buildlog_path: "./automation/scan/#{context_version_number}_#{context_build_number}/buildlog_path",
      result_bundle: true,
      ensure_devices_found: false,
      xcodebuild_formatter: "xcpretty",  # 'xcpretty', 'xcpretty -test'
      output_types: "html,junit,json-compilation-database", 
      xcpretty_args: "--test --no-color"      
      # parameter di bawah ini jangan di pakai karna membuat error
      # include_simulator_logs: true, # error
      # device: "iPhone 14", # ini di jalankan hanya di xcode 14.2
      # use_clang_report_name: true,
      # address_sanitizer: true, # address_sanitizer & thread_sanitizer tidak bisa di gunakan secara bersamaan
      # thread_sanitizer: true
      # output_xctestrun: true # error
      # use_system_scm: true # error
    )

    xcresult_path_by_lane_context = lane_context[SharedValues::SCAN_GENERATED_XCRESULT_PATH]
    xcresult_path = File.absolute_path(xcresult_path_by_lane_context)

    exec_code_coverage_xcov_by_all_runner(path: xcresult_path)
    exec_code_coverage_slather_by_all_runner
    exec_extract_coverage_by_all_runner

  end

# catatan penggunaan puts / print / cetak :
# url_SCAN_DERIVED_DATA_PATH = lane_context[SharedValues::SCAN_DERIVED_DATA_PATH]
# url_SCAN_GENERATED_XCRESULT_PATH = lane_context[SharedValues::SCAN_GENERATED_XCRESULT_PATH]
# puts "scan output SCAN_DERIVED_DATA_PATH : #{url_SCAN_DERIVED_DATA_PATH}"
# puts "scan output SCAN_GENERATED_XCRESULT_PATH : #{url_SCAN_GENERATED_XCRESULT_PATH}"

  desc "bundle exec fastlane exec_unit_tests_by_local"
  lane :exec_unit_tests_by_local do
    lane_get_version_number
    lane_get_build_number

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    remove_automation_folder_by_local

    scan(
      scheme: RELEASE_SCHEME,
      workspace: WORKSPACE_APP,
      configuration: DEBUG_CONFIGURATION,
      clean: true,
      code_coverage: true,
      derived_data_path: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/output_directory",
      buildlog_path: "./automation/scan/#{context_version_number}_#{context_build_number}/buildlog_path",
      result_bundle: true,
      ensure_devices_found: false,
      xcodebuild_formatter: "xcpretty",  # 'xcpretty', 'xcpretty -test'
      output_types: "html,junit,json-compilation-database",
      xcpretty_args: "--test --no-color"
    )
    xcresult_path_by_lane_context = lane_context[SharedValues::SCAN_GENERATED_XCRESULT_PATH]
    xcresult_path = File.absolute_path(xcresult_path_by_lane_context)

    exec_code_coverage_xcov_by_all_runner(path: xcresult_path)
    exec_code_coverage_slather_by_all_runner
    exec_extract_coverage_by_local
  end
    
end
