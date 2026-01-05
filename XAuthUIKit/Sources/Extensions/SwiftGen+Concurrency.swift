import Foundation
import SwiftUI // Atau UIKit, tergantung kebutuhan

// MARK: - Swift 6 Concurrency Fix
// Memberikan label 'Sendable' ke struct hasil generate SwiftGen
// agar tidak error saat dijadikan static property.

extension ColorAsset: @unchecked Sendable {}
extension ImageAsset: @unchecked Sendable {}