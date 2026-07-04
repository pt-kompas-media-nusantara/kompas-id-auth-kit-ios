default_platform(:ios)

platform :ios do

  # reference :
  # - https://github.com/SlatherOrg/slather
  # output : 
  # - Outputs/XCov
  # - Outputs/XCov/xccovarchive-0.xccovarchive
  # - Outputs/XCov/index.html
  # - Outputs/XCov/report.json
  # - Outputs/XCov/report.md
  # catatan :
  # - jangan di kotak katik karna nanti akan gagal
  # - urutan parameter mempengaruhi berhasil atau gagalnya di fungsi tersebut
  # - penambahan atau pengurangan parameter mempengaruhi berhasil atau gagalnya di fungsi tersebut
  # - tidak bisa generate multiple output, seperti : true pada sonarqube_xml, llvm_cov, sonarqube_xml, dll. 
  # - jika semua true makan hanya 1 yang generate output dan itu random. jadi harus panggil fungsi nya berkali kali
  desc "bundle exec fastlane exec_code_coverage_slather_by_all_runner"
  lane :exec_code_coverage_slather_by_all_runner do

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    slather(
        binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
        build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
        output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
        scheme: RELEASE_SCHEME,
        configuration: DEBUG_CONFIGURATION,
        proj: XCODEPROJ_APP,
        workspace: WORKSPACE_APP,
        simple_output: true,
        verbose: true
    )

    slather(
      binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
      build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      proj: XCODEPROJ_APP,
      workspace: WORKSPACE_APP,
      gutter_json: true,
      verbose: true
    )

    slather(
      binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
      build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      proj: XCODEPROJ_APP,
      workspace: WORKSPACE_APP,
      cobertura_xml: true,
      verbose: true
   )

    slather(
      binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
      build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      proj: XCODEPROJ_APP,
      workspace: WORKSPACE_APP,
      sonarqube_xml: true,
      verbose: true
    )

    slather(
      binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
      build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      proj: XCODEPROJ_APP,
      workspace: WORKSPACE_APP,
      llvm_cov: true,
      verbose: true
    )

    slather(
      binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
      build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      proj: XCODEPROJ_APP,
      workspace: WORKSPACE_APP,
      json: true,
      verbose: true
    )

    slather(
      binary_file: "automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path/Build/Products/Debug-iphonesimulator/dev.app/dev",
      build_directory: "./automation/scan/#{context_version_number}_#{context_build_number}/derived_data_path", 
      output_directory: "./automation/slather/#{context_version_number}_#{context_build_number}/output_directory",
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      proj: XCODEPROJ_APP,
      workspace: WORKSPACE_APP,
      html: true,
      verbose: true
    )
  end

end