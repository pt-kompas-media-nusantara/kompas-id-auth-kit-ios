default_platform(:ios)

platform :ios do
  
  # Create Git Tag & GitHub Release
  desc "bundle exec fastlane exec_create_tag_release"
  lane :exec_create_tag_release do |options|

    configuration_name = lane_context[:CONFIGURATION_NAME]
    
    ensure_git_status_clean(show_diff: true)

    current_version = get_version_number(
      xcodeproj: XCODEPROJ_APP,
      target: TARGET_BY,
      configuration: configuration_name
    )
    
    version_number = options[:version] || current_version
    
    tag_name = "v#{version_number}"
    puts "tag_name: #{tag_name}"

    # Cek apakah tag sudah ada (mencegah error duplicate)
    if git_tag_exists(tag: tag_name)
      UI.error("Tag #{tag_name} sudah ada di git! Cabut bro, ganti versi dulu.")
      next
    end

    # # Bikin Git Tag Lokal
    # add_git_tag(
    #   tag: tag_name,
    #   message: "v#{tag_name}"
    # )

    # # 5. Push Tag ke GitHub
    # push_to_git_remote(
    #   tags: true,
    #   remote: "origin" # Pastikan remote name lu 'origin' (standar)
    # )

    # # 6. (Opsional & Keren) Bikin Release Note di Halaman GitHub
    # set_github_release(
    #   repository_name: "pt-kompas-media-nusantara/kompas-id-auth-kit-ios",
    #   api_token: GITHUB_API_TOKEN,
    #   name: "Release #{tag_name}",
    #   tag_name: tag_name,
    #   description: "Rilis versi #{tag_name} dari Fastlane 🚀", # Bisa diganti changelog otomatis
    #   is_draft: false,
    #   is_prerelease: false
    # )
    
    # UI.success("✅ Berhasil rilis #{tag_name} ke GitHub!")
  end
end