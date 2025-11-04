# ===================================================================
# Perintah Utama: Menginisialisasi seluruh proyek
#
# Cukup jalankan: make init_project
# ===================================================================
.PHONY: init_project
# URUTAN DIPERBAIKI: xcodegen DULU, lalu pods (buat workspace), lalu spm
init_project: xcodegen_generate install_pods
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
# LANGKAH 2: Menginstall CocoaPods (Membuat .xcworkspace)
# ===================================================================
.PHONY: install_pods
install_pods:
	@echo "➡️  2/3: Menginstall dependencies CocoaPods..."
	@bundle install
	@bundle exec pod install --verbose --repo-update

# ===================================================================
# Perintah Tambahan (TARGET CLEAN DIPERBARUI)
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