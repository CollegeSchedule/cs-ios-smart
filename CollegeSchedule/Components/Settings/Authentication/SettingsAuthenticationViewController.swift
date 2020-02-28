import UIKit
import AVFoundation
import QRCodeReader
import Alamofire

class SettingsAuthenticationViewController: UIViewController {
    private let titleLabel: UILabel = UIView.initView() { view in
        view.text = "settings.section.authentication.id".localized()
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    private let subTitleLabel: UILabel = UIView.initView() { view in
        view.text = "settings.section.authentication.login.description".localized()
        view.numberOfLines = 2
        view.textAlignment = .center
        view.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private let accountImage: UIImageView = UIView.initView() { view in
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 30
        view.backgroundColor = .systemPink
        view.isHidden = true
    }

    private let accountName: UILabel = UIView.initView() { view in
        view.text = "User User"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize + 6, weight: .semibold)
        view.isHidden = true
    }

    private let fieldsView: UITableView = UIView.initView() { view in
        view.tableFooterView = UIView()
        view.isScrollEnabled = false
    }

    private let emailField: UITextField = UIView.initView() { view in
        view.placeholder = "settings.section.authentication.enter.id".localized()
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.keyboardType = .emailAddress
        view.returnKeyType = .continue
        view.clearButtonMode = .whileEditing
        view.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
    }

    private let passwordField: UITextField = UIView.initView() { view in
        view.placeholder = "settings.section.authentication.enter.password".localized()
        view.isSecureTextEntry = true
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.keyboardType = .default
        view.returnKeyType = .done
        view.clearButtonMode = .whileEditing
        view.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
    }

    private let doneActionButton: UIButton = UIButton.initView(type: .system) { view in
        view.setTitle("settings.section.authentication.register".localized(), for: .normal)
        view.addTarget(self, action: #selector(switchDoneAction), for: .touchUpInside)
    }

    private lazy var subTitleLabelToBottomOfTitleLabel: NSLayoutConstraint = self.subTitleLabel.topAnchor.constraint(
        equalTo: self.titleLabel.bottomAnchor,
        constant: 20
    )

    private lazy var subTitleLabelToBottomOfAccountNameLabel: NSLayoutConstraint = self.subTitleLabel.topAnchor.constraint(
        equalTo: self.accountName.bottomAnchor,
        constant: 20
    )

    // todo: get this piece of code out of the file
    enum DoneActionType {
        case login
        case signUp
    }
    
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
        let cell = SettingsAuthenticationFieldUITableViewCell.init(
            style: .value1,
            reuseIdentifier: "field",
            textField: indexPath.row == 0
                ? self.emailField
                : self.passwordField,
            title: indexPath.row == 0
                ? "settings.section.authentication.id".localized()
                : "settings.section.authentication.password".localized()
        )

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

extension SettingsAuthenticationViewController {
    @objc
    private func doneAction() {
        if(!self.checkFields()) {
            print("bad fields")
        } else {
            AF.request(.login(mail: "hello@whywelive.me", password: "12345678")) { result in
                
            }
        }
    }

    @objc
    private func switchDoneAction() {
        if (self.doneActionType == .signUp) {
            self.toggleActionType(signUp: false)
        } else {
            let readerViewController: QRCodeReaderViewController = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder() {
                $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)

                $0.showTorchButton = false
                $0.showSwitchCameraButton = false
                $0.showCancelButton = false
                $0.showOverlayView = true
                $0.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            })
            
            readerViewController.delegate = self

            self.navigationController?.present(readerViewController, animated: true)
        }
    }

    @objc
    private func cancel() {
        self.dismiss(animated: true)
    }

    // MARK: - refactor
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

    private func toggleActionType(signUp: Bool) {
        self.accountImage.isHidden = !signUp
        self.accountName.isHidden = !signUp
        
        self.subTitleLabelToBottomOfTitleLabel.isActive = !signUp
        self.subTitleLabelToBottomOfAccountNameLabel.isActive = !signUp
        
        self.doneActionButton.setTitle(
            signUp
                ? "settings.section.authentication.login".localized()
                : "settings.section.authentication.register".localized(),
            for: .normal
        )
        
        self.subTitleLabel.text = signUp
            ? "settings.section.authentication.register.description".localized()
            : "settings.section.authentication.login.description".localized()
        
        self.doneActionType = signUp ? .signUp : .login
    }
}


