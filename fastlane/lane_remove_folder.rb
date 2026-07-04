default_platform(:ios)

platform :ios do

    lane :remove_automation_folder_by_local do
        folder_path = "../automation"
      
        if Dir.exist?(folder_path)
          FileUtils.rm_rf(folder_path)
          UI.message("Folder '#{folder_path}' has been successfully removed.")
        else
          UI.message("Folder '#{folder_path}' does not exist.")
        end
      end

end