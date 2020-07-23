import UIKit

extension UITableView {
    static func initView(style: UITableView.Style, handler: (UITableView) -> Void) -> UITableView {
        let view = UITableView(frame: .zero, style: style)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        handler(view)
        
        return view
    }
}
