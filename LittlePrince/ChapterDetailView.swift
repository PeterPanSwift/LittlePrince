import SwiftUI

struct ChapterDetailView: View {
    let chapter: StoryChapter
    @AppStorage("readChapterIDs") private var readChapterIDs = ""
    private var isRead: Bool { readChapterIDs.split(separator: ",").contains(Substring(chapter.id)) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                ChapterHeading(chapter: chapter)
                ForEach(chapter.paragraphs) { paragraph in
                    Text(paragraph.text)
                        .font(.system(.body, design: .serif)).lineSpacing(10)
                        .fixedSize(horizontal: false, vertical: true)
                }
                ReflectionCard(thought: chapter.thought)
                Button {
                    var ids = Set(readChapterIDs.split(separator: ",").map(String.init))
                    if isRead { ids.remove(chapter.id) } else { ids.insert(chapter.id) }
                    readChapterIDs = ids.sorted().joined(separator: ",")
                } label: {
                    Label(isRead ? "已讀完這一篇" : "把這一篇，收進心裡", systemImage: isRead ? "checkmark.circle.fill" : "checkmark.circle")
                }
                .buttonStyle(BookButtonStyle())
                if let next = StoryLibrary.nextChapter(after: chapter) {
                    NavigationLink {
                        ChapterDetailView(chapter: next)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("下一篇故事").font(.caption).foregroundStyle(StoryTheme.muted)
                                Text(next.title).font(.system(.headline, design: .serif))
                            }
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                }
                Text("本篇為故事摘要與閱讀提問，並非原著全文。")
                    .font(.caption2).foregroundStyle(StoryTheme.muted)
            }
            .padding(26).frame(maxWidth: 720).frame(maxWidth: .infinity)
        }
        .navigationTitle(Text(chapter.title))
        .bookPage()
    }
}

private struct ChapterHeading: View {
    let chapter: StoryChapter
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Eyebrow(text: "CHAPTER  \(chapter.number)")
                Spacer()
                WatercolorEmblem(symbol: chapter.symbol, tint: chapter.tint, size: 52)
            }
            Text(chapter.title).font(.system(.largeTitle, design: .serif, weight: .medium))
            Text(chapter.subtitle).font(.subheadline).foregroundStyle(StoryTheme.muted)
            StoryIllustration(artwork: chapter.artwork)
                .frame(maxHeight: 310)
                .frame(maxWidth: .infinity)
            Rectangle().fill(chapter.tint.color.opacity(0.25)).frame(height: 1).padding(.top, 6)
        }
    }
}

#Preview {
    NavigationStack { ChapterDetailView(chapter: StoryLibrary.chapters[0]) }
}
