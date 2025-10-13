
import Foundation
import Firebase

protocol FirebaseConfiguration {
    func configure() async
}

struct FirebaseConfigurationImpl: FirebaseConfiguration {
    
    func configure() async {
        let key = "FIREBASE_SERVICE_PLIST_NAME"
        guard let firebaseName = Bundle.app.object(forInfoDictionaryKey: key) as? String,
              let plistLocation = Bundle.app.path(forResource: firebaseName, ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: plistLocation) else { return }
        
//        TODO: Uncomment if you include a valid Google Plist to configure Firebase
//        FirebaseApp.configure(options: options)
    }
}

extension FirebaseConfigurationImpl {
    static func create() -> FirebaseConfiguration {
        FirebaseConfigurationImpl()
    }
}
