import UIKit

class SettingsAboutViewController: UIViewController {
    private let settingsView: UITableView = UITableView(frame: .zero, style: .insetGrouped)

    private let rows: [SettingsSection] = [
        SettingsSection(
            items: [
                SettingsRow(
                    title: "settings.section.feedback.site".localized(),
                    action: {
                        if let url = URL(string: "http://nke.ru") {
                            UIApplication.shared.open(url)
                        }
                    },
                    selectable: true
                ),
                SettingsRow(
                    title: "settings.section.about.about.app.version".localized(),
                    detail: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
                )
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.settingsView.delegate = self
        self.settingsView.dataSource = self
        self.settingsView.register(UITableViewCell.self, forCellReuseIdentifier: "settings")

        self.view.addSubview(self.settingsView)
        
        self.settingsView.pin(to: self.view)
    }
}

extension SettingsAboutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "settings")
        let row = self.rows[indexPath.section].items[indexPath.row]

        cell.accessoryType = row.action != nil ? .disclosureIndicator : .none
        cell.selectionStyle = row.selectable ? .default : .none
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.detail
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.rows[indexPath.section].items[indexPath.row]

        row.action?()

        self.settingsView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.rows.count
    }
}
