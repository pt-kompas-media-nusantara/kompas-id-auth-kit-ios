import SwiftUI

public struct ComponentView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            // Cara 1: Langsung return Image SwiftUI (Paling enak)
            AuthAssets.ttsComingSoon.swiftUIImage
                .resizable()
                .frame(width: 100, height: 100)
            
            // Cara 2: Pakai init custom (generated)
            Image(asset: AuthAssets.ttsComingSoon)
        }
    }
}


