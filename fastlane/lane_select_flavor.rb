default_platform(:ios)

platform :ios do


  # load SELECTED_CONFIGURATION_KEY: RELEASE_CONFIGURATION
  # load SELECTED_CONFIGURATION: Release
  # load SELECTED_SCHEME: Release
  # load CONFIGURATION_GROUP: DEFAULT
  # load APP_IDENTIFIER: id.kompas.app
  # load APP_IDENTIFIERS: ["id.kompas.app", "id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"]
  desc "bundle exec fastlane lane_get_app_identifiers_by_config_selection"
  lane :lane_get_app_identifiers_by_config_selection do
    selected_configuration_key = lane_context[:SELECTED_CONFIGURATION_KEY]
    selected_configuration = lane_context[:SELECTED_CONFIGURATION]
    selected_scheme = lane_context[:SELECTED_SCHEME]
    configuration_group = lane_context[:CONFIGURATION_GROUP]
    identifier_value = lane_context[:APP_IDENTIFIER]
    identifier_values = lane_context[:APP_IDENTIFIERS]
  
    puts "load SELECTED_CONFIGURATION_KEY: #{selected_configuration_key}"
    puts "load SELECTED_CONFIGURATION: #{selected_configuration}"      
    puts "load SELECTED_SCHEME: #{selected_scheme}"      
    puts "load CONFIGURATION_GROUP: #{configuration_group}"
    puts "load APP_IDENTIFIER: #{identifier_value}"
    puts "load APP_IDENTIFIERS: #{identifier_values}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      sh("echo FASTLANE_SELECTED_CONFIGURATION_KEY=#{selected_configuration_key} >> $GITHUB_ENV")
      sh("echo FASTLANE_SELECTED_CONFIGURATION=#{selected_configuration} >> $GITHUB_ENV")
      sh("echo FASTLANE_SELECTED_SCHEME=#{selected_scheme} >> $GITHUB_ENV")
      sh("echo FASTLANE_CONFIGURATION_GROUP=#{configuration_group} >> $GITHUB_ENV")
      sh("echo FASTLANE_APP_IDENTIFIER=#{identifier_value} >> $GITHUB_ENV")
      sh("echo FASTLANE_APP_IDENTIFIERS=#{identifier_values} >> $GITHUB_ENV")
    end
  end


# load group: DEFAULT
# load app_identifiers: ["id.kompas.app", "id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"]
# load scheme: Debug
# load app_id: 1242195037
#       &
# load group: KID
# load app_identifiers: ["id.kompas.app.kid", "id.kompas.app.kid.NotificationServices", "id.kompas.app.kid.PushTemplateExtension"]
# load scheme: RKID_ID
# load app_id: 1234567890
  desc "bundle exec fastlane lane_get_multi_app_identifiers_by_config_selection"
  lane :lane_get_multi_app_identifiers_by_config_selection do

    results = lane_context[:CONFIGURATION_RESULTS]

    results.each do |group, data|  
      configurations = data[:configurations]
      configuration_keys = data[:configuration_keys]
      schemes = data[:schemes]
      app_identifiers = data[:app_identifiers]
      app_id = data[:developer_app_id]

      puts "load group: #{group}"
      puts "load configuration_keys: #{configuration_keys}"
      puts "load configurations: #{configurations}"  
      puts "load schemes: #{schemes}"      
      puts "load app_identifiers: #{app_identifiers}"
      puts "load app_id: #{app_id}"
    end
  end

end


# OUTPUT
# App Identifier 1: id.kompas.app
# App Identifier 2: id.kompas.app.NotificationServices
# App Identifier 3: id.kompas.app.PushTemplateExtension
# selected_value: Release
# selected_key: RELEASE_CONFIGURATION
# group_suffix: DEFAULT
# identifier_values: ["id.kompas.app", "id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"]

