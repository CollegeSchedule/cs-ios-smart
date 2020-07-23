import UIKit
//import Cards

class TodayCardUITableViewCell: UITableViewCell {
//от него так и несет пафосом
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.addSubview(self.card)
//
//        NSLayoutConstraint.activate([
//            self.card.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            self.card.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            self.card.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            self.card.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
//        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
