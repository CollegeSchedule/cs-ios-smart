import UIKit
import AVFoundation
import QRCodeReader

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

    private let accountImage: UIImageView = {
        let view: UIImageView = UIImageView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 30
        view.backgroundColor = .systemPink

        return view
    }()

    private let accountName: UILabel = {
        let view: UILabel = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ХУИ ХУИСОВИЧ"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 6, weight: .semibold)

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
        view.clearButtonMode = .whileEditing
        view.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)

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
        view.returnKeyType = .done
        view.clearButtonMode = .whileEditing
        view.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)

        return view
    }()

    private let doneActionButton: UIButton = {
        let view: UIButton = UIButton(type: .system)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("settings.section.authentication.register".localized(), for: .normal)
        view.addTarget(self, action: #selector(switchDoneAction), for: .touchUpInside)

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.isModalInPresentation = true

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        self.navigationItem.rightBarButtonItem?.isEnabled = false

        self.fieldsView.delegate = self
        self.fieldsView.dataSource = self
        self.fieldsView.rowHeight = 46

        self.emailField.delegate = self
        self.passwordField.delegate = self

        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subTitleLabel)
        self.view.addSubview(self.accountImage)
        self.view.addSubview(self.accountName)
        self.view.addSubview(self.fieldsView)

        self.view.addSubview(self.doneActionButton)

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.accountImage.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.accountImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.accountImage.heightAnchor.constraint(equalToConstant: 60),
            self.accountImage.widthAnchor.constraint(equalToConstant: 60),

            self.accountName.topAnchor.constraint(equalTo: self.accountImage.bottomAnchor, constant: 20),
            self.accountName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.subTitleLabel.topAnchor.constraint(equalTo: self.accountName.bottomAnchor, constant: 20),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.fieldsView.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 20),
            self.fieldsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.fieldsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.fieldsView.heightAnchor.constraint(equalToConstant: 46 * 2),

            self.doneActionButton.topAnchor.constraint(equalTo: self.fieldsView.bottomAnchor, constant: 20),
            self.doneActionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0)
        ])
    }
}

extension SettingsAuthenticationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var textField: UITextField? = nil
        var text: String = ""

        if (indexPath.row == 0) {
            text = "settings.section.authentication.id".localized()
            textField = self.emailField
        } else if (indexPath.row == 1) {
            text = "settings.section.authentication.password".localized()
            textField = self.passwordField
        }

        let cell = SettingsAuthenticationFieldUITableViewCell.init(style: .value1, reuseIdentifier: "field", textField: textField, title: text)

        if (indexPath.row == 0) {
            cell.textLabel?.text = "settings.section.authentication.id".localized()
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = "settings.section.authentication.password".localized()
        }

        cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 4, weight: .bold)
        cell.selectionStyle = .none
        cell.accessoryType = .none

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
}

extension SettingsAuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.emailField) {
            self.passwordField.becomeFirstResponder()
        } else if (textField == self.passwordField) {
            self.view.endEditing(true)

            self.doneAction()
        }

        return true
    }

    @objc
    private func textFieldDidChangeText(_ textField: UITextField) {
        let _ = self.checkFields()
    }
}


extension SettingsAuthenticationViewController {
    @objc
    private func doneAction() {
        if(!self.checkFields()) {
            print("bad fields")
        } else {
            // api request
            // loading view
        }
    }

    @objc
    private func switchDoneAction() {
        let readerViewController: QRCodeReaderViewController = {
            let builder = QRCodeReaderViewControllerBuilder {
                $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)

                $0.showTorchButton = false
                $0.showSwitchCameraButton = false
                $0.showCancelButton = false
                $0.showOverlayView = true
                $0.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            }

            return QRCodeReaderViewController(builder: builder)
        }()

        self.navigationController?.present(readerViewController, animated: true)
    }

    @objc
    private func cancel() {
        self.dismiss(animated: true)
    }

    private func checkFields() -> Bool {
        // todo: check email
        // todo: check password

        if(!(self.emailField.text?.isEmpty ?? true) && !(self.passwordField.text?.isEmpty ?? true)) {
            self.navigationItem.rightBarButtonItem?.isEnabled = true

            return true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false

            return true
        }
    }
}

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