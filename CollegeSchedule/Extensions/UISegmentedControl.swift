import Foundation
import UIKit

extension UISegmentedControl {
    static func initView(items: [Any]?, handler: (UISegmentedControl) -> Void) -> UISegmentedControl {
        let view = UISegmentedControl(items: items)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        handler(view)
        
        return view
    }
}
