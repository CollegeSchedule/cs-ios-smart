import UIKit

extension UIButton {
    static func initView(type: UIButton.ButtonType, handler: (UIButton) -> Void) -> UIButton {
        let view = UIButton(type: type)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        handler(view)
        
        return view
    }
}
