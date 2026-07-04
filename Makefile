# ===================================================================
# 🛠 PROJECT CONFIGURATION & TOOLS
# ===================================================================

# Pastikan path homebrew terbaca (khusus Apple Silicon M1/M2/M3)
export PATH := $(PATH):/opt/homebrew/bin

# ===================================================================
# 🚀 MENU UTAMA (SHORTCUTS)
# ===================================================================

.PHONY: all
all: init

# 1. INIT (Jalanin ini saat pertama kali clone project)
# Urutan: Cek Tools -> Install Ruby Gems -> SwiftGen -> XcodeGen -> SPM -> Pods
.PHONY: init
init: check_tools install_gems generate_resources generate_project resolve_spm install_pods
	@echo "🎉  Setup Selesai! Silakan buka 'XAuth.xcworkspace'"

# 2. UPDATE (Jalanin ini setiap nambah file baru / ganti config)
# Urutan: SwiftGen -> XcodeGen
.PHONY: update
update: check_tools generate_resources generate_project
	@echo "✅  Project berhasil di-refresh!"

# 3. SUPER UPDATE (Kalau habis pull dari git dan ada perubahan library)
# Urutan: Update -> SPM -> Pods Cepat
.PHONY: super_update
super_update: update resolve_spm quick_pods
	@echo "✅  Project & Library berhasil di-update!"

# ===================================================================
# 🔍 QUALITY CONTROL (LINTER & FORMATTER)
# ===================================================================

# Cek kerapian kode (Read-Only)
.PHONY: lint
lint:
	@echo "🔍  Menjalankan SwiftLint..."
	@swiftlint lint --config .swiftlint.yml

# Perbaiki kerapian kode otomatis (Autocorrect)
.PHONY: format
format:
	@echo "🧹  Memperbaiki format kode..."
	@swiftlint --fix --config .swiftlint.yml
	@echo "✨  Kode sudah rapi!"

# ===================================================================
# ⚙️ STEPS DETIL (JANGAN PANGGIL LANGSUNG KECUALI PERLU)
# ===================================================================

# 0. Cek apakah tools sudah terinstall
.PHONY: check_tools
check_tools:
	@command -v swiftgen >/dev/null 2>&1 || { echo "❌ Error: SwiftGen belum terinstall. Jalanin 'brew install swiftgen'"; exit 1; }
	@command -v xcodegen >/dev/null 2>&1 || { echo "❌ Error: XcodeGen belum terinstall. Jalanin 'brew install xcodegen'"; exit 1; }
	@command -v swiftlint >/dev/null 2>&1 || { echo "❌ Error: SwiftLint belum terinstall. Jalanin 'brew install swiftlint'"; exit 1; }
	@echo "✅  Tools siap..."

# 1. Install Ruby Gems (CocoaPods, Bundler)
.PHONY: install_gems
install_gems:
	@echo "💎  Checking Ruby Gems..."
	@bundle check || bundle install

# 2. Generate Resources (Gambar, Warna, String) via SwiftGen
.PHONY: generate_resources
generate_resources:
	@echo "🎨  Generating Resources (SwiftGen)..."
	@swiftgen config run --config swiftgen.yml

# 3. Generate .xcodeproj via XcodeGen
.PHONY: generate_project
generate_project:
	@echo "🛠  Generating Xcode Project (XcodeGen)..."
	@xcodegen -s project.yml

# 4. Resolve SPM (Swift Package Manager)
.PHONY: resolve_spm
resolve_spm:
	@echo "📦  Resolving SPM Dependencies..."
	@xcodebuild -resolvePackageDependencies -workspace XAuth.xcworkspace -scheme "XAuth Production Debug" -quiet || echo "⚠️  SPM Warning (bisa diabaikan jika baru init)"

# 5. Install CocoaPods (Full Update Repo - Lambat tapi Pasti)
.PHONY: install_pods
install_pods:
	@echo "🥥  Installing Pods (Repo Update)..."
	@bundle exec pod install --repo-update

# 6. Quick Pods (Tanpa Update Repo - Cepat)
.PHONY: quick_pods
quick_pods:
	@echo "🥥  Installing Pods (Quick)..."
	@bundle exec pod install

# ===================================================================
# 🗑 CLEAN UP
# ===================================================================

.PHONY: clean
clean:
	@echo "🗑  Membersihkan file project..."
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@rm -f Podfile.lock
	@rm -rf Pods
	@echo "✨  Bersih. clean"

.PHONY: super_clean
super_clean:
	@echo "🗑  Membersihkan file project..."
	@rm -rf *.xcodeproj
	@rm -rf *.xcworkspace
	@rm -f Package.resolved
	@rm -f Podfile.lock
	@rm -rf Pods
	@rm -rf DerivedData
	@echo "✨  Bersih. Silakan jalankan 'make init' ulang."