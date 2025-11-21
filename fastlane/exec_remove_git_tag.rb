default_platform(:ios)

platform :ios do

  # Hapus Tag di Local dan Remote
  desc "bundle exec fastlane exec_delete_bad_release"
  lane :exec_delete_bad_release do

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

end