default_platform(:ios)

platform :ios do

  desc "bundle exec fastlane exec_sonar_scanner"
  lane :exec_sonar_scanner do

    # Run Sonar Scanner
    sonar(
        project_key: "pt-kompas-media-nusantara_kompas-id-ios_9ef75303-7352-4e20-a67b-b95a9777b1e3",
        project_version: "1.0",
        project_name: "kompas-id-ios",
        sources_path: File.expand_path("../Kompas.id")
    )
  end
end