# App Identifier 1: id.kompas.app
# App Identifier 2: id.kompas.app.NotificationServices
# App Identifier 3: id.kompas.app.PushTemplateExtension
# selected_value: DQA_ID
# selected_key: DEBUG_CONFIGURATION_QA_ID
# group_suffix: DEFAULT
# identifier_values: ["id.kompas.app", "id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"]
def lane_select_app_identifiers_by_configuration
  if GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
    lane_context[:SELECTED_CONFIGURATIONS] = CONFIGURATIONS
  else
    lane_context[:SELECTED_CONFIGURATIONS] = GITHUB_CONFIGURATION
  end

  selected_configurations = lane_context[:SELECTED_CONFIGURATIONS]
  # Load daftar configuration dan group dari ENV
  config_keys = selected_configurations.to_s.split(",")
  known_groups = CONFIGURATION_GROUPS.to_s.split(",")

  # Bangun peta: { "Debug" => "DEBUG_CONFIGURATION", ... }
  config_map = config_keys.to_h { |key| [ENV[key], key] }

  # Pilih configuration
  selected_value = ""
  selected_key = ""
  if GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
    selected_value = UI.select("Select configuration:", config_map.keys)    
  else
    selected_value = config_map.keys.first
  end
  selected_key = config_map[selected_value]

  # Temukan suffix group berdasarkan key, misalnya "_KID"
  group_suffix = known_groups.find { |suffix| selected_key.include?(suffix) } || "DEFAULT"

  # Ambil daftar nama ENV key untuk group tersebut
  group_keys_csv = ENV["DEVELOPER_APP_IDENTIFIERS_#{group_suffix}"]
  if group_keys_csv.nil? || group_keys_csv.empty?
    UI.user_error!("No developer identifiers found for group '#{group_suffix}' (based on selected key '#{selected_key}')")
  end

  # Ambil value dari ENV
  identifier_keys = group_keys_csv.split(",")
  identifier_values = identifier_keys.map { |key| ENV[key] }

  # Tampilkan hasil
  identifier_values.each_with_index do |val, i|
    UI.message("App Identifier #{i + 1}: #{val}")
  end

  # Ambil APP ID
  app_id_key = "DEVELOPER_APP_ID_#{group_suffix}"
  app_id = ENV[app_id_key] || DEVELOPER_APP_ID

  if app_id.nil? || app_id.empty?
    UI.user_error!("No App ID found for group '#{group_suffix}' (expected ENV key: #{app_id_key} or fallback to DEVELOPER_APP_ID)")
  end

  # Simpan ke lane_context
  lane_context[:SELECTED_CONFIGURATION_KEY] = selected_key
  lane_context[:SELECTED_CONFIGURATION] = selected_value
  lane_context[:SELECTED_SCHEME] = selected_value
  lane_context[:CONFIGURATION_GROUP] = group_suffix
  lane_context[:APP_IDENTIFIERS] = identifier_values
  lane_context[:APP_IDENTIFIER] = identifier_values[0]
  lane_context[:DEVELOPER_APP_ID] = app_id

  puts "save SELECTED_CONFIGURATION_KEY: #{selected_value}"
  puts "save SELECTED_CONFIGURATION: #{selected_key}"
  puts "save SELECTED_SCHEME: #{selected_value}"
  puts "save CONFIGURATION_GROUP: #{group_suffix}"
  puts "save APP_IDENTIFIERS: #{identifier_values[0]}"
  puts "save APP_IDENTIFIERS: #{identifier_values}"
  puts "save DEVELOPER_APP_ID: #{app_id}"
end

