import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    private let settingsView: UITableView = UITableView(frame: .zero, style: .insetGrouped)

    private let rows: [SettingsSection] = [
        SettingsSection(
            items: [
                SettingsRow(
                    destinationAction: {
                        let controller: SettingsAuthenticationViewController = SettingsAuthenticationViewController()
                        let navigationController: UINavigationController = UINavigationController(rootViewController: controller)

                        navigationController.navigationItem.largeTitleDisplayMode = .never

                        return navigationController
                    },
                    destinationType: .present,
                    special: .cellAuthentication
                )
            ]
        ),
        SettingsSection(
            header: "settings.section.app.appearance.title".localized(), 
            items: [
                SettingsRow(
                    title: "settings.section.app.appearance".localized(), 
                    icon: "lightbulb.fill", 
                    color: .systemPurple,
                    destination: {
                        let controller: SettingsAppearanceViewController = SettingsAppearanceViewController()

                        controller.title = "settings.section.app.appearance.title".localized()

                        return controller
                    }()
                ),
                SettingsRow(
                    title: "settings.section.app.language".localized(), 
                    icon: "globe", 
                    color: .systemOrange,
                    action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                )
            ]
        ),
        SettingsSection(
            header: "settings.section.feedback.title".localized(),
            items: [
                SettingsRow(
                    title: "settings.section.feedback.write.review".localized(),
                    icon: "heart.fill",
                    color: .systemGreen,
                    action: {}
                ),
                SettingsRow(
                    title: "settings.section.feedback.contact.developer".localized(),
                    icon: "envelope.fill",
                    color: .systemBlue,
                    action: {
                        UIApplication.keyWindow?.overrideUserInterfaceStyle = .unspecified

                        if let url = URL(string: "https://vk.com/impug") {
                            UIApplication.shared.open(url)
                        }
                    }
                ),
                SettingsRow(
                    title: "settings.section.about.about.app".localized(),
                    icon: "house.fill",
                    color: .systemPink,
                    destination: {
                        let controller = SettingsAboutViewController()

                        controller.title = "settings.section.about.about.app.title".localized()

                        return controller
                    }()
                )
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.settingsView.delegate = self
        self.settingsView.dataSource = self
        self.settingsView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "settings")
        self.settingsView.register(SettingsAuthenticationTableViewCell.self, forCellReuseIdentifier: "settings_authentication")

        self.view.addSubview(self.settingsView)

        self.settingsView.pin(to: self.view)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.rows[indexPath.section].items[indexPath.row]
        let cell: UITableViewCell = row.special == SettingsRow.Special.cellAuthentication
            ? tableView.dequeueReusableCell(withIdentifier: "settings_authentication", for: indexPath)
            : tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath)

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = row.title

        if let icon = row.icon {
            cell.imageView?.image = UIImage(systemName: icon)?
                .imageWithInsets(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))?
                .withTintColor(.white, renderingMode: .automatic)
        }

        cell.imageView?.backgroundColor = row.color
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.layer.cornerRadius = 8

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.rows[indexPath.section].items[indexPath.row].special == SettingsRow.Special.cellAuthentication ? 72 : -1.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.rows[indexPath.section].items[indexPath.row]

        if let destination = row.destination {
            self.present(destination: destination, destinationType: row.destinationType ?? SettingsRow.DestinationType.push)
        } else if let destinationAction = row.destinationAction {
            let destination: UIViewController = destinationAction()

            self.present(destination: destination, destinationType: row.destinationType ?? SettingsRow.DestinationType.push)
        } else if let action = row.action {
            action()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.rows[section].header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows[section].items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        self.rows.count
    }
}

extension SettingsViewController {
    private func present(destination: UIViewController, destinationType: SettingsRow.DestinationType) {
        switch (destinationType) {
            case .present:
                self.navigationController?.present(destination, animated: true)
                break;
            case .push:
                //self.navigationController?.pushViewController(destination, animated: true)
                self.splitViewController?.showDetailViewController(UINavigationController(rootViewController: destination), sender: nil)
                break;
        }
    }
}

private class SettingsTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.imageView?.frame.size.width = 32
        self.imageView?.frame.size.height = 32
        self.imageView?.frame.origin.y = (self.frame.height / 2) - (self.imageView!.frame.size.height / 2)
    }
}
