import UIKit

extension UICollectionView {
    static func initView(layout: UICollectionViewLayout, handler: (UICollectionView) -> Void) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        handler(view)
        
        return view
    }
}
