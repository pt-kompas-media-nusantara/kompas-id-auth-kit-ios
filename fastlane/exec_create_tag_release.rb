default_platform(:ios)

platform :ios do
  
  # Create Git Tag & GitHub Release
  desc "bundle exec fastlane exec_create_tag_release"
  lane :exec_create_tag_release do 

    tag_name = "v#{lane_get_version_manually_from_xcconfig}"
    puts "tag_name: #{tag_name}"

    # Cek apakah tag sudah ada (mencegah error duplicate)
    if git_tag_exists(tag: tag_name)
      UI.error("Tag #{tag_name} sudah ada di git! Cabut bro, ganti versi dulu.")
      next
    end

    # Bikin Git Tag Lokal
    add_git_tag(
      tag: tag_name,
      message: "v#{tag_name}"
    )

    # 5. Push Tag ke GitHub
    push_to_git_remote(
      tags: true,
      remote: "origin" # Pastikan remote name lu 'origin' (standar)
    )

    changelog = changelog_from_git_commits(
      commits_count: 10, # Atau merge_commit_filtering: "exclude_merges"
      pretty: "- %s"
    )

    # 6. (Opsional & Keren) Bikin Release Note di Halaman GitHub
    set_github_release(
      repository_name: "pt-kompas-media-nusantara/kompas-id-auth-kit-ios",
      api_token: GITHUB_API_TOKEN,
      name: "Release #{tag_name}",
      tag_name: tag_name,
      description: "Changes:\n#{changelog}",
      is_draft: false,
      is_prerelease: false
    )
    
    UI.success("✅ Berhasil rilis #{tag_name} ke GitHub!")
  end


end
