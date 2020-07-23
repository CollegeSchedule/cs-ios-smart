import UIKit

struct SettingsRow {
    enum Special : Int {
        case appearanceDark
        case appearanceLight

        case cellAuthentication
    }

    enum DestinationType : Int {
        case present
        case push
    }

    public var title: String? = nil
    public var detail: String? = nil
    public var icon: String? = nil
    public var color: UIColor? = nil
    public var destination: UIViewController? = nil
    public var destinationAction: (() -> UIViewController)? = nil
    public var destinationType: DestinationType? = nil
    public var action: (() -> Void)? = nil
    public var selectable: Bool = false
    public var toggleable: Bool = false
    public var special: Special? = nil
}
