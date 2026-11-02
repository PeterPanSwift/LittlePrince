import SwiftUI

struct StoryHomeView: View {
    @AppStorage("readChapterIDs") private var readChapterIDs = ""
    @State private var isReading = false
    @State private var chapterToOpen = StoryLibrary.chapters[0]

    private var completedIDs: Set<String> { Set(readChapterIDs.split(separator: ",").map(String.init)) }
    private var nextChapter: StoryChapter { StoryLibrary.chapters.first { !completedIDs.contains($0.id) } ?? StoryLibrary.chapters[0] }

    var body: some View {
        List {
            StoryWelcomeView(hasStarted: !completedIDs.isEmpty) {
                chapterToOpen = nextChapter
                isReading = true
            }
                .listRowInsets(EdgeInsets(top: 12, leading: 24, bottom: 16, trailing: 24))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            Section {
                ForEach(StoryLibrary.chapters) { chapter in
                    NavigationLink {
                        ChapterDetailView(chapter: chapter)
                    } label: {
                        ChapterRow(chapter: chapter, isRead: completedIDs.contains(chapter.id))
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(StoryTheme.green.opacity(0.12))
                    .listRowInsets(EdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24))
                }
            } header: {
                HStack(alignment: .firstTextBaseline) {
                    Text("把故事，慢慢讀完").font(.system(.title3, design: .serif, weight: .semibold))
                    Spacer()
                    Text("\(completedIDs.count) / 6 篇").font(.caption).monospacedDigit().foregroundStyle(StoryTheme.muted)
                }
                .foregroundStyle(StoryTheme.ink).padding(.bottom, 6).textCase(nil)
            } footer: {
                Text("獻給每一位，曾經是孩子的大人。")
                    .font(.system(.caption, design: .serif)).foregroundStyle(StoryTheme.muted)
                    .frame(maxWidth: .infinity).padding(.vertical, 24)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationTitle("小王子")
        .navigationDestination(isPresented: $isReading) {
            ChapterDetailView(chapter: chapterToOpen)
        }
        .bookPage()
    }
}

private struct StoryWelcomeView: View {
    let hasStarted: Bool
    let startReading: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Eyebrow(text: "LE PETIT PRINCE")
                .padding(.top, 8).padding(.bottom, 14)
            Text("留一顆星星，\n給心裡的小孩。")
                .font(.system(.largeTitle, design: .serif, weight: .medium))
                .tracking(2).lineSpacing(5).multilineTextAlignment(.center)
                .foregroundStyle(StoryTheme.ink)
            Text("一段關於愛、友誼與成長的星際旅程")
                .font(.caption).tracking(1).foregroundStyle(StoryTheme.muted)
                .padding(.top, 12)
            Image("Storybook")
                .resizable().scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 26))
                .padding(.vertical, 18)
                .accessibilityLabel("水彩插畫：小王子和狐狸坐在星球上，身旁是一朵玫瑰")
            Button(action: startReading) {
                HStack(spacing: 10) {
                    Image(systemName: "book.pages")
                    Text(hasStarted ? "繼續我們的故事" : "翻開第一頁")
                    Spacer()
                    Image(systemName: "arrow.right")
                }
            }
            .buttonStyle(BookButtonStyle())
            HStack(spacing: 6) {
                Image(systemName: "sparkle")
                Text("6 篇故事手記・用一點時間，找回童心")
            }
            .font(.caption2).foregroundStyle(StoryTheme.muted).padding(.top, 12)
        }
        .frame(maxWidth: 660).frame(maxWidth: .infinity)
    }
}

private struct ChapterRow: View {
    let chapter: StoryChapter
    let isRead: Bool

    var body: some View {
        HStack(spacing: 14) {
            ArtworkThumbnail(artwork: chapter.artwork, size: 60)
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(verbatim: chapter.number).font(.system(.caption2, design: .serif)).foregroundStyle(chapter.tint.color)
                    Text(chapter.title).font(.system(.body, design: .serif, weight: .medium))
                }
                Text(chapter.subtitle).font(.caption).foregroundStyle(StoryTheme.muted)
            }
            Spacer(minLength: 0)
            if isRead {
                Image(systemName: "checkmark.circle.fill").foregroundStyle(StoryTheme.green).font(.caption).accessibilityLabel("已讀")
            }
        }
        .padding(.vertical, 2)
    }
}
