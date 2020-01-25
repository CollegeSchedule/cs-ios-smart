import UIKit

struct SettingsRow {
    enum Special : Int {
        case appearanceDark
        case appearanceLight
    }

    public let title: String
    public var detail: String? = nil
    public var icon: String? = nil
    public var color: UIColor? = nil
    public var destination: UIViewController? = nil
    public var action: (() -> Void)? = nil
    public var selectable: Bool = false
    public var toggleable: Bool = false
    public var special: Special? = nil
}
