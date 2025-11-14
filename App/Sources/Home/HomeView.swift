
import SwiftUI
// import UICore di comment atau tidak sama saja, saya masih tetap mendapatkan error Cannot find 'ButtonAuthKit' in scope
import UICore

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            
            ButtonAuthKit()
            
            Image("tts_coming_soon")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
        }
        
    }
}
