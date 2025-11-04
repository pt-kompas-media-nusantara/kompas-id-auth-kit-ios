# ===================================================================
# Perintah Utama: Menginisialisasi seluruh proyek
#
# Cukup jalankan: make init_project
# ===================================================================
.PHONY: init_project
# URUTAN BARU: xcodegen -> spm -> pods (terakhir)
init_project: xcodegen_generate resolve_spm install_pods
	@echo "✅ Selesai! Proyek Anda siap."
	@echo "   Buka file 'KompasIdAuth.xcworkspace'"

# ===================================================================
# LANGKAH 1: Membuat file .xcodeproj (WAJIB PERTAMA)
# ===================================================================
.PHONY: xcodegen_generate
xcodegen_generate:
	@echo "➡️  1/3: Membuat project dengan XcodeGen..."
	@xcodegen -s project.yml --quiet

# ===================================================================
# LANGKAH 2: Mengunduh paket Swift Package Manager (SPM)
# ===================================================================
.PHONY: resolve_spm
resolve_spm:
	@echo "➡️  2/3: Mengunduh dependencies SPM (Firebase, etc.)..."
	# Kita perintahkan xcodebuild untuk bekerja di .xcodeproj
	# (SEBELUM workspace dibuat)
	@xcodebuild -project KompasIdAuth.xcodeproj -scheme "KompasIdAuth Staging" -resolvePackageDependencies -quiet

# ===================================================================
# LANGKAH 3: Menginstall CocoaPods (TERAKHIR)
# ===================================================================
.PHONY: install_pods
install_pods:
	@echo "➡️  3/3: Menginstall dependencies CocoaPods..."
	# Pod install sekarang akan membungkus .xcodeproj yang sudah berisi SPM
	@bundle install
	@bundle exec pod install --verbose --repo-update

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
	@rm -rf ~/Library/Developer/Xcode/DerivedData/*
	@echo "✅ Bersih."