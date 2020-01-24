import SwiftUI

struct TodayView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: NewsView()) {
                Text("News")
            }
        }
    }
}

struct NewsView: View {
    var body: some View {
        VStack {
            Text("")
        }.navigationBarTitle(Text("NewsView"), displayMode: .large)
    }
}
