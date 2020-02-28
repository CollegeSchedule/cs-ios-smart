import UIKit
import AVFoundation
import QRCodeReader
import Alamofire

class SettingsAuthenticationViewController: UIViewController {
    // todo: get this piece of code out of the file
    enum DoneActionType {
        case login
        case signUp
    }

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
        view.text = "settings.section.authentication.login.description".localized()
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
        view.isHidden = true

        return view
    }()

    private let accountName: UILabel = {
        let view: UILabel = UILabel()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "User User"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 6, weight: .semibold)
        view.isHidden = true

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

    private lazy var subTitleLabelToBottomOfTitleLabel: NSLayoutConstraint = self.subTitleLabel.topAnchor.constraint(
        equalTo: self.titleLabel.bottomAnchor,
        constant: 20
    )

    private lazy var subTitleLabelToBottomOfAccountNameLabel: NSLayoutConstraint = self.subTitleLabel.topAnchor.constraint(
        equalTo: self.accountName.bottomAnchor,
        constant: 20
    )

    private var accountIdentification: AccountIdentification? = nil
    private var doneActionType: DoneActionType = .login

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

            self.accountName.topAnchor.constraint(equalTo: self.accountImage.bottomAnchor, constant: 6),
            self.accountName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.subTitleLabelToBottomOfTitleLabel,
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

extension SettingsAuthenticationViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()

        let result = result.value.split(separator: ":")

        self.accountIdentification = AccountIdentification(id: Int(result[1]) ?? 0, token: String(result[2]))

        // todo: API request

        self.toggleActionType(signUp: true)

        self.dismiss(animated: true)
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

        self.dismiss(animated: true)
    }
}

// todo: get this piece of code out of the file
struct APIResponse<T: Decodable>: Decodable {
    let status: Bool
    let data: T?
    let error: APIError?
}

struct APIError: Decodable {
    let code: Int
    let message: String
    let description: String
}

struct AuthenticationResult: Decodable {
    let access: Token
    let refresh: Token
}

struct Token: Decodable {
    let token: String
    let type: TokenType
    let lifetime: Int
    let createdAt: Int
}

enum TokenType: String, Decodable {
    case refresh = "REFRESH"
    case access = "ACCESS"
}

extension SettingsAuthenticationViewController {
    @objc
    private func doneAction() {
        if(!self.checkFields()) {
            print("bad fields")
        } else {
            // todo: get this piece of code out of the file
            AF.request(
                "http://80.80.80.101:5000/authentication",
                method: .put,
                parameters: [
                    "mail": self.emailField.text!,
                    "password": self.passwordField.text!
                ],
                encoding: JSONEncoding.default,
                headers: [
                    "appToken": "6a16pg94wnr834gmosx39",
                    "appSecret": "7viiuu2wkakandw2awvclp"
                ]
            ).responseDecodable(of: APIResponse<AuthenticationResult>.self) { result in
                print(result.data!)
            }
        }
    }

    @objc
    private func switchDoneAction() {
        if (self.doneActionType == .signUp) {
            self.toggleActionType(signUp: false)
        } else {
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

            readerViewController.delegate = self

            self.navigationController?.present(readerViewController, animated: true)
        }
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

    // todo: refactor
    private func toggleActionType(signUp: Bool) {
        self.accountImage.isHidden = !signUp
        self.accountName.isHidden = !signUp
        
        self.subTitleLabelToBottomOfTitleLabel.isActive = !signUp
        self.subTitleLabelToBottomOfAccountNameLabel.isActive = !signUp
        
        self.doneActionButton.setTitle(
            signUp ?
                "settings.section.authentication.login".localized()
                : "settings.section.authentication.register".localized(),
            for: .normal
        )
        
        self.subTitleLabel.text = signUp ?
            "settings.section.authentication.register.description".localized()
            : "settings.section.authentication.login.description".localized()
        
        self.doneActionType = signUp ? .signUp : .login
    }
}


