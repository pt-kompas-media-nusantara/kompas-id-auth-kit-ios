default_platform(:ios)

platform :ios do
  
  desc "Build all configurations in serial using gym and deploy"
  lane :lane_multi_deployment do
    config_results = lane_context[:CONFIGURATION_RESULTS]
    build_numbers = lane_context[:BUILD_NUMBERS_BY_GROUP]
    match_results = lane_context[:MATCH_RESULTS_BY_GROUP]
    version_number = lane_context[SharedValues::VERSION_NUMBER]
    deployment = lane_context[:SELECTED_DEPLOYMENT_VALUE]
    notes = lane_context[:NOTES]
    api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]

    puts "load config_results: #{config_results}"
    puts "load build_numbers: #{build_numbers}"
    puts "load match_results: #{match_results}"
    puts "load version_number: #{version_number}"
    puts "load deployment: #{deployment}"
    puts "load notes: #{notes}"
    puts "load api_key: #{api_key}"

    raise "Missing CONFIGURATION_RESULTS or BUILD_NUMBERS_BY_GROUP or VERSION_NUMBER" unless config_results && build_numbers && version_number

    config_results.each do |group, data|
      sigh_profile_type = match_results[group][:sigh_profile_type]
      current_profile_mapping = match_results[group][:profile_mapping]
      app_identifier = data[:app_identifiers][0]

      data[:configurations].each_with_index do |configuration, index|
        scheme = data[:schemes][index]
        build_number_key = "#{group}_#{configuration}"
        build_number = build_numbers[build_number_key]

        output_dir = "./automation/gym/#{group.downcase}_#{scheme.downcase}/#{version_number}_#{build_number}"
        output_name = "kompasid_#{scheme}_#{version_number}_#{build_number}.ipa"
        archive_path = "#{output_dir}/archive.xcarchive"
        build_path = "#{output_dir}/build"
        derived_data_path = "#{output_dir}/derived"
        ipa_path = File.join(output_dir, output_name)

        # Build
        UI.header("🏗️ Building #{group}/#{scheme} (#{configuration})")
        increment_build_number(build_number: build_number)

        gym(
          workspace: WORKSPACE_APP,
          scheme: scheme,
          configuration: configuration,
          export_method: sigh_profile_type,
          silent: true,
          clean: true,
          output_directory: output_dir,
          output_name: output_name,
          build_path: build_path,
          archive_path: archive_path,
          derived_data_path: derived_data_path,
          export_options: {
            provisioningProfiles: {
              app_identifier => current_profile_mapping[app_identifier]
            },
            compileBitcode: true
          }
        )

        # Deploy langsung setelah build
        UI.header("🚀 Deploying #{group}/#{scheme} via #{deployment}")
        case deployment
        when "Deliver"
          deliver(
            api_key: api_key,
            app_identifier: app_identifier,
            skip_screenshots: true,
            skip_metadata: true,
            skip_app_version_update: true,
            force: true,
            run_precheck_before_submit: false
          )
          UI.success("✅ Deliver finished for #{group}/#{scheme}")

        when "Pilot"
          pilot(
            apple_id: data[:developer_app_id],
            app_identifier: app_identifier,
            skip_waiting_for_build_processing: true,
            skip_submission: true,
            distribute_external: false,
            notify_external_testers: false,
            ipa: ipa_path,
            changelog: notes
          )
          UI.success("✅ Uploaded #{group}/#{scheme} to TestFlight via Pilot")

        when "Testflight"
          upload_to_testflight(
            ipa: ipa_path,
            app_identifier: app_identifier,
            changelog: notes
          )
          UI.success("✅ Uploaded #{group}/#{scheme} to TestFlight via upload_to_testflight")
        else
          UI.error "Unknown deployment method: #{deployment}"
        end
      end
    end
  end


end