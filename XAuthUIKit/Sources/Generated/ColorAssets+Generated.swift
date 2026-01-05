// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum AuthColors {
  internal enum Black {
    internal static let blackBlue70 = ColorAsset(name: "Black_Blue70")
    internal static let blackDarkGrey60 = ColorAsset(name: "Black_DarkGrey60")
    internal static let blackText87 = ColorAsset(name: "Black_Text87")
  }
  internal enum Blue {
    internal static let blue10Opacity40Surface06 = ColorAsset(name: "Blue10Opacity40_Surface06")
    internal static let blue10Blue10 = ColorAsset(name: "Blue10_Blue10")
    internal static let blue10Blue20 = ColorAsset(name: "Blue10_Blue20")
    internal static let blue10Blue30 = ColorAsset(name: "Blue10_Blue30")
    internal static let blue10Blue60 = ColorAsset(name: "Blue10_Blue60")
    internal static let blue10Blue70 = ColorAsset(name: "Blue10_Blue70")
    internal static let blue10DarkGrey38 = ColorAsset(name: "Blue10_DarkGrey38")
    internal static let blue10DarkGrey60 = ColorAsset(name: "Blue10_DarkGrey60")
    internal static let blue10Surface06 = ColorAsset(name: "Blue10_Surface06")
    internal static let blue10Surface12 = ColorAsset(name: "Blue10_Surface12")
    internal static let blue10Surface16 = ColorAsset(name: "Blue10_Surface16")
    internal static let blue10Surface24 = ColorAsset(name: "Blue10_Surface24")
    internal static let blue10YaleBlue = ColorAsset(name: "Blue10_YaleBlue")
    internal static let blue20Blue70 = ColorAsset(name: "Blue20_Blue70")
    internal static let blue40Blue40 = ColorAsset(name: "Blue40_Blue40")
    internal static let blue50Blue50 = ColorAsset(name: "Blue50_Blue50")
    internal static let blue50Blue70 = ColorAsset(name: "Blue50_Blue70")
    internal static let blue60Blue20 = ColorAsset(name: "Blue60_Blue20")
    internal static let blue60Blue60 = ColorAsset(name: "Blue60_Blue60")
    internal static let blue60LightGrey60 = ColorAsset(name: "Blue60_LightGrey60")
    internal static let blue60Royal70 = ColorAsset(name: "Blue60_Royal70")
    internal static let blue60Surface00 = ColorAsset(name: "Blue60_Surface00")
    internal static let blue60Surface06 = ColorAsset(name: "Blue60_Surface06")
    internal static let royal60Blue30 = ColorAsset(name: "Royal60_Blue30")
    internal static let royal60Blue60 = ColorAsset(name: "Royal60_Blue60")
    internal static let royalBlue60RoyalBlue60 = ColorAsset(name: "RoyalBlue60_RoyalBlue60")
  }
  internal enum Brown {
    internal static let brown10Brown10 = ColorAsset(name: "Brown10_Brown10")
  }
  internal enum DarkGrey {
    internal static let darkGrey10Surface04 = ColorAsset(name: "DarkGrey10_Surface04")
  }
  internal enum Green {
    internal static let green10CalPolyGreen = ColorAsset(name: "Green10_CalPolyGreen")
    internal static let green10Green10 = ColorAsset(name: "Green10_Green10")
    internal static let green10Green20 = ColorAsset(name: "Green10_Green20")
    internal static let green50Green30 = ColorAsset(name: "Green50_Green30")
    internal static let green50Green60 = ColorAsset(name: "Green50_Green60")
    internal static let green60CalPolyGreen = ColorAsset(name: "Green60_CalPolyGreen")
    internal static let green60Green20 = ColorAsset(name: "Green60_Green20")
    internal static let green60Green60 = ColorAsset(name: "Green60_Green60")
  }
  internal enum LightGrey {
    internal static let lightGrey10DarkGrey60 = ColorAsset(name: "LightGrey10_DarkGrey60")
    internal static let lightGrey10Surface00 = ColorAsset(name: "LightGrey10_Surface00")
    internal static let lightGrey10Surface02 = ColorAsset(name: "LightGrey10_Surface02")
    internal static let lightGrey10Surface08 = ColorAsset(name: "LightGrey10_Surface08")
    internal static let lightGrey20DarkGrey70 = ColorAsset(name: "LightGrey20_DarkGrey70")
    internal static let lightGrey20LightGrey20 = ColorAsset(name: "LightGrey20_LightGrey20")
    internal static let lightGrey20Surface00 = ColorAsset(name: "LightGrey20_Surface00")
    internal static let lightGrey20Surface02 = ColorAsset(name: "LightGrey20_Surface02")
    internal static let lightGrey20Surface08 = ColorAsset(name: "LightGrey20_Surface08")
    internal static let lightGrey20Surface16 = ColorAsset(name: "LightGrey20_Surface16")
    internal static let lightGrey20Surface24 = ColorAsset(name: "LightGrey20_Surface24")
    internal static let lightGrey30Blue20 = ColorAsset(name: "LightGrey30_Blue20")
    internal static let lightGrey30Clear = ColorAsset(name: "LightGrey30_Clear")
    internal static let lightGrey30DarkGrey12 = ColorAsset(name: "LightGrey30_DarkGrey12")
    internal static let lightGrey30DarkGrey20 = ColorAsset(name: "LightGrey30_DarkGrey20")
    internal static let lightGrey30DarkGrey30 = ColorAsset(name: "LightGrey30_DarkGrey30")
    internal static let lightGrey30DarkGrey40 = ColorAsset(name: "LightGrey30_DarkGrey40")
    internal static let lightGrey30LightGrey30 = ColorAsset(name: "LightGrey30_LightGrey30")
    internal static let lightGrey30Surface01 = ColorAsset(name: "LightGrey30_Surface01")
    internal static let lightGrey30Surface04 = ColorAsset(name: "LightGrey30_Surface04")
    internal static let lightGrey30Surface16 = ColorAsset(name: "LightGrey30_Surface16")
    internal static let lightGrey30Text38 = ColorAsset(name: "LightGrey30_Text38")
    internal static let lightGrey30Text60 = ColorAsset(name: "LightGrey30_Text60")
    internal static let lightGrey30Text87 = ColorAsset(name: "LightGrey30_Text87")
    internal static let lightGrey30White12 = ColorAsset(name: "LightGrey30_White12")
    internal static let lightGrey40DarkGrey20 = ColorAsset(name: "LightGrey40_DarkGrey20")
    internal static let lightGrey40DarkGrey30 = ColorAsset(name: "LightGrey40_DarkGrey30")
    internal static let lightGrey40DarkGrey40 = ColorAsset(name: "LightGrey40_DarkGrey40")
    internal static let lightGrey40LightGrey40 = ColorAsset(name: "LightGrey40_LightGrey40")
    internal static let lightGrey40Surface16 = ColorAsset(name: "LightGrey40_Surface16")
    internal static let lightGrey40Surface30 = ColorAsset(name: "LightGrey40_Surface30")
    internal static let lightGrey40Text60 = ColorAsset(name: "LightGrey40_Text60")
    internal static let lightGrey40Text70 = ColorAsset(name: "LightGrey40_Text70")
    internal static let lightGrey50DarkGrey10 = ColorAsset(name: "LightGrey50_DarkGrey10")
    internal static let lightGrey50DarkGrey20 = ColorAsset(name: "LightGrey50_DarkGrey20")
    internal static let lightGrey50LightGrey50 = ColorAsset(name: "LightGrey50_LightGrey50")
    internal static let lightGrey50Surface06 = ColorAsset(name: "LightGrey50_Surface06")
    internal static let lightGrey50Text50 = ColorAsset(name: "LightGrey50_Text50")
    internal static let lightGrey50Text70 = ColorAsset(name: "LightGrey50_Text70")
    internal static let lightGrey50Text87 = ColorAsset(name: "LightGrey50_Text87")
    internal static let lightGrey50White = ColorAsset(name: "LightGrey50_White")
    internal static let lightGrey60Blue30 = ColorAsset(name: "LightGrey60_Blue30")
    internal static let lightGrey60DarkGrey10 = ColorAsset(name: "LightGrey60_DarkGrey10")
    internal static let lightGrey60DarkGrey20 = ColorAsset(name: "LightGrey60_DarkGrey20")
    internal static let lightGrey60DarkGrey50 = ColorAsset(name: "LightGrey60_DarkGrey50")
    internal static let lightGrey60DarkGrey70 = ColorAsset(name: "LightGrey60_DarkGrey70")
    internal static let lightGrey60LightGrey50 = ColorAsset(name: "LightGrey60_LightGrey50")
    internal static let lightGrey60LightGrey60 = ColorAsset(name: "LightGrey60_LightGrey60")
    internal static let lightGrey60Surface01 = ColorAsset(name: "LightGrey60_Surface01")
    internal static let lightGrey60Text100 = ColorAsset(name: "LightGrey60_Text100")
    internal static let lightGrey60Text70 = ColorAsset(name: "LightGrey60_Text70")
    internal static let lightGrey60Text87 = ColorAsset(name: "LightGrey60_Text87")
    internal static let lightGrey60White = ColorAsset(name: "LightGrey60_White")
  }
  internal enum Orange {
    internal static let orange10Orange10 = ColorAsset(name: "Orange10_Orange10")
    internal static let orange10Orange20 = ColorAsset(name: "Orange10_Orange20")
    internal static let orange40Orange40 = ColorAsset(name: "Orange40_Orange40")
    internal static let orange50Orange50 = ColorAsset(name: "Orange50_Orange50")
    internal static let orange60Orange60 = ColorAsset(name: "Orange60_Orange60")
    internal static let orange60Orange70 = ColorAsset(name: "Orange60_Orange70")
  }
  internal enum Others {
    internal enum AliceBlue {
      internal static let aliceBlueBlue70 = ColorAsset(name: "AliceBlue_Blue70")
      internal static let aliceBlueLightGrey60 = ColorAsset(name: "AliceBlue_LightGrey60")
      internal static let aliceBlueRoyalBlue70 = ColorAsset(name: "AliceBlue_RoyalBlue70")
    }
    internal enum CrayolaBlue {
      internal static let crayolaBlueCrayolaBlue = ColorAsset(name: "CrayolaBlue_CrayolaBlue")
    }
    internal enum FireEngineRed {
      internal static let fireEngineRedRed30 = ColorAsset(name: "FireEngineRed_Red30")
      internal static let fireEngineRedRed40 = ColorAsset(name: "FireEngineRed_Red40")
      internal static let fireEngineRedRed50 = ColorAsset(name: "FireEngineRed_Red50")
    }
    internal enum JonquilYellow {
      internal static let jonquilYellowJonquilYellow = ColorAsset(name: "JonquilYellow_JonquilYellow")
      internal static let jonquilYellowYellow30 = ColorAsset(name: "JonquilYellow_Yellow30")
    }
    internal enum OffRed {
      internal static let offRedRed10 = ColorAsset(name: "OffRed_Red10")
      internal static let offRedRed40 = ColorAsset(name: "OffRed_Red40")
    }
    internal enum Onyx {
      internal static let onyxText87 = ColorAsset(name: "Onyx_Text87")
    }
    internal enum Seasalt {
      internal static let seasaltDarkGrey50 = ColorAsset(name: "Seasalt_DarkGrey50")
      internal static let seasaltDarkGrey60 = ColorAsset(name: "Seasalt_DarkGrey60")
      internal static let seasaltSurface06 = ColorAsset(name: "Seasalt_Surface06")
      internal static let seasaltText87 = ColorAsset(name: "Seasalt_Text87")
    }
    internal enum Silver {
      internal static let silverDarkGrey50 = ColorAsset(name: "Silver_DarkGrey50")
    }
    internal enum TaupeGray {
      internal static let taupeGrayTaupeGray = ColorAsset(name: "TaupeGray_TaupeGray")
    }
  }
  internal enum Red {
    internal static let red10Red10 = ColorAsset(name: "Red10_Red10")
    internal static let red10Red20 = ColorAsset(name: "Red10_Red20")
    internal static let red10Red60 = ColorAsset(name: "Red10_Red60")
    internal static let red20Red20 = ColorAsset(name: "Red20_Red20")
    internal static let red50Red30 = ColorAsset(name: "Red50_Red30")
    internal static let red50Red40 = ColorAsset(name: "Red50_Red40")
    internal static let red50Red50 = ColorAsset(name: "Red50_Red50")
    internal static let red50Red60 = ColorAsset(name: "Red50_Red60")
    internal static let red50Red70 = ColorAsset(name: "Red50_Red70")
    internal static let red60Red60 = ColorAsset(name: "Red60_Red60")
  }
  internal enum Royal {
    internal static let royal60Blue20 = ColorAsset(name: "Royal60_Blue20")
    internal static let royal60Blue50 = ColorAsset(name: "Royal60_Blue50")
    internal static let royal60DarkGrey10 = ColorAsset(name: "Royal60_DarkGrey10")
    internal static let royal60Royal60 = ColorAsset(name: "Royal60_Royal60")
    internal static let royal60Surface04 = ColorAsset(name: "Royal60_Surface04")
    internal static let royal60Text87 = ColorAsset(name: "Royal60_Text87")
    internal static let royal60White = ColorAsset(name: "Royal60_White")
    internal static let royal70Royal70 = ColorAsset(name: "Royal70_Royal70")
    internal static let royal70Surface06 = ColorAsset(name: "Royal70_Surface06")
  }
  internal enum White {
    internal static let whiteBlue30 = ColorAsset(name: "White_Blue30")
    internal static let whiteDarkGrey30 = ColorAsset(name: "White_DarkGrey30")
    internal static let whiteDarkGrey60 = ColorAsset(name: "White_DarkGrey60")
    internal static let whiteDarkGrey70 = ColorAsset(name: "White_DarkGrey70")
    internal static let whiteSurface00 = ColorAsset(name: "White_Surface00")
    internal static let whiteSurface01 = ColorAsset(name: "White_Surface01")
    internal static let whiteSurface02 = ColorAsset(name: "White_Surface02")
    internal static let whiteSurface03 = ColorAsset(name: "White_Surface03")
    internal static let whiteSurface04 = ColorAsset(name: "White_Surface04")
    internal static let whiteSurface05 = ColorAsset(name: "White_Surface05")
    internal static let whiteSurface06 = ColorAsset(name: "White_Surface06")
    internal static let whiteSurface08 = ColorAsset(name: "White_Surface08")
    internal static let whiteSurface12 = ColorAsset(name: "White_Surface12")
    internal static let whiteSurface16 = ColorAsset(name: "White_Surface16")
    internal static let whiteSurface24 = ColorAsset(name: "White_Surface24")
    internal static let whiteSurface30 = ColorAsset(name: "White_Surface30")
    internal static let whiteText87 = ColorAsset(name: "White_Text87")
    internal static let whiteWhite = ColorAsset(name: "White_White")
  }
  internal enum Yellow {
    internal static let yellow20Yellow20 = ColorAsset(name: "Yellow20_Yellow20")
    internal static let yellow40Yellow40 = ColorAsset(name: "Yellow40_Yellow40")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
