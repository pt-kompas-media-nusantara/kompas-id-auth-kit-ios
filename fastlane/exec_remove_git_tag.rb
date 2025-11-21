default_platform(:ios)

platform :ios do

  # Hapus Tag di Local dan Remote
  desc "bundle exec fastlane exec_delete_bad_releaseOne"
  lane :exec_delete_bad_releaseOne do

    tag_to_delete = UI.input("Tag Version")
        
    # Konfirmasi dulu biar gak salah hapus
    UI.important("⚠️  Warning: Lu akan menghapus tag #{tag_to_delete} selamanya!")
    if UI.confirm("Yakin mau lanjut hapus #{tag_to_delete}?")
      
      # Action bawaan Fastlane
      remove_git_tag(
        tag: tag_to_delete,
        remove_local: true,
        remove_remote: true
      )
      
      UI.success("Tag #{tag_to_delete} berhasil dimusnahkan! 🗑️")
    else
      UI.message("Oke, batal hapus.")
    end
  end

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