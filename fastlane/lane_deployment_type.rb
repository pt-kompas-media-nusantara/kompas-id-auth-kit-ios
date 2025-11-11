default_platform(:ios)
platform :ios do

  # START =============================================================  
  desc "Upload IPA by Pilot"
  lane :upload_by_pilot do
    app_id = lane_context[:DEVELOPER_APP_ID]
    app_identifier = lane_context[:APP_IDENTIFIER]
    ipa_path = lane_context[SharedValues::IPA_OUTPUT_PATH]
    notes = lane_context[:NOTES]

    pilot(
      apple_id: app_id,
      app_identifier: app_identifier,
      skip_waiting_for_build_processing: true,
      skip_submission: true,
      distribute_external: false,
      notify_external_testers: false,
      ipa: ipa_path,
      changelog: notes
    )
  end

  desc "Upload IPA by Deliver"
  lane :upload_by_deliver do
  api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]

  deliver(
      api_key: api_key,
      skip_screenshots: true,
      skip_metadata: true,
      skip_app_version_update: true,
      force: true, # skips verification of HTML preview file (since this will be run from a CI machine)
      run_precheck_before_submit: false # not supported through ASC API yet
      # submit_for_review: true
      # automatic_release: true
      # phased_release: true
  )  
  end
  # END ===============================================================


end

def deployment_type
  deployment = lane_context[:SELECTED_DEPLOYMENT_VALUE]
  case deployment
  when "Deliver"
    upload_by_deliver
  when "Pilot"
    upload_by_pilot
  when "Testflight"
    notes = lane_context[:NOTES]
    upload_to_testflight(changelog: notes)
  else
    UI.error "Invalid Select Deployment"
  end
end

