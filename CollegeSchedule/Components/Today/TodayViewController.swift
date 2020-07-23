import UIKit

final class TodayViewController: UIViewController {
    private let newsView: UITableView = UITableView.initView(style: .plain) { view in
        view.register(TodayCardUITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private let items: [String] = ["Hello", "My", "Name", "Is", "Mark"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(self.newsView)

        self.newsView.dataSource = self
        self.newsView.delegate = self
        self.newsView.rowHeight = 400
        self.newsView.separatorStyle = .none
        self.newsView.allowsSelection = false
    
        self.newsView.pin(to: self.view)
    }

}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodayCardUITableViewCell
            = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                as! TodayCardUITableViewCell
        
        let cardContentVC = CustomViewController()
        
        cardContentVC.view.backgroundColor = UIColor(named: "CardBackgroundColor")
        
//        cell.card.shouldPresent(cardContentVC, from: self, fullscreen: true)
//        cell.card.delegate = self
        
        return cell
    }

}

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
}

//extension TodayViewController: CardDelegate {
//    func cardDidTapInside(card: Card) {
//        self.setTabBarHidden(true, animated: true, duration: 0.1)
//    }
//
//    func cardIsHidingDetail(card: Card) {
//        self.setTabBarHidden(false, animated: true, duration: 0.3)
//    }
//}

extension UIViewController {

func setTabBarHidden(_ hidden: Bool, animated: Bool = true, duration: TimeInterval = 0.5) {
    if self.tabBarController?.tabBar.isHidden != hidden{
        if animated {
            //Show the tabbar before the animation in case it has to appear
            if (self.tabBarController?.tabBar.isHidden)!{
                self.tabBarController?.tabBar.isHidden = hidden
            }
            if let frame = self.tabBarController?.tabBar.frame {
                let factor: CGFloat = hidden ? 1 : -1
                let y = frame.origin.y + (frame.size.height * factor)
                UIView.animate(withDuration: duration, animations: {
                    self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
                }) { (bool) in
                    //hide the tabbar after the animation in case ti has to be hidden
                    if (!(self.tabBarController?.tabBar.isHidden)!){
                        self.tabBarController?.tabBar.isHidden = hidden
                    }
                }
            }
        }
    }
}
}
