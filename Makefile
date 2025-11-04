# ===================================================================
# Perintah Utama: Menginisialisasi seluruh proyek
#
# Cukup jalankan: make init_project
# ===================================================================
.PHONY: init_project
init_project: xcodegen_generate resolve_spm install_pods
	@echo "✅ Selesai! Membuka KompasIdAuth.xcworkspace..."
	@open KompasIdAuth.xcworkspace

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
	# Sekarang xcodebuild akan menemukan .xcodeproj yang baru dibuat
	@xcodebuild -resolvePackageDependencies -quiet

# ===================================================================
# LANGKAH 3: Mengunduh dependencies CocoaPods
# (Hapus target ini jika Anda TIDAK pakai CocoaPods)
# ===================================================================
.PHONY: install_pods
install_pods:
	@echo "➡️  3/3: Menginstall dependencies CocoaPods..."
	@bundle install
	@bundle exec pod install --verbose

# ===================================================================
# Perintah Tambahan
# ===================================================================
.PHONY: clean
clean:
	@echo "🧹 Membersihkan file cache dan proyek lama..."
	@xcodegen clean
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@echo "✅ Bersih."