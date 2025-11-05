default_platform(:ios)

platform :ios do

  # START =============================================================
  # load VERSION_NUMBER: 3.52.0
  desc "lane_get_version_number_from_xcode"
  lane :lane_get_version_number_from_xcode do
    configuration_name = lane_context[:CONFIGURATION_NAME]

    get_version_number(
      xcodeproj: XCODEPROJ_APP,
      target: TARGET_BY,
      configuration: configuration_name
    )
    puts "save VERSION_NUMBER: #{lane_context[SharedValues::VERSION_NUMBER]}"
  end

  desc "bundle exec fastlane lane_get_version_number"
  lane :lane_get_version_number do
    version_number = lane_context[SharedValues::VERSION_NUMBER]
    puts "load VERSION_NUMBER: #{version_number}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      sh("echo FASTLANE_VERSION_NUMBER=#{version_number} >> $GITHUB_ENV")
    end
  end
  # END ===============================================================


  # START =============================================================
  desc "lane_latest_testflight_build_number"
  lane :lane_latest_testflight_build_number do

    api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    identifier_value = lane_context[:APP_IDENTIFIER]

    latest_testflight_build_number(
      api_key: api_key,
      version: context_version_number,
      app_identifier: identifier_value
    )
    puts "save LATEST_TESTFLIGHT_VERSION: #{lane_context[SharedValues::LATEST_TESTFLIGHT_VERSION]}"
    puts "save LATEST_TESTFLIGHT_BUILD_NUMBER: #{lane_context[SharedValues::LATEST_TESTFLIGHT_BUILD_NUMBER]}"
  end

  # latest_testflight_version: 3.53.0
  # latest_testflight_build_number: 33
  desc "bundle exec fastlane lane_get_latest_testflight_build_number"
  lane :lane_get_latest_testflight_build_number do
    latest_testflight_version = lane_context[:LATEST_TESTFLIGHT_VERSION]		
    latest_testflight_build_number = lane_context[:LATEST_TESTFLIGHT_BUILD_NUMBER]
    
    puts "latest_testflight_version: #{latest_testflight_version}"
    puts "latest_testflight_build_number: #{latest_testflight_build_number}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      sh("echo FASTLANE_LATEST_TESTFLIGHT_VERSION=#{latest_testflight_version} >> $GITHUB_ENV")
      sh("echo FASTLANE_LATEST_TESTFLIGHT_BUILD_NUMBER=#{latest_testflight_build_number} >> $GITHUB_ENV")
    end
  end
  # END ===============================================================


  # START =============================================================
  desc "lane_increment_build_number"
  lane :lane_increment_build_number do

    context_build_number = lane_context[SharedValues::LATEST_TESTFLIGHT_BUILD_NUMBER]

    increment_build_number(
      build_number: (context_build_number.to_i + 1),
    )
    puts "save BUILD_NUMBER: #{lane_context[SharedValues::BUILD_NUMBER]}"
  end
  
  # build_number: 34
  desc "bundle exec fastlane lane_get_increment_build_number"
  lane :lane_get_increment_build_number do
      build_number = lane_context[SharedValues::BUILD_NUMBER]
      
      puts "build_number: #{build_number}"

      if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
        sh("echo FASTLANE_BUILD_NUMBER=#{build_number} >> $GITHUB_ENV")
      end
  end
  # END ===============================================================

  # START =============================================================
  # save BUILD_NUMBERS_BY_GROUP: {"DEFAULT_Debug"=>38, "DEFAULT_Release"=>39}
  desc "Increment build number per group based on selected config groups"
  lane :lane_multi_increment_build_number do
    config_results = lane_context[:CONFIGURATION_RESULTS]
    raise "CONFIGURATION_RESULTS not set!" unless config_results
  
    group_count = config_results.keys.size
  
    # Ambil build number terakhir dari TestFlight sebagai dasar (fallback: 1)
    latest_build_number = lane_context[SharedValues::LATEST_TESTFLIGHT_BUILD_NUMBER].to_i
    base_build_number = latest_build_number > 0 ? latest_build_number : 1
  
    build_numbers_by_group = {}

    index = 0
    config_results.each do |group, data|
      data[:configurations].each do |config_name|
        index += 1
        new_build_number = base_build_number + index

        # Jalankan increment_build_number (opsional, karena build_number disimpan ke project file)
        increment_build_number(
          build_number: new_build_number
        )

        # Simpan berdasarkan group+config agar tidak overwrite
        build_numbers_by_group["#{group}_#{config_name}"] = new_build_number

        puts "Assigned build number #{new_build_number} to #{group} / #{config_name}"
      end
    end
  
    # Simpan hasil build number per group ke lane_context
    lane_context[:BUILD_NUMBERS_BY_GROUP] = build_numbers_by_group

    puts "save BUILD_NUMBERS_BY_GROUP: #{build_numbers_by_group}"
  end  
  
  # load Build DEFAULT_Debug: 38
  # load Build DEFAULT_Release: 39
  desc "Get build number per group"
  lane :lane_get_multi_increment_build_number do
    lane_context[:BUILD_NUMBERS_BY_GROUP].each do |key, number|
      puts "load Build #{key}: #{number}"
    end  
  end
  # END ===============================================================


  # START =============================================================
  desc "Get Latest Build Number From Testflight and Increament It"
  lane :increment_build_number_from_latest_testflight_auto do    
    lane_get_version_number_from_xcode
    lane_latest_testflight_build_number
    lane_increment_build_number
  end

  desc "Get Latest Build Number From Testflight and Increament It"
  lane :multi_increment_build_number_from_latest_testflight_auto do    
    lane_get_version_number_from_xcode
    lane_latest_testflight_build_number
    lane_multi_increment_build_number
  end
  # END ===============================================================





  # START =============================================================
  # END ===============================================================

  # SharedValues::BUILD_NUMBER	The build number
  desc "lane_get_build_number"
  lane :lane_get_build_number do
    get_build_number(xcodeproj: XCODEPROJ_APP)    
  end

  desc "lane_setup_app_version"
  lane :lane_setup_app_version do

    increment_version_number(
      version_number: GITHUB_VERSION_NUMBER
    )

    increment_build_number(
      build_number: GITHUB_BUILD_NUMBER,
    )
    
  end

  desc "Setup Manual Build Number"
  lane :increment_build_number_from_latest_testflight_manual do

    lane_setup_app_version
  end

end

