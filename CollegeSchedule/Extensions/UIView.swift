import UIKit

extension UIView {
    func pin(to superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
    static func initView<T: UIView>(of type: T.Type = T.self, handler: (T) -> Void) -> T {
        let view = T()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        handler(view)
        
        return view
    }
}
