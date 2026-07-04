default_platform(:ios)

platform :ios do

  desc "Extract coverage for Kompas.id.app"
  lane :exec_extract_coverage_by_all_runner do

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    # Lokasi file report.md
    file_path = "../automation/xcov/#{context_version_number}_#{context_build_number}/markdown_report/output_directory/report.md"
    # file_path = "/Users/kompasdigital/Documents/project/ios/kompas-id-ios/automation/xcov/3.48.0_2/markdown_report/output_directory/report.md"
    
    UI.message("Checking for coverage report at path: #{file_path}")

    # Pastikan file tersebut ada
    unless File.exist?(file_path)
      UI.error("❌ Error: File report.md not found at #{file_path}")
      UI.user_error!("❌ GitHub Action failed because file report.md does not exist. Please check the file path.")
    end

    # Baca isi file dan cari coverage dengan regex
    coverage_line = File.readlines(file_path).find { |line| line.match(/## Current coverage for Kompas\.id\.app is `[0-9]+\.[0-9]+%`/) }
    
    unless coverage_line
      UI.error("❌ Error: Coverage information not found in file: #{file_path}")
      UI.user_error!("❌ GitHub Action failed because coverage information is missing in report.md.")
    end

    # Ekstrak angka coverage menggunakan regex
    coverage = coverage_line.match(/`([0-9]+\.[0-9]+%)`/)[1]

    # Print hasil coverage
    UI.message("Extracted Coverage: #{coverage}")
    send_to_github_coverage(coverage: "Code Coverage saat ini adalah: #{coverage}")
  end

  desc "Extract coverage for Kompas.id.app"
  lane :exec_extract_coverage_by_local do

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    # Lokasi file report.md
    file_path = "../automation/xcov/#{context_version_number}_#{context_build_number}/markdown_report/output_directory/report.md"
    # file_path = "/Users/kompasdigital/Documents/project/ios/kompas-id-ios/automation/xcov/3.48.0_2/markdown_report/output_directory/report.md"
    
    UI.message("Checking for coverage report at path: #{file_path}")
    # Pastikan file tersebut ada
    unless File.exist?(file_path)
      UI.error("❌ Error: File report.md not found at #{file_path}")
    end

    # Baca isi file dan cari coverage dengan regex
    coverage_line = File.readlines(file_path).find { |line| line.match(/## Current coverage for Kompas\.id\.app is `[0-9]+\.[0-9]+%`/) }
    
    unless coverage_line
      UI.error("❌ Error: Coverage information not found in file: #{file_path}")
    end

    # Ekstrak angka coverage menggunakan regex
    coverage = coverage_line.match(/`([0-9]+\.[0-9]+%)`/)[1]

    # Print hasil coverage
    UI.success("✅ Extracted Coverage: #{coverage}")
    # UI.message("Extracted Coverage: #{coverage}")
    
  end
  
end