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

            DispatchQueue.main.async {
                UIApplication.keyWindow?.overrideUserInterfaceStyle = self.isAppearanceAutomatically ? .unspecified : self.appearance
            }
        }
    }

    var appearance: UIUserInterfaceStyle = UserDefaults.standard.string(forKey: Keys.appearance)
        .flatMap { UIUserInterfaceStyle(rawValue: Int($0) ?? 0) } ?? UIUserInterfaceStyle.unspecified {
            didSet {
                UserDefaults.standard.set(self.appearance.rawValue, forKey: Keys.appearance)
                DispatchQueue.main.async {
                    UIApplication.keyWindow?.overrideUserInterfaceStyle = self.appearance
                }
            }
        }
}

extension SettingsStore {
    func setAppearance(state: UIUserInterfaceStyle) {
        self.appearance = state

        UIApplication.keyWindow?.overrideUserInterfaceStyle = state
    }
}
