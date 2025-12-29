# ===================================================================
# MODE CEPAT: Update Project (Tanpa Download Ulang)
# Gunakan ini kalau cuma nambah file Swift atau ubah setting Project.yml
# ===================================================================
.PHONY: update
update:
	@echo "⚡️ Mode Cepat: Regenerate Project Only..."
	@xcodegen -s project.yml
	@echo "✅ Project file (.xcodeproj) berhasil diperbarui!"


# ===================================================================
# MODE SEDANG
# ===================================================================
.PHONY: super_update
super_update: xcodegen_generate resolve_spm quick_pods
	@echo "✅ Selesai! Proyek Anda siap."
	@echo "   Buka file 'XAuth.xcworkspace'"

# ===================================================================
# Perintah Utama: Menginisialisasi seluruh proyek
#
# Cukup jalankan: make init_project
# ===================================================================
.PHONY: init_project
# URUTAN: xcodegen -> spm -> pods
init_project: xcodegen_generate resolve_spm install_pods
	@echo "✅ Selesai! Proyek Anda siap."
	@echo "   Buka file 'XAuth.xcworkspace'"

# ===================================================================
# LANGKAH 1: Membuat file .xcodeproj
# ===================================================================
.PHONY: xcodegen_generate
xcodegen_generate:
	@echo "➡️  1/3: Membuat project dengan XcodeGen..."
	# REVISI: Menghapus '--quiet' agar log XcodeGen terlihat
	xcodegen -s project.yml

# ===================================================================
# LANGKAH 2: Mengunduh paket Swift Package Manager (SPM)
# ===================================================================
.PHONY: resolve_spm
resolve_spm:
	@echo "➡️  2/3: Mengunduh dependencies SPM (Firebase, SwiftLint)..."
	@echo "    (Proses ini mungkin lama saat pertama kali karena download repo SwiftLint)"
	# REVISI: 
	# 1. Menghapus '@' di depan perintah agar command aslinya terlihat
	# 2. Mengganti '-quiet' menjadi '-verbose' agar kelihatan progress download-nya
	xcodebuild -project XAuth.xcodeproj -scheme "XAuth Staging Debug" -resolvePackageDependencies -verbose

# ===================================================================
# LANGKAH 3: Menginstall CocoaPods
# ===================================================================
.PHONY: install_pods
install_pods:
	@echo "➡️  3/3: Menginstall dependencies CocoaPods..."
	@bundle install
	# Bagian ini sudah oke pakai --verbose
	@bundle exec pod install --verbose --repo-update


# ===================================================================
# Flag --repo-update itu memaksa CocoaPods mengecek server pusat (master specs) setiap kali jalan. Itu bisa makan waktu 1-5 menit sendiri.
# ===================================================================
.PHONY: quick_pods
quick_pods:
	@echo "➡️  Update Pods (Tanpa update repo)..."
	@bundle install
	@bundle exec pod install	



# ===================================================================
# Perintah Tambahan
# ===================================================================
.PHONY: clean
clean:
	@echo "🧹 Membersihkan file cache dan proyek lama..."
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@rm -f Podfile.lock
	@rm -rf Pods
	@echo "✅ Bersih."

.PHONY: super_clean
super_clean:
	@echo "🧹 Membersihkan file cache dan proyek lama..."
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@rm -f Podfile.lock
	@rm -rf Pods
	@rm -rf ~/Library/Developer/Xcode/DerivedData/*
	@echo "✅ Bersih."