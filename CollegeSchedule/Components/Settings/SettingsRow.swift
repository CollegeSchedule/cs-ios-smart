import UIKit

struct SettingsRow {
    public let title: String
    public let detail: String?
    public let icon: String?
    public let color: UIColor?
    public let destination: UIViewController?
    public let action: (() -> Void)?
}
