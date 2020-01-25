import UIKit

class SettingsAboutViewController: UIViewController {
    private let settingsView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let rows: [SettingsSection] = [
        SettingsSection(
            items: [
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

extension SettingsAboutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "settings")
        let row = self.rows[indexPath.section].items[indexPath.row]

        cell.selectionStyle = .none
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.rows.count
    }
}
