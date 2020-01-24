import SwiftUI

struct SettingsAboutView: View {
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Text("settings.section.about.about.app.version")
                        Spacer()
                        Text(self.getAppVersion())
                    }
                    // todo: add
//                    Text("settings.section.about.about.app.changelog")
                }
            }.listStyle(GroupedListStyle())
        }//.navigationBarTitle("settings.section.about.about.app.title", displayMode: .inline)
    }
    
    private func getAppVersion() -> String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}
