import UIKit

class SettingsAuthenticationTableViewCell: UITableViewCell {
    private let titleText: UILabel = {
        let view: UILabel = UILabel()

        view.numberOfLines = 1
        view.text = "settings.section.header.sign.in".localized()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 2, weight: .bold)
        view.textColor = .systemPink

        return view
    }()

    private let subTitleText: UILabel = {
        let view: UILabel = UILabel()

        view.numberOfLines = 1
        view.text = "settings.section.header.sign.in.description".localized()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.font = UIFont.preferredFont(forTextStyle: .caption1).withSize(UIFont.systemFontSize)
        view.textColor = .systemGray


        return view
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(self.titleText)
        self.addSubview(self.subTitleText)

        NSLayoutConstraint.activate([
            self.titleText.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),

            self.subTitleText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.subTitleText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.subTitleText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}