# ===================================================================
# 🆔 KOMPAS ID AUTH KIT - IOS MAKEFILE
# ===================================================================
# Dokumen ini berfungsi sebagai pusat otomatisasi tugas-tugas development
# untuk proyek XAuth (Kompas ID Auth Kit).
#
# Cara Penggunaan Utama:
#   - `make` atau `make init`       : Jalankan saat pertama kali clone proyek.
#   - `make update`                 : Jalankan jika ada penambahan aset baru/perubahan config.
#   - `make super_update`           : Jalankan setelah pull dari Git untuk sinkronisasi library.
#   - `make help`                   : Menampilkan menu panduan perintah ini.
# ===================================================================

# 🎨 Output Terminal Styling (ANSI Colors)
RED    := \033[1;31m
GREEN  := \033[1;32m
YELLOW := \033[1;33m
CYAN   := \033[1;36m
RESET  := \033[0m

# Pastikan path homebrew terbaca di macOS Apple Silicon (M1/M2/M3)
export PATH := $(PATH):/opt/homebrew/bin

# Mencari iPhone simulator pertama yang tersedia secara dinamis untuk pengujian
LPAREN := (
RPAREN := )
TEST_DEVICE    ?= $(shell xcrun simctl list devices | grep -E "iPhone" | grep -v "unavailable" | head -n 1 | sed -E 's/^[[:space:]]*//' | cut -d'$(LPAREN)' -f1 | sed -E 's/[[:space:]]*$$//')
TEST_DEVICE_ID ?= $(shell xcrun simctl list devices | grep -E "iPhone" | grep -v "unavailable" | head -n 1 | cut -d'$(LPAREN)' -f2 | cut -d'$(RPAREN)' -f1)

.DEFAULT_GOAL := help

# ===================================================================
# 🚀 MENU UTAMA (SHORTCUTS)
# ===================================================================

.PHONY: all
all: init

.PHONY: help
help: ## Menampilkan panduan penggunaan perintah Makefile ini
	@echo ""
	@echo "$(CYAN)🆔 Kompas ID Auth Kit - iOS Automation Console$(RESET)"
	@echo "=========================================================="
	@echo "$(YELLOW)Cara Penggunaan:$(RESET)"
	@echo "  make <target>"
	@echo ""
	@echo "$(YELLOW)Daftar Perintah yang Tersedia:$(RESET)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-18s$(RESET) %s\n", $$1, $$2}'
	@echo "=========================================================="
	@echo ""

.PHONY: init
init: ## Setup awal proyek (Check tools -> Gems -> SwiftGen -> XcodeGen -> SPM -> Pods)
	@echo "$(CYAN)🚀 Memulai proses inisialisasi proyek...$(RESET)"
	@$(MAKE) check_tools
	@$(MAKE) install_gems
	@$(MAKE) generate_resources
	@$(MAKE) generate_project
	@$(MAKE) resolve_spm
	@$(MAKE) install_pods
	@echo "$(GREEN)🎉 Setup Selesai! Silakan buka 'XAuth.xcworkspace'$(RESET)"

.PHONY: update
update: ## Refresh proyek (Gunakan setiap menambah file baru, aset, atau mengubah config)
	@echo "$(CYAN)⚙️ Merefresh konfigurasi proyek...$(RESET)"
	@$(MAKE) check_tools
	@$(MAKE) generate_resources
	@$(MAKE) generate_project
	@echo "$(GREEN)✅ Project berhasil di-refresh!$(RESET)"

.PHONY: super_update
super_update: ## Sinkronisasi penuh (Update project -> Update SPM -> Update CocoaPods Cepat)
	@echo "$(CYAN)🔄 Menjalankan super update...$(RESET)"
	@$(MAKE) update
	@$(MAKE) resolve_spm
	@$(MAKE) quick_pods
	@echo "$(GREEN)✅ Project & Library berhasil disinkronisasi penuh!$(RESET)"

.PHONY: open
open: ## Membuka berkas XAuth.xcworkspace langsung ke Xcode
	@echo "$(CYAN)📂 Membuka XAuth.xcworkspace di Xcode...$(RESET)"
	@open XAuth.xcworkspace

.PHONY: build
build: ## Mengompilasi (build) proyek menggunakan scheme XAuth Production Debug
	@echo "$(CYAN)🏗 Mengompilasi proyek XAuth Production Debug...$(RESET)"
	@xcodebuild build -workspace XAuth.xcworkspace -scheme "XAuth Production Debug" -destination "generic/platform=iOS Simulator" -quiet || { echo "$(RED)❌ Build Gagal!$(RESET)"; exit 1; }
	@echo "$(GREEN)✅ Build Berhasil!$(RESET)"

# ===================================================================
# 🔍 QUALITY CONTROL (LINTER & FORMATTER)
# ===================================================================

.PHONY: lint
lint: ## Memeriksa kerapian kode Swift menggunakan SwiftLint (Read-Only)
	@echo "$(CYAN)🔍 Menjalankan SwiftLint...$(RESET)"
	@swiftlint lint --config .swiftlint.yml

.PHONY: format
format: ## Merapikan format kode Swift secara otomatis (Autocorrect)
	@echo "$(CYAN)🧹 Memperbaiki format kode otomatis...$(RESET)"
	@swiftlint --fix --config .swiftlint.yml
	@echo "$(GREEN)✨ Kode sudah rapi sesuai dengan style guide!$(RESET)"

.PHONY: test
test: ## Menjalankan unit tests menggunakan scheme XAuthKit_Tests (Device: $(TEST_DEVICE))
	@echo "$(CYAN)🧪 Menjalankan Unit Tests di simulator '$(TEST_DEVICE)' (ID: $(TEST_DEVICE_ID))...$(RESET)"
	@xcodebuild test -workspace XAuth.xcworkspace -scheme "XAuthKit_Tests" -destination "platform=iOS Simulator,id=$(TEST_DEVICE_ID)" -quiet || { echo "$(RED)❌ Unit Tests Gagal!$(RESET)"; exit 1; }
	@echo "$(GREEN)✅ Semua Unit Tests Lulus!$(RESET)"

# ===================================================================
# ⚙️ DETIL PERINTAH TEKNIS (LANGKAH INDIVIDUAL)
# ===================================================================

.PHONY: check_tools
check_tools: ## Memeriksa kelengkapan perkakas pendukung (SwiftGen, XcodeGen, SwiftLint)
	@echo "$(CYAN)🔍 Memeriksa dependensi system...$(RESET)"
	@command -v swiftgen >/dev/null 2>&1 || { echo "$(RED)❌ Error: SwiftGen belum terinstall. Jalankan 'brew install swiftgen'$(RESET)"; exit 1; }
	@command -v xcodegen >/dev/null 2>&1 || { echo "$(RED)❌ Error: XcodeGen belum terinstall. Jalankan 'brew install xcodegen'$(RESET)"; exit 1; }
	@command -v swiftlint >/dev/null 2>&1 || { echo "$(RED)❌ Error: SwiftLint belum terinstall. Jalankan 'brew install swiftlint'$(RESET)"; exit 1; }
	@command -v bundle >/dev/null 2>&1 || { echo "$(RED)❌ Error: Bundler belum terinstall. Jalankan 'gem install bundler'$(RESET)"; exit 1; }
	@echo "$(GREEN)✅ Semua perkakas system terpasang dan siap digunakan!$(RESET)"

.PHONY: install_gems
install_gems: ## Memeriksa dan memasang dependency Ruby Gems (CocoaPods, Fastlane)
	@echo "$(CYAN)💎 Memeriksa Ruby Gems...$(RESET)"
	@bundle check || bundle install

.PHONY: generate_resources
generate_resources: ## Membuat berkas resources otomatis (Gambar, Warna, String) via SwiftGen
	@echo "$(CYAN)🎨 Membuat kode resources otomatis (SwiftGen)...$(RESET)"
	@swiftgen config run --config swiftgen.yml

.PHONY: generate_project
generate_project: ## Membuat ulang proyek Xcode (.xcodeproj) berdasarkan project.yml via XcodeGen
	@echo "$(CYAN)🛠 Membuat ulang berkas Xcode Project (XcodeGen)...$(RESET)"
	@xcodegen -s project.yml

.PHONY: resolve_spm
resolve_spm: ## Mengunduh dan menyinkronkan seluruh dependensi Swift Package Manager
	@echo "$(CYAN)📦 Menyinkronkan dependensi Swift Package Manager...$(RESET)"
	@xcodebuild -resolvePackageDependencies -workspace XAuth.xcworkspace -scheme "XAuth Production Debug" -quiet || echo "$(YELLOW)⚠️ SPM Warning (bisa diabaikan jika baru pertama kali init)$(RESET)"

.PHONY: info
info: ## Menampilkan informasi versi SDK, macOS, Xcode, Swift, Ruby, Cocoapods dll.
	@echo ""
	@echo "$(CYAN)ℹ️ System Information:$(RESET)"
	@echo "--------------------------------------------------"
	@echo "macOS:      $$(sw_vers -productVersion)"
	@echo "Xcode:      $$(xcodebuild -version | tr '\n' ' ')"
	@echo "Swift:      $$(swift --version | head -n 1)"
	@echo "Ruby:       $$(ruby -v | head -n 1)"
	@echo "Bundler:    $$(bundle -v)"
	@echo "CocoaPods:  $$(bundle exec pod --version)"
	@echo "XcodeGen:   $$(xcodegen --version)"
	@echo "SwiftGen:   $$(swiftgen --version)"
	@echo "--------------------------------------------------"
	@echo ""

.PHONY: install_pods
install_pods: ## Menginstal CocoaPods dengan memperbarui repositori pod (Lebih lambat)
	@echo "$(CYAN)🥥 Menginstal CocoaPods (Repo Update)...$(RESET)"
	@bundle exec pod install --repo-update

.PHONY: quick_pods
quick_pods: ## Menginstal CocoaPods tanpa memperbarui repositori pod (Lebih cepat)
	@echo "$(CYAN)🥥 Menginstal CocoaPods secara cepat...$(RESET)"
	@bundle exec pod install

# ===================================================================
# 🗑 CLEAN UP
# ===================================================================

.PHONY: clean
clean: ## Menghapus proyek Xcode, workspace, dan folder Pods untuk reset ringan
	@echo "$(CYAN)🗑 Membersihkan berkas proyek Xcode dan CocoaPods...$(RESET)"
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@rm -f Podfile.lock
	@rm -rf Pods
	@echo "$(GREEN)✨ Bersih! Silakan jalankan 'make init' kembali.$(RESET)"

.PHONY: super_clean
super_clean: ## Menghapus total proyek Xcode, CocoaPods, dan DerivedData cache
	@echo "$(CYAN)🗑 Melakukan deep cleaning proyek (termasuk DerivedData)...$(RESET)"
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@rm -f Podfile.lock
	@rm -rf Pods
	@rm -rf DerivedData
	@echo "$(GREEN)✨ Bersih total! Silakan jalankan 'make init' kembali.$(RESET)"