import UIKit

class SettingsAuthenticationViewController: UIViewController {
    private let titleLabel: UILabel = {
        let view: UILabel = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "settings.section.authentication.id".localized()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .largeTitle)

        return view
    }()

    private let subTitleLabel: UILabel = {
        let view: UILabel = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "settings.section.authentication.id.description".localized()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .body)

        return view
    }()

    private let fieldsView: UITableView = {
        let view: UITableView = UITableView(frame: .zero, style: .plain)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = UIView()
        view.isScrollEnabled = false

        return view
    }()

    private let emailField: UITextField = {
        let view: UITextField = UITextField()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "settings.section.authentication.enter.id".localized()
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.keyboardType = .emailAddress
        view.returnKeyType = .continue

        return view
    }()

    private let passwordField: UITextField = {
        let view: UITextField = UITextField()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "settings.section.authentication.enter.password".localized()
        view.isSecureTextEntry = true
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.keyboardType = .default
        view.returnKeyType = .continue

        return view
    }()

    private let registerButton: UIButton = {
        let view: UIButton = UIButton(type: .system)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Register", for: .normal)

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Authentication"
        // todo: not workingg
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.isModalInPresentation = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(done))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.view.backgroundColor = .systemBackground

        self.fieldsView.delegate = self
        self.fieldsView.dataSource = self
        self.fieldsView.register(SettingsAuthenticationFieldUITableViewCell.self, forCellReuseIdentifier: "field")

        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subTitleLabel)
        self.view.addSubview(self.fieldsView)
//        // todo: move to UITableView
//        self.view.addSubview(self.emailField)
//        self.view.addSubview(self.passwordField)
//
        self.view.addSubview(self.registerButton)

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.fieldsView.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 20),
            self.fieldsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.fieldsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.fieldsView.heightAnchor.constraint(equalToConstant: 46 * 2),
//            self.fieldsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),

//            self.emailField.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 20),
//            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
//            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//
//            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 20),
//            self.passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
//            self.passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//
            self.registerButton.topAnchor.constraint(equalTo: self.fieldsView.bottomAnchor, constant: 20),
            self.registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
}

extension SettingsAuthenticationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsAuthenticationFieldUITableViewCell.init(style: .value1, reuseIdentifier: "field")

        var textField: UITextField? = nil

        if (indexPath.row == 0) {
            cell.textLabel?.text = "Email"

            textField = self.emailField
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = "Password"

            textField = self.passwordField
        }

        cell.selectionStyle = .none
        cell.accessoryType = .none

//        let textField: UITextField = self.emailField

//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.adjustsFontSizeToFitWidth = true
//        textField.textColor = .white
//        textField.placeholder = "Field"
//        textField.keyboardType = .emailAddress
//        textField.returnKeyType = .continue
//        textField.autocorrectionType = .no
//        textField.autocapitalizationType = .none
//        textField.textAlignment = .left
//        textField.tag = 0
//        textField.clearButtonMode = .never
//        textField.isEnabled = true

        if let textField = textField {
            cell.contentView.addSubview(textField)

            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(lessThanOrEqualTo: cell.contentView.topAnchor),
                textField.bottomAnchor.constraint(lessThanOrEqualTo: cell.contentView.bottomAnchor),
                textField.leadingAnchor.constraint(equalTo: cell.textLabel!.trailingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                textField.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor)
            ])
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        46
    }
}

class SettingsAuthenticationFieldUITableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.textLabel?.frame.size.width = 80
    }
}

extension SettingsAuthenticationViewController {
    // todo: fix
    @objc func cancel() {
        print("cancel")
        self.dismiss(animated: true)
    }

    @objc func done() {
        self.navigationController?.popViewController(animated: true)
    }
}
