import UIKit

extension UIApplication {
    static let keyWindow: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
}