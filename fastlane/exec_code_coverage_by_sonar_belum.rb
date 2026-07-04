

default_platform(:ios)

platform :ios do


  # desc "bundle exec fastlane exec_code_coverage_slather_by_local"
  # lane :exec_code_coverage_slather_by_local do

  #   # exec_unit_tests_by_local

  #   slather(    
  #     # github: true, # -> output not generated
  #     # llvm_cov: true, # -> output not generated
  #     # sonarqube_xml: true, # -> output not generated
  #     # cobertura_xml: true,
  #     # json: true, # -> output not generated
  #     # html: true, # -> output not generated
  #     # show: true, # -> output not generated and not automaticly show
  #     # verbose: true, # -> output not generated
  #     simple_output: true,
  #     use_bundle_exec: true,
  #     source_directory: "Kompas.id",
  #     workspace: WORKSPACE_APP,
  #     scheme: DEBUG_SCHEME, 
  #     configuration: DEBUG_CONFIGURATION,
  #     build_directory: "./automation/slather/build_directory", 
  #     output_directory: "./automation/slather/output_directory"
  #   )
  # end

end
# simple_output: true,
# proj: XCODEPROJ_APP,
# sepertinya ruby 3.3.0 tidak cocok dengan slather 