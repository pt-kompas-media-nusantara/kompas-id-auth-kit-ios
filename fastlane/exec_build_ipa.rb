default_platform(:ios)

platform :ios do
  
  # single
  desc "bundle exec fastlane exec_build_ipa"
  lane :exec_build_ipa do
    lane_show_github_values

    lane_select_app_identifiers_by_configuration
    lane_select_deployment_type
    lane_add_notes

    # unless GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
    #   exec_clear_cache_pods
    # sh("make clean")
    # sh("make init_project")
    # end    

    # # setup_produce
    delete_temp_keychain
    setup_credentials
    setup_match_app_identifier
    increment_build_number_from_latest_testflight_auto
    load_gym_configuration
    deployment_type
    delete_temp_keychain

    # LOG OUTPUT
    send_to_logger_get_app_identifiers_by_config_selection
    send_to_logger_get_selected_deployment_type
    send_to_logger_get_notes
    send_to_logger_get_keychain
    send_to_logger_get_app_store_connect_api_key
    send_to_logger_lane_get_match
    send_to_logger_lane_get_latest_testflight_build_number
    send_to_logger_lane_get_version_number
    send_to_logger_lane_get_increment_build_number
    send_to_logger_lane_get_gym
  end

  # multiple
  desc "bundle exec fastlane exec_multi_build_ipa"
  lane :exec_multi_build_ipa do
    lane_show_github_values
    
    lane_multi_select_app_identifiers_by_configuration
    lane_select_deployment_type
    lane_add_notes

    # unless GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
    #   exec_clear_cache_pods
    # end    

    delete_temp_keychain
    setup_credentials
    setup_multi_match_app_identifier
    multi_increment_build_number_from_latest_testflight_auto
    lane_multi_deployment
    delete_temp_keychain

    lane_get_multi_app_identifiers_by_config_selection
    lane_get_selected_deployment_type
    lane_get_notes
    lane_get_keychain
    lane_get_app_store_connect_api_key
    lane_get_multi_match
    lane_get_latest_testflight_build_number
    lane_get_version_number
  end


end


# reference :
# https://www.runway.team/blog/how-to-set-up-a-ci-cd-pipeline-for-your-ios-app-fastlane-github-actions
# https://litoarias.medium.com/continuous-delivery-for-ios-using-fastlane-and-github-actions-edf62ee68ecc



# load SELECTED_CONFIGURATION_KEY: STAGING_DEBUG_CONFIGURATION
# load SELECTED_CONFIGURATION: Staging Debug
# load SELECTED_SCHEME: XAuth Staging Debug
# load CONFIGURATION_GROUP: DEFAULT
# load APP_IDENTIFIER: id.kompas.app.auth
# load APP_IDENTIFIERS: ["id.kompas.app.auth"]

# load SELECTED_DEPLOYMENT_KEY: PRODUCTION_BY_DELIVER
# load SELECTED_DEPLOYMENT_VALUE: Deliver

# load NOTES: Note: aaa

# load ORIGINAL_DEFAULT_KEYCHAIN: 
# load KEYCHAIN_PATH: ~/Library/Keychains/KompasIdAuth

# load APP_STORE_CONNECT_API_KEY: {:key_id=>"JJVJSLCWQL", :issuer_id=>"69a6de7e-6478-47e3-e053-5b8c7c11a4d1", :key=>"LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JR1RBZ0VBTUJNR0J5cUdTTTQ5QWdFR0NDcUdTTTQ5QXdFSEJIa3dkd0lCQVFRZ3JhbnFpdHZZYkRPWE1RQlEKcFQxNjRUMkdRY0FQK0R6cXozdXhsOHZZSXJlZ0NnWUlLb1pJemowREFRZWhSQU5DQUFTVWZLZGNtZUw2anFmVwpDRllxMWhuMGIzZUZEQmJKR09BSHZCTnAzWm9QZDdVeFloRDM0aU5PTW1aWHJyd0RzcFFYREtDbVljcnVJSEJVCm1rUHlqVHlJCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=", :is_key_content_base64=>true, :duration=>500, :in_house=>false}

# load MATCH_PROVISIONING_PROFILE_MAPPING: {"id.kompas.app.auth"=>"match AppStore id.kompas.app.auth"}
# load SIGH_PROFILE_TYPE: app-store

# load VERSION_NUMBER: 1.0.2
# load BUILD_NUMBER: 8

# load IPA_OUTPUT_PATH: /Users/kompasdigital/Documents/work/kompas-id-auth-kit-ios/automation/gym/1.0.2_8/output_directory/kompasid_XAuth Staging Debug_1.0.2_8.ipa
# load PKG_OUTPUT_PATH: 
# load DSYM_OUTPUT_PATH: /Users/kompasdigital/Documents/work/kompas-id-auth-kit-ios/automation/gym/1.0.2_8/output_directory/kompasid_XAuth Staging Debug_1.0.2_8.app.dSYM.zip
# load XCODEBUILD_ARCHIVE: ./automation/gym/1.0.2_8/output_directory/kompasid_XAuth Staging Debug_1.0.2_8.xcarchive
