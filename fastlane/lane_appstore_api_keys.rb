
default_platform(:ios)

platform :ios do
    # SharedValues::APP_STORE_CONNECT_API_KEY	The App Store Connect API key information used for authorization requests. This hash can be passed directly into the :api_key options on other tools or into Spaceship::ConnectAPI::Token.create method
    desc "App Store Connect Api Key"
    lane :load_app_store_connect_api_key do
        app_store_connect_api_key(
            key_id: APPLE_KEY_ID,
            issuer_id: APPLE_ISSUER_ID,
            key_content: APPLE_KEY_P8_BASE_64,
            is_key_content_base64: true,
            in_house: false # detecting this via ASC private key not currently supported
        )
        puts "save APP_STORE_CONNECT_API_KEY : #{lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]}"
    end

    # load APP_STORE_CONNECT_API_KEY: {:key_id=>"JJVJSLCWQL", :issuer_id=>"69a6de7e-6478-47e3-e053-5b8c7c11a4d1", :key=>"LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JR1RBZ0VBTUJNR0J5cUdTTTQ5QWdFR0NDcUdTTTQ5QXdFSEJIa3dkd0lCQVFRZ3JhbnFpdHZZYkRPWE1RQlEKcFQxNjRUMkdRY0FQK0R6cXozdXhsOHZZSXJlZ0NnWUlLb1pJemowREFRZWhSQU5DQUFTVWZLZGNtZUw2anFmVwpDRllxMWhuMGIzZUZEQmJKR09BSHZCTnAzWm9QZDdVeFloRDM0aU5PTW1aWHJyd0RzcFFYREtDbVljcnVJSEJVCm1rUHlqVHlJCi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=", :is_key_content_base64=>true, :duration=>500, :in_house=>false}
    desc "bundle exec fastlane lane_get_app_store_connect_api_key"
    lane :lane_get_app_store_connect_api_key do
        api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
  
        puts "load APP_STORE_CONNECT_API_KEY: #{api_key}"
        
        if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
            # ERROR
            # [!] Exit status of command 'echo FASTLANE_APP_STORE_CONNECT_API_KEY={:key_id=>"***", :issuer_id=>"***", :key=>"***", :is_key_content_base64=>true, :duration=>500, :in_house=>false} >> $GITHUB_ENV' was 1 instead of 0. (FastlaneCore::Interface::FastlaneShellError) sh: ***,: File name too long
            # sh("echo FASTLANE_APP_STORE_CONNECT_API_KEY=#{api_key} >> $GITHUB_ENV")
            sh("echo FASTLANE_APP_STORE_CONNECT_API_KEY=fastlan api key >> $GITHUB_ENV") # di hardcode karna github tidak 
          end
    end
end