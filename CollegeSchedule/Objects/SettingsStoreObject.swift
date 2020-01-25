import Foundation
import UIKit
import Combine

class SettingsStore: ObservableObject {
    private enum Keys {
        static let appearanceAutomatically = "appearanceAutomatically"
        static let appearance = "appearance"
    }

    static let instance: SettingsStore = SettingsStore()

    init() {
        UserDefaults.standard.register(defaults: [
            Keys.appearanceAutomatically: true,
            Keys.appearance: UIUserInterfaceStyle.unspecified.rawValue
        ])
    }
    
    var isAppearanceAutomatically: Bool = UserDefaults.standard.bool(forKey: Keys.appearanceAutomatically) {
        didSet {
            UserDefaults.standard.set(self.isAppearanceAutomatically, forKey: Keys.appearanceAutomatically)

            DispatchQueue.main.async(execute: {
                if(self.isAppearanceAutomatically) {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
                } else {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = self.appearance
                }
            })
        }
    }

    var appearance: UIUserInterfaceStyle = UserDefaults.standard.string(forKey: Keys.appearance)
        .flatMap { UIUserInterfaceStyle(rawValue: Int($0) ?? 0) } ?? UIUserInterfaceStyle.unspecified {
            didSet {
                UserDefaults.standard.set(self.appearance.rawValue, forKey: Keys.appearance)
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = self.appearance
            }
        }
}

extension SettingsStore {
    func setAppearance(state: UIUserInterfaceStyle) {
        self.appearance = state

        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = state
    }
}
