import UIKit

class SettingsAppearanceViewController: UIViewController {
    private let settingsView: UITableView = UITableView(frame: .zero, style: .insetGrouped)

    private var rows: [SettingsSection] = [
        SettingsSection(
            header: "settings.section.app.appearance.toggle.header".localized(),
            footer: "settings.section.app.appearance.toggle.footer".localized(),
            items: [
                SettingsRow(
                    title: "settings.section.app.appearance.toggle.title".localized(),
                    toggleable: true
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

        if (!SettingsStore.instance.isAppearanceAutomatically) {
            self.rows.append(contentsOf: [
                SettingsSection(
                    footer: "settings.section.app.appearance.switch.footer".localized(),
                    items: [
                        SettingsRow(
                            title: "settings.section.app.appearance.switch.light".localized(),
                            selectable: true,
                            special: .appearanceLight
                        ),
                        SettingsRow(
                            title: "settings.section.app.appearance.switch.dark".localized(),
                            selectable: true,
                            special: .appearanceDark
                        )
                    ]
                )
            ])
            self.settingsView.insertSections(IndexSet(integer: 1), with: .fade)
        }
    }
}

extension SettingsAppearanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath)
        let row = self.rows[indexPath.section].items[indexPath.row]

        if(row.toggleable) {
            let switchView = UISwitch(frame: .zero)

            switchView.setOn(SettingsStore.instance.isAppearanceAutomatically, animated: false)
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)

            cell.accessoryView = switchView
        } else if(row.selectable) {
            switch (row.special!) {
                case .appearanceLight:
                    if(SettingsStore.instance.appearance == UIUserInterfaceStyle.light) {
                        cell.accessoryType = .checkmark
                    }

                    break
                case .appearanceDark:
                    if(SettingsStore.instance.appearance == UIUserInterfaceStyle.dark) {
                        cell.accessoryType = .checkmark
                    }

                    break
            }
        }


        cell.selectionStyle = .none
        cell.textLabel?.text = row.title

        return cell
    }

    @objc
    func switchChanged(_ sender : UISwitch!) {
        if(sender.isOn) {
            self.rows.remove(at: 1)
            self.settingsView.deleteSections(IndexSet(integer: 1), with: .fade)
        } else {
            self.rows.append(contentsOf: [
                SettingsSection(
                    footer: "settings.section.app.appearance.switch.footer".localized(),
                    items: [
                        SettingsRow(
                            title: "settings.section.app.appearance.switch.light".localized(),
                            selectable: true,
                            special: .appearanceLight
                        ),
                        SettingsRow(
                            title: "settings.section.app.appearance.switch.dark".localized(),
                            selectable: true,
                            special: .appearanceDark
                        )
                    ]
                )
            ])
            self.settingsView.insertSections(IndexSet(integer: 1), with: .fade)
        }

        SettingsStore.instance.isAppearanceAutomatically = sender.isOn
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section != 1) {
            return
        }

        if(indexPath.row == 0) {
            // Light selected

            self.settingsView.cellForRow(at: IndexPath(row: 1, section: 1))?.accessoryType = .none
            self.settingsView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            SettingsStore.instance.appearance = UIUserInterfaceStyle.light
        } else if(indexPath.row == 1) {
            // Dark selected

            self.settingsView.cellForRow(at: IndexPath(row: 0, section: 1))?.accessoryType = .none
            self.settingsView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            SettingsStore.instance.appearance = UIUserInterfaceStyle.dark
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.rows[section].header
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        self.rows[section].footer
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows[section].items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        self.rows.count
    }
}
