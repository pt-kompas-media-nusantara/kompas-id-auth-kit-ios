
import SwiftUI

public struct ButtonAuthKit: View {
    
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
    
    // 1. Initializer-nya WAJIB public
    public init() {}
    
    // 2. Body-nya WAJIB public
    public var body: some View {
        VStack {
            Text("\(environmentName) - \(modeName)")
        }
        .onAppear {
            print("XAuthUIKit \(environmentName) - \(modeName)")
            
#if PRODUCTION_DEBUG
            print("XAuthUIKit PRODUCTION_DEBUG")
#elseif PRODUCTION_RELEASE
            print("#XAuthUIKit elseif PRODUCTION_RELEASE")
#elseif STAGING_DEBUG
            print("XAuthUIKit STAGING_DEBUG")
#elseif STAGING_RELEASE
            print("XAuthUIKit STAGING_RELEASE")
#else
            print("XAuthUIKit UNKNOWN LANGSUNG")
#endif
        }
        
    }
}



