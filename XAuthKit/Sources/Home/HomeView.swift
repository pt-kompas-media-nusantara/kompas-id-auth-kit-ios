
import SwiftUI


public struct HomeView: View {
    
    public init() {}
    
    var environmentName: String {
#if STAGING
        return "STAGING"
#elseif PRODUCTION
        return "PRODUCTION"
#else
        return "UNKNOWN environmentName"
#endif
    }
    
    var modeName: String {
#if DEBUG
        return "DEBUG"
#elseif RELEASE
        return "RELEASE"
#else
        return "UNKNOWN modeName"
#endif
    }
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
            
            ButtonAuthKit()
            
            Image("tts_coming_soon")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
        }
        .onAppear {
            print("XAuthKit \(environmentName) - \(modeName)")
            
#if PRODUCTION_DEBUG
            print("XAuthKit PRODUCTION_DEBUG")
#elseif PRODUCTION_RELEASE
            print("XAuthKit elseif PRODUCTION_RELEASE")
#elseif STAGING_DEBUG
            print("XAuthKit STAGING_DEBUG")
#elseif STAGING_RELEASE
            print("XAuthKit STAGING_RELEASE")
#else
            print("XAuthKit UNKNOWN LANGSUNG")
#endif
        }
        
    }
}
