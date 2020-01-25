import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    private let settingsView: UITableView = UITableView(frame: .zero, style: .insetGrouped)

    private let rows: [SettingsSection] = [
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
                    color: .systemOrange
                )
            ]
        ),
        SettingsSection(
            header: "settings.section.feedback.title".localized(),
            items: [
                SettingsRow(
                    title: "settings.section.feedback.write.review".localized(),
                    icon: "heart.fill",
                    color: .systemPink
                ),
                SettingsRow(
                    title: "settings.section.feedback.contact.developer".localized(),
                    icon: "envelope.fill",
                    color: .systemBlue
                ),
                SettingsRow(
                    title: "settings.section.feedback.site".localized(),
                    icon: "desktopcomputer",
                    color: .systemGreen
                )
            ]
        ),
        SettingsSection(
            header: "settings.section.app.language".localized(),
            items: [
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
        self.settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.settingsView)
        
        NSLayoutConstraint.activate([
            self.settingsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.settingsView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.settingsView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.settingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath)
        let row = self.rows[indexPath.section].items[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = row.title
        cell.imageView?.image = UIImage(systemName: row.icon!)?
            .imageWithInsets(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))?
            .withTintColor(.white, renderingMode: .automatic)
        cell.imageView?.backgroundColor = row.color
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.layer.cornerRadius = 8
        cell.imageView?.layer.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destination = self.rows[indexPath.section].items[indexPath.row].destination {
            self.navigationController?.pushViewController(destination, animated: true)
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
    }
}
