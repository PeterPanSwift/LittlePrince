import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("故事", systemImage: "book") {
                NavigationStack { StoryHomeView() }
            }
            Tab("星球旅行", systemImage: "sparkles") {
                NavigationStack { PlanetJourneyView() }
            }
            Tab("角色", systemImage: "person.2") {
                NavigationStack { CharactersView() }
            }
            Tab("探索", systemImage: "safari") {
                NavigationStack { ExploreView() }
            }
        }
        .tint(StoryTheme.green)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
