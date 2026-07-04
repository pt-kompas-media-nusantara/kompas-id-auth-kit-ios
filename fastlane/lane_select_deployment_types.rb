default_platform(:ios)

platform :ios do
  desc "bundle exec fastlane lane_select_deployment_type"
  lane :lane_select_deployment_type do
    selected_key = ""
    selected_deployment = ""

    if GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      lane_context[:SELECTED_DEPLOYMENT_TYPE] = DEPLOYMENT_TYPES
    else
      lane_context[:SELECTED_DEPLOYMENT_TYPE] = GITHUB_DEPLOYMENT_TYPE
    end

    selected_deployment_types = lane_context[:SELECTED_DEPLOYMENT_TYPE]
    # Ambil dari ENV
    deployment_keys = selected_deployment_types.to_s.split(",")

    # Bikin map: { "Debug" => "DEBUG_CONFIGURATION", ... }
    deployment_map = deployment_keys.to_h { |key| [ENV[key], key] }

    # Ambil list yang ditampilkan ke user
    deployment_values = deployment_map.keys

    # Tampilkan UI.select
    if GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      selected_deployment = UI.select("Select deployment:", deployment_values)
    else
      selected_deployment = deployment_values.first
    end      
    selected_key = deployment_map[selected_deployment]
    
    lane_context[:SELECTED_DEPLOYMENT_VALUE] = selected_deployment
    lane_context[:SELECTED_DEPLOYMENT_KEY] = selected_key		

    puts "save SELECTED_DEPLOYMENT_KEY: #{selected_key}"
    puts "save SELECTED_DEPLOYMENT_VALUE: #{selected_deployment}"
  end

  # load SELECTED_DEPLOYMENT_KEY: DEVELOPMENT_BY_PILOT
  # load SELECTED_DEPLOYMENT_VALUE: Pilot
  desc "bundle exec fastlane lane_get_selected_deployment_type"
  lane :lane_get_selected_deployment_type do
    selected_deployment_value = lane_context[:SELECTED_DEPLOYMENT_VALUE]
    selected_deployment_key = lane_context[:SELECTED_DEPLOYMENT_KEY]		

    puts "load SELECTED_DEPLOYMENT_KEY: #{selected_deployment_key}"
    puts "load SELECTED_DEPLOYMENT_VALUE: #{selected_deployment_value}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      sh("echo FASTLANE_SELECTED_DEPLOYMENT_KEY=#{selected_deployment_key} >> $GITHUB_ENV")
      sh("echo FASTLANE_SELECTED_DEPLOYMENT_VALUE=#{selected_deployment_value} >> $GITHUB_ENV")
    end
  end
end
