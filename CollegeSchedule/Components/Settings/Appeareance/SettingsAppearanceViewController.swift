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

    private let switchSection: SettingsSection = SettingsSection(
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

    private let lightIndexSet: IndexPath = IndexPath(row: 0, section: 1)
    private let darkIndexSet: IndexPath = IndexPath(row: 1, section: 1)

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
            self.addSwitchSelection()
        }
    }
}

extension SettingsAppearanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath)
        let row = self.rows[indexPath.section].items[indexPath.row]

        cell.accessoryType = .none
        cell.selectionStyle = .none
        cell.textLabel?.text = row.title

        if(row.toggleable) {
            let switchView = UISwitch(frame: .zero)

            switchView.setOn(SettingsStore.instance.isAppearanceAutomatically, animated: false)
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(self.switchChanged), for: .valueChanged)

            cell.accessoryView = switchView
        } else {
            if ((row.special! == SettingsRow.Special.appearanceLight
                && SettingsStore.instance.appearance == UIUserInterfaceStyle.light)
                || (row.special! == SettingsRow.Special.appearanceDark
                && SettingsStore.instance.appearance == UIUserInterfaceStyle.dark)) {
                cell.accessoryType = .checkmark
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section != 1) {
            return
        }

        let row = self.rows[indexPath.section].items[indexPath.row]

        SettingsStore.instance.appearance = (row.special! == SettingsRow.Special.appearanceLight)
            ? UIUserInterfaceStyle.light
            : UIUserInterfaceStyle.dark

        self.settingsView.cellForRow(at: self.lightIndexSet)?.accessoryType
            = (row.special! == SettingsRow.Special.appearanceLight) ? .checkmark : .none
        self.settingsView.cellForRow(at: self.darkIndexSet)?.accessoryType
            = (row.special! != SettingsRow.Special.appearanceLight) ? .checkmark : .none
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

extension SettingsAppearanceViewController {
    @objc
    func switchChanged(_ sender : UISwitch!) {
        SettingsStore.instance.isAppearanceAutomatically = sender.isOn

        if(sender.isOn) {
            self.removeSwitchSelection()
        } else {
            self.addSwitchSelection()
        }
    }

    private func addSwitchSelection() {
        self.rows.append(contentsOf: [self.switchSection])
        self.settingsView.insertSections(IndexSet(integer: 1), with: .fade)
    }

    private func removeSwitchSelection() {
        self.rows.remove(at: 1)
        self.settingsView.deleteSections(IndexSet(integer: 1), with: .fade)
    }
}
