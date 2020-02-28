import UIKit

class SettingsAuthenticationTableViewCell: UITableViewCell {
    private let titleText: UILabel = UIView.initView() { view in
        view.numberOfLines = 1
        view.text = "settings.section.header.sign.in".localized()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 2, weight: .bold)
        view.textColor = .systemPink
    }

    private let subTitleText: UILabel = UIView.initView() { view in
        view.numberOfLines = 1
        view.text = "settings.section.header.sign.in.description".localized()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.font = UIFont.preferredFont(forTextStyle: .caption1).withSize(UIFont.systemFontSize)
        view.textColor = .systemGray
    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(self.titleText)
        self.addSubview(self.subTitleText)

        NSLayoutConstraint.activate([
            self.titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            self.subTitleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.subTitleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.subTitleText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
