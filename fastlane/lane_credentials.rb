

default_platform(:ios)

platform :ios do
    
  desc "fastlane remove_credentials"
  lane :remove_credentials do
    delete_temp_keychain(TEMP_KEYCHAIN_USER)
  end

  desc "Setup Credentials"
  lane :setup_credentials do
    ensure_temp_keychain
    load_app_store_connect_api_key

    api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
    key_path = lane_context[SharedValues::KEYCHAIN_PATH]

# SharedValues::CERT_FILE_PATH	The path to the certificate
# SharedValues::CERT_CERTIFICATE_ID	The id of the certificate
# cert : dipakai kalau laptopnya bermasalah atau tidak login (tidak punya fastlane match)
    # cert(
    #   api_key: api_key,
    #   # keychain_path: key_path, -> tidak terpakai
    #   keychain_password: TEMP_KEYCHAIN_PASSWORD
    # )

  end

  # load ORIGINAL_DEFAULT_KEYCHAIN: 
  # load KEYCHAIN_PATH: ~/Library/Keychains/kompasid
  desc "bundle exec fastlane lane_get_keychain"
  lane :lane_get_keychain do
    keychain = lane_context[SharedValues::ORIGINAL_DEFAULT_KEYCHAIN]
    keychain_path = lane_context[SharedValues::KEYCHAIN_PATH]

    puts "load ORIGINAL_DEFAULT_KEYCHAIN: #{keychain}"
    puts "load KEYCHAIN_PATH: #{keychain_path}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      sh("echo FASTLANE_ORIGINAL_DEFAULT_KEYCHAIN=#{keychain} >> $GITHUB_ENV")
      sh("echo FASTLANE_KEYCHAIN_PATH=#{keychain_path} >> $GITHUB_ENV")
    end
  end

end


# ==================================KEYCHAIN STORE TEMPORARY==================================== # 
  def delete_temp_keychain
    delete_keychain(
      name: TEMP_KEYCHAIN_USER
    ) if File.exist? File.expand_path("~/Library/Keychains/#{TEMP_KEYCHAIN_USER}-db")
  end

# SharedValues::ORIGINAL_DEFAULT_KEYCHAIN	The path to the default keychain
# SharedValues::KEYCHAIN_PATH	The path of the keychain
  def create_temp_keychain
    create_keychain(
      name: TEMP_KEYCHAIN_USER,
      password: TEMP_KEYCHAIN_PASSWORD,
      unlock: false,
      timeout: 0
    )
    puts "save ORIGINAL_DEFAULT_KEYCHAIN: #{lane_context[SharedValues::ORIGINAL_DEFAULT_KEYCHAIN]}"
    puts "save KEYCHAIN_PATH: #{lane_context[SharedValues::KEYCHAIN_PATH]}"
  end
  
  def ensure_temp_keychain
    delete_temp_keychain
    create_temp_keychain
  end


# atau bisa pakai 
# import_certificate(
#   certificate_path: "/Users/kompasdigital/Documents/work/nurirppan/ios/kompas-id-ios-release/Save/Certificated/CICD_nurirppan_cert.p12",
#   certificate_password: "nurirppan@28",
#   # certificate_path: ENV["SIGNING_KEY_FILE_PATH"],
#   # certificate_password: "ENV["SIGNING_KEY_PASSWORD"]",
#   keychain_name: TEMP_KEYCHAIN_USER,
#   keychain_password: TEMP_KEYCHAIN_PASSWORD
# )

# SharedValues::SIGH_PROFILE_PATH	A path in which certificates, key and profile are exported
# SharedValues::SIGH_PROFILE_PATHS	Paths in which certificates, key and profile are exported
# SharedValues::SIGH_UUID	UUID (Universally Unique IDentifier) of a provisioning profile
# SharedValues::SIGH_NAME	The name of the profile
# SharedValues::SIGH_PROFILE_TYPE	The profile type, can be app-store, ad-hoc, development, enterprise, developer-id, can be used in build_app as a default value for export_method
# sigh(
#   api_key: api_key,
#   readonly: false
# )
