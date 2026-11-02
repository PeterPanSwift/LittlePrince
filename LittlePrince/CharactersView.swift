import SwiftUI

struct CharactersView: View {
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 12) {
                Eyebrow(text: "SOMEONE TO REMEMBER")
                Text("相遇，讓世界不一樣。")
                    .font(.system(.title, design: .serif, weight: .medium))
                Text("認識旅途中，那些溫柔而重要的身影。")
                    .font(.subheadline).foregroundStyle(StoryTheme.muted)
            }
            .padding(.vertical, 18).listRowSeparator(.hidden).listRowBackground(Color.clear)
            ForEach(StoryLibrary.characters) { character in
                NavigationLink {
                    CharacterDetailView(character: character)
                } label: {
                    HStack(spacing: 18) {
                        ArtworkThumbnail(artwork: character.artwork, size: 86)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(character.name).font(.system(.title3, design: .serif, weight: .medium))
                            Text(character.subtitle).font(.caption).foregroundStyle(StoryTheme.muted)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.vertical, 16)
                }
                .listRowBackground(Color.clear)
                .listRowSeparatorTint(StoryTheme.green.opacity(0.13))
            }
            ReflectionCard(thought: "有些相遇很短，卻會在心裡住很久。")
                .padding(.vertical, 26).listRowSeparator(.hidden).listRowBackground(Color.clear)
        }
        .listStyle(.plain).contentMargins(.horizontal, 8)
        .scrollContentBackground(.hidden)
        .navigationTitle("旅途中的朋友")
        .bookPage()
    }
}

struct CharacterDetailView: View {
    let character: StoryCharacter
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                VStack(spacing: 20) {
                    StoryIllustration(artwork: character.artwork)
                        .frame(maxHeight: 320)
                    Text(character.name).font(.system(.largeTitle, design: .serif, weight: .medium))
                    Text(character.subtitle).font(.subheadline).foregroundStyle(StoryTheme.muted)
                }
                .frame(maxWidth: .infinity).padding(.vertical, 20)
                Text(character.introduction).font(.system(.body, design: .serif)).lineSpacing(10)
                ReflectionCard(thought: character.lesson)
                if let chapter = StoryLibrary.chapters.first(where: { $0.id == character.chapterID }) {
                    NavigationLink {
                        ChapterDetailView(chapter: chapter)
                    } label: {
                        Label("讀讀這段相遇", systemImage: "book")
                    }
                    .buttonStyle(BookButtonStyle())
                }
            }
            .padding(26).frame(maxWidth: 680).frame(maxWidth: .infinity)
        }
        .navigationTitle(Text(character.name))
        .bookPage()
    }
}

#Preview {
    NavigationStack { CharactersView() }
}
