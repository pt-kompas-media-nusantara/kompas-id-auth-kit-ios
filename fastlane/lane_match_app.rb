
default_platform(:ios)

platform :ios do

  desc "Setup App Automatic"
  lane :setup_match_app_identifier do

    api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
    identifier_values = lane_context[:APP_IDENTIFIERS]
        
    match(
      type: TYPE_MATCH_APPSTORE,
      app_identifier: identifier_values,
      git_basic_authorization: Base64.strict_encode64(GIT_AUTHORIZATION),
      readonly: true, # jika masa sertifikat habis valuenya adalah false agar ter generate certificate yang baru, setelah itu ubah ke true lagi agar tidak selalu generate certificate yang baru (di set ke false jika certificate yang di git sudah di hapus)
      keychain_name: TEMP_KEYCHAIN_USER,
      keychain_password: TEMP_KEYCHAIN_PASSWORD,
      api_key: api_key
    )
    puts "save MATCH_PROVISIONING_PROFILE_MAPPING: #{lane_context[SharedValues::MATCH_PROVISIONING_PROFILE_MAPPING]}"
    puts "save SIGH_PROFILE_TYPE: #{lane_context[SharedValues::SIGH_PROFILE_TYPE]}"
  end

  # load MATCH_PROVISIONING_PROFILE_MAPPING: {"id.kompas.app"=>"match AppStore id.kompas.app", "id.kompas.app.NotificationServices"=>"match AppStore id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"=>"match AppStore id.kompas.app.PushTemplateExtension"}
  # load SIGH_PROFILE_TYPE: app-store
  desc "bundle exec fastlane lane_get_match"
  lane :lane_get_match do
    match_provisioning_profile_mapping = lane_context[SharedValues::MATCH_PROVISIONING_PROFILE_MAPPING]
    sigh_profile_type = lane_context[SharedValues::SIGH_PROFILE_TYPE]

    puts "load MATCH_PROVISIONING_PROFILE_MAPPING: #{match_provisioning_profile_mapping}"
    puts "load SIGH_PROFILE_TYPE: #{sigh_profile_type}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      # sh("echo FASTLANE_MATCH_PROVISIONING_PROFILE_MAPPING=#{match_provisioning_profile_mapping} >> $GITHUB_ENV")
      sh("echo FASTLANE_MATCH_PROVISIONING_PROFILE_MAPPING=match_provisioning_profile_mapping >> $GITHUB_ENV")
      sh("echo FASTLANE_SIGH_PROFILE_TYPE=#{sigh_profile_type} >> $GITHUB_ENV")
    end
  end

  # save MATCH_RESULTS_BY_GROUP: {"DEFAULT"=>{:profile_mapping=>{"id.kompas.app"=>"match AppStore id.kompas.app", "id.kompas.app.NotificationServices"=>"match AppStore id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"=>"match AppStore id.kompas.app.PushTemplateExtension"}, :sigh_profile_type=>"app-store"}}
  desc "Setup match certs for all selected app identifiers"
  lane :setup_multi_match_app_identifier do
    results = lane_context[:CONFIGURATION_RESULTS]
    api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]

    match_results_by_group = {}

    results.each do |group, data|
      app_identifiers = data[:app_identifiers]
      app_id = data[:developer_app_id]

      match(
        type: TYPE_MATCH_APPSTORE,
        app_identifier: app_identifiers,
        git_basic_authorization: Base64.strict_encode64(GIT_AUTHORIZATION),
        readonly: true, # true atau false(renew)
        keychain_name: TEMP_KEYCHAIN_USER,
        keychain_password: TEMP_KEYCHAIN_PASSWORD,
        api_key: api_key
      )

      # Simpan hasil match ke hash per group
      match_results_by_group[group] = {
        profile_mapping: lane_context[SharedValues::MATCH_PROVISIONING_PROFILE_MAPPING],
        sigh_profile_type: lane_context[SharedValues::SIGH_PROFILE_TYPE]
      }
      # Simpan ke lane_context global
      lane_context[:MATCH_RESULTS_BY_GROUP] = match_results_by_group
            
      puts "save MATCH_RESULTS_BY_GROUP: #{lane_context[:MATCH_RESULTS_BY_GROUP]}"
    end
  end

  # >> Match result for group: DEFAULT
  # load profile_mapping: {"id.kompas.app"=>"match AppStore id.kompas.app", "id.kompas.app.NotificationServices"=>"match AppStore id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"=>"match AppStore id.kompas.app.PushTemplateExtension"}
  # load sigh_profile_type: app-store
  desc "Get provisioning profile info per group"
  lane :lane_get_multi_match do
    match_results = lane_context[:MATCH_RESULTS_BY_GROUP]

    match_results.each do |group, data|
      puts ">> Match result for group: #{group}"
      puts "load profile_mapping: #{data[:profile_mapping]}"
      puts "load sigh_profile_type: #{data[:sigh_profile_type]}"
    end
  end



end

