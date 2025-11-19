
import SwiftUI


public struct HomeView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
            
            ButtonAuthKit()
            
            Image("tts_coming_soon")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
        }
        
    }
}
