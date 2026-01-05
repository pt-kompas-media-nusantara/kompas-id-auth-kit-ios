
import SwiftUI


public struct HomeView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
            
            ButtonAuthKit()
            
            ComponentView()
        }
        
    }
}
