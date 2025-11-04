platform :ios, '16.0'

target 'KompasIdAuth' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KompasIdAuth

end


post_install do |installer|
  
  puts "Menjalankan post_install hook..."

  # 1. Kita cari di dalam proyek 'Pods.xcodeproj'
  installer.pods_project.targets.each do |target|
    
    # LOG TAMBAHAN: Kita cek target mana yang sedang diproses
    puts "\n--- Memeriksa Target: '#{target.name}' ---"

    # --- INI BLOK LOGGING YANG ANDA BUTUHKAN ---
    # Kita cetak SEMUA build phase yang ada di target ini
    # untuk memastikan namanya sudah benar.
    puts "Mencari build phases yang tersedia di target ini:"
    target.build_phases.each do |bp_log|
      puts "  > Ditemukan: '#{bp_log.display_name}'"
    end
    # --- AKHIR BLOK LOGGING ---


    # 2. Kita cari build phase yang spesifik (Kode asli)
    phase = target.build_phases.find { |bp| bp.display_name == '[CP] Check Pods Manifest.lock' }
    
    # Log ini aman, akan mencetak 'nil' (kosong) jika tidak ketemu
    puts "Hasil pencarian 'phase': '#{phase}'"


    if phase
      # Jika 'phase' ditemukan (tidak nil)
      puts "BERHASIL MENEMUKAN: '[CP] Check Pods Manifest.lock'. Mencoba mengganti skrip..."
      
      old_line_pattern = /diff .*Podfile\.lock.*Manifest\.lock.* > \/dev\/null/
      new_script_line = 'diff "${SRCROOT}/Podfile.lock" "${SRCROOT}/Pods/Manifest.lock" > /dev\/null'
      
      # Log Anda sebelumnya (sudah aman di dalam sini)
      puts "Logger old_line_pattern: '#{old_line_pattern}'"
      puts "Logger new_script_line: '#{new_script_line}'"

      # 5. Ganti skripnya
      if phase.shell_script.match(old_line_pattern)
        phase.shell_script.sub!(old_line_pattern, new_script_line)
        puts "BERHASIL: Skrip 'diff' telah diganti."
      else
        puts "PERINGATAN: Pola skrip lama tidak ditemukan. Mungkin sudah terganti?"
      end
    else
      # LOG TAMBAHAN: Jika 'phase' nil (tidak ketemu)
      puts "INFO: Build phase '[CP] Check Pods Manifest.lock' TIDAK DITEMUKAN di target '#{target.name}'."
    end
  end
  puts "\nSelesai post_install hook."
end