# Enter the number(s) of configuration(s) to select (comma-separated):
# 1,5
# Group DEFAULT - App Identifier 1: id.kompas.app
# Group DEFAULT - App Identifier 2: id.kompas.app.NotificationServices
# Group DEFAULT - App Identifier 3: id.kompas.app.PushTemplateExtension
# Group KID - App Identifier 1: id.kompas.app.kid
# Group KID - App Identifier 2: id.kompas.app.kid.NotificationServices
# Group KID - App Identifier 3: id.kompas.app.kid.PushTemplateExtension
# >> Group: DEFAULT
# save Configurations: ["Debug"]
# save configuration_keys: ["DEBUG_CONFIGURATION"]
# save app_identifiers: ["id.kompas.app", "id.kompas.app.NotificationServices", "id.kompas.app.PushTemplateExtension"]
# save developer_app_id: 1242195037
# >> Group: KID
# save Configurations: ["RKID_ID"]
# save configuration_keys: ["RELEASE_CONFIGURATION_KID_ID"]
# save app_identifiers: ["id.kompas.app.kid", "id.kompas.app.kid.NotificationServices", "id.kompas.app.kid.PushTemplateExtension"]
# save developer_app_id: 1234567890
def lane_multi_select_app_identifiers_by_configuration
  config_keys = CONFIGURATIONS.to_s.split(",")
  known_groups = CONFIGURATION_GROUPS.to_s.split(",")

  config_map = config_keys.to_h { |key| [ENV[key], key] }

  # Tampilkan semua pilihan
  puts "Available Configurations:"
  config_map.each_with_index do |(name, key), index|
    puts "puts config_map #{index + 1}. #{name} (#{key})"
  end

  # Minta user input nomor-nomor pilihan (dipisah koma)
  selected_input = ""
  if GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
    selected_input = UI.input("Enter the number(s) of configuration(s) to select (comma-separated):")
  else
    selected_input = GITHUB_CONFIGURATION
  end
  puts "puts selected_input: #{selected_input}"

  selected_indexes = selected_input.split(",").map(&:strip).map(&:to_i)
  selected_values = selected_indexes.map { |i| config_map.keys[i - 1] }
  selected_keys = selected_values.map { |v| config_map[v] }

  selected_groups = selected_keys.map do |key|
    known_groups.find { |suffix| key.include?(suffix) } || "DEFAULT"
  end

  identifier_values_all = []
  app_ids = []

  selected_groups.each_with_index do |group_suffix, index|
    group_keys_csv = ENV["DEVELOPER_APP_IDENTIFIERS_#{group_suffix}"]
    if group_keys_csv.nil? || group_keys_csv.empty?
      UI.user_error!("No developer identifiers found for group '#{group_suffix}' (from #{selected_keys[index]})")
    end

    identifier_keys = group_keys_csv.split(",")
    identifier_values = identifier_keys.map { |key| ENV[key] }

    identifier_values.each_with_index do |val, i|
      UI.message("Group #{group_suffix} - App Identifier #{i + 1}: #{val}")
    end

    identifier_values_all << identifier_values
    app_ids << (ENV["DEVELOPER_APP_ID_#{group_suffix}"] || DEVELOPER_APP_ID)
  end
  puts "puts selected_groups: #{selected_groups}"

  # Simpan hasil per group ke hash
  results_by_group = {}

  selected_groups.each_with_index do |group_suffix, index|
    results_by_group[group_suffix] ||= {
      configurations: [],
      configuration_keys: [],
      schemes: [],
      app_identifiers: [],
      developer_app_id: nil
    }
    
    results_by_group[group_suffix][:configurations] << selected_values[index]
    results_by_group[group_suffix][:configuration_keys] << selected_keys[index]
    results_by_group[group_suffix][:schemes] << selected_values[index]
    results_by_group[group_suffix][:app_identifiers] += identifier_values_all[index]
    results_by_group[group_suffix][:developer_app_id] = app_ids[index]
  end

  # Simpan ke lane_context
  puts "puts results_by_group: #{results_by_group}"
  lane_context[:CONFIGURATION_RESULTS] = results_by_group

  # Debug output
  results_by_group.each do |group, data|
    puts ">> Group: #{group}"
    puts "save configuration_keys: #{data[:configuration_keys]}"
    puts "save Configurations: #{data[:configurations]}"
    puts "save Schemes: #{data[:schemes]}"
    puts "save app_identifiers: #{data[:app_identifiers]}"
    puts "save developer_app_id: #{data[:developer_app_id]}"
  end
end
