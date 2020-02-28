import UIKit

class SettingsAuthenticationFieldUITableViewCell: UITableViewCell {
    private var textField: UITextField? = nil

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, textField: UITextField?, title: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.text = title
        self.textField = textField

        if let textField = self.textField {
            self.contentView.addSubview(textField)

            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(lessThanOrEqualTo: self.contentView.topAnchor),
                textField.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor),
                textField.leadingAnchor.constraint(equalTo: self.textLabel!.trailingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                textField.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
            ])
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.textLabel?.frame.size.width = 90
    }
}
