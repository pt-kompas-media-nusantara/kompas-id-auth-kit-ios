default_platform(:ios)

platform :ios do
  # v1.0.2
  # Hapus Tag di Local dan Remote (Manual Shell)
  desc "bundle exec fastlane exec_delete_bad_release"
  lane :exec_delete_bad_release do

    version = UI.input("Tag Version")
    
    unless version
      UI.user_error!("Wajib masukin versi bro! Contoh: fastlane delete_bad_release version:1.0.1")
    end

    tag_to_delete = version
    
    UI.important("⚠️  Warning: Lu akan menghapus tag #{tag_to_delete} di Local & Remote!")
      # Kita pakai 'sh' untuk menjalankan command git biasa
      # Kita pakai begin/rescue biar kalau tagnya gak ada di lokal, fastlane gak crash
      begin
        sh("git tag -d #{tag_to_delete}")
        UI.success("✅ Tag Lokal #{tag_to_delete} terhapus.")
      rescue => ex
        UI.important("⚠️  Tag Lokal #{tag_to_delete} gak ketemu atau udah hapus.")
      end

      # 3. Hapus Tag Remote (GitHub)
      begin
        sh("git push origin --delete #{tag_to_delete}")
        UI.success("✅ Tag Remote #{tag_to_delete} terhapus.")
      rescue => ex
        UI.important("⚠️  Tag Remote #{tag_to_delete} gak ketemu atau udah hapus.")
      end
      
      UI.success("Selesai bersih-bersih! 🗑️")
  end

end