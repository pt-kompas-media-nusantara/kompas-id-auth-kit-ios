default_platform(:ios)

platform :ios do
  desc "lane_add_notes"
  lane :lane_add_notes do
    note = ""

    if GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      note = UI.input("Note : ")
    else
      note = GITHUB_NOTE
    end
    
    lane_context[:NOTES] = "Note: #{note}"

    puts "save NOTES: #{note}"
  end

  desc "lane_get_notes"
  lane :lane_get_notes do
    notes = lane_context[:NOTES]
    
    puts "load NOTES: #{notes}"

    if !GITHUB_DEPLOYMENT_TYPE.to_s.strip.empty?
      sh("echo FASTLANE_NOTES=#{notes} >> $GITHUB_ENV")
    end
  end
end