
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
        Button {
            print("")
        } label: {
            VStack {
                Text("\(environmentName) - \(modeName)")
                
#if PRODUCTION_DEBUG
                Text("PRODUCTION_DEBUG")
#elseif PRODUCTION_RELEASE
                Text("#elseif PRODUCTION_RELEASE")
#elseif STAGING_DEBUG
                Text("STAGING_DEBUG")
#elseif STAGING_RELEASE
                Text("STAGING_RELEASE")
#else
                Text("UNKNOWN LANGSUNG")
#endif
            }
        }
        
    }
}



