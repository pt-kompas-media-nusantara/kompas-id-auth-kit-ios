default_platform(:ios)

platform :ios do

  # GITHUB

  desc "send_to_github_coverage"
  lane :send_to_github_coverage do |values|
      sh("echo COVERAGE_FASTLANE=#{values[:coverage]} >> $GITHUB_ENV")
  end    

  desc "send_to_github_ipa_path_output"
  lane :send_to_github_ipa_path_output do
      ipa_path_output_context = lane_context[SharedValues::IPA_OUTPUT_PATH]
      
      sh("echo IPA_OUTPUT_PATH_FASTLANE=#{ipa_path_output_context} >> $GITHUB_ENV")
  end

  desc "send_to_github_app_path_output"
  lane :send_to_github_app_path_output do
      app_path_output_context = lane_context[SharedValues::SCAN_DERIVED_DATA_PATH]
      
      sh("echo APP_OUTPUT_PATH_FASTLANE=#{app_path_output_context}/Build/Products/DebugQA-iphonesimulator/dev.app >> $GITHUB_ENV")
  end
  
  desc "bundle exec fastlane exec_multi_build_ipa"
  lane :lane_show_github_values do
    puts "show GITHUB_DEPLOYMENT_TYPE: #{GITHUB_DEPLOYMENT_TYPE}"
    puts "show GITHUB_CONFIGURATION: #{GITHUB_CONFIGURATION}"
    puts "show GITHUB_BUILD_NUMBER: #{GITHUB_BUILD_NUMBER}"
    puts "show GITHUB_VERSION_NUMBER: #{GITHUB_VERSION_NUMBER}"
    puts "show GITHUB_NOTE: #{GITHUB_NOTE}"
  end


# START =============================================================
  # FASTLANE
  desc "send_to_logger_get_app_identifiers_by_config_selection"
  lane :send_to_logger_get_app_identifiers_by_config_selection do
    lane_get_app_identifiers_by_config_selection
  end

  desc "send_to_logger_get_selected_deployment_type"
  lane :send_to_logger_get_selected_deployment_type do
    lane_get_selected_deployment_type
  end

  desc "send_to_logger_get_notes"
  lane :send_to_logger_get_notes do
    lane_get_notes
  end

  desc "send_to_logger_get_keychain"
  lane :send_to_logger_get_keychain do
    lane_get_keychain
  end

  desc "send_to_logger_get_app_store_connect_api_key"
  lane :send_to_logger_get_app_store_connect_api_key do
    lane_get_app_store_connect_api_key
  end

  desc "send_to_logger_lane_get_match"
  lane :send_to_logger_lane_get_match do
    lane_get_match
  end

  desc "send_to_logger_lane_get_latest_testflight_build_number"
  lane :send_to_logger_lane_get_latest_testflight_build_number do
    lane_get_latest_testflight_build_number
  end

  desc "send_to_logger_lane_get_version_number"
  lane :send_to_logger_lane_get_version_number do
    lane_get_version_number
  end

  desc "send_to_logger_lane_get_increment_build_number"
  lane :send_to_logger_lane_get_increment_build_number do
    lane_get_increment_build_number
  end

  desc "send_to_logger_lane_get_gym"
  lane :send_to_logger_lane_get_gym do
    lane_get_gym
  end
# END ===============================================================
end


