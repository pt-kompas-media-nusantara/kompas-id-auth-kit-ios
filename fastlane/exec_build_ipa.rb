default_platform(:ios)

platform :ios do
  
  # single
  desc "bundle exec fastlane exec_build_ipa"
  lane :exec_build_ipa do
    lane_show_github_values

    lane_select_app_identifiers_by_configuration
    lane_select_deployment_type
    lane_add_notes

    unless GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      exec_clear_cache_pods
    end    

    # setup_produce
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

    unless GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      exec_clear_cache_pods
    end    

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