platform :ios do
    desc "bundle exec fastlane exec_upload_code_coverage_to_sonar"
    lane :exec_upload_code_coverage_to_sonar do
      # Run Unit tests
      exec_unit_tests
  
      # Set paths
      xcresult_path_by_lane_context = lane_context[SharedValues::SCAN_GENERATED_XCRESULT_PATH]
      xcresult_path = File.absolute_path(xcresult_path_by_lane_context)
  
      # Generate Slather coverage report
      exec_code_coverage_by_slather
  
      # Sonar Scanner
      exec_sonar_scanner
    end
  end