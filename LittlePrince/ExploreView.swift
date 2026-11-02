import SwiftUI

struct ExploreView: View {
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 16) {
                Eyebrow(text: "BEYOND THE STORY")
                Text("把好奇心，\n帶到更遠的地方。")
                    .font(.system(.largeTitle, design: .serif, weight: .medium)).lineSpacing(5)
                Text("從一本小書，走進一個遼闊的世界。")
                    .font(.subheadline).foregroundStyle(StoryTheme.muted)
                StoryIllustration(artwork: .journey).padding(.top, 6)
            }
            .padding(.vertical, 14).listRowBackground(Color.clear).listRowSeparator(.hidden)
            Section {
                ForEach(StoryLibrary.resources) { resource in
                    NavigationLink {
                        ResourceWebView(resource: resource)
                    } label: {
                        HStack(spacing: 14) {
                            WatercolorEmblem(symbol: resource.symbol, tint: .sage, size: 48)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(resource.title).font(.system(.body, design: .serif, weight: .medium))
                                Text(resource.subtitle).font(.caption).foregroundStyle(StoryTheme.muted)
                            }
                        }.padding(.vertical, 10)
                    }
                    .listRowBackground(Color.clear).listRowSeparatorTint(StoryTheme.green.opacity(0.13))
                }
            } header: {
                Text("延伸閱讀").font(.system(.title3, design: .serif, weight: .semibold)).foregroundStyle(StoryTheme.ink).textCase(nil)
            } footer: {
                VStack(alignment: .leading, spacing: 12) {
                    Text("關於這本小書").font(.system(.headline, design: .serif))
                    Text("《小王子》由法國作家暨飛行員安東尼・聖修伯里創作，於 1943 年首次出版。透過一位小小旅人的眼睛，故事邀請我們重新思考愛、友誼與責任。")
                        .lineSpacing(5)
                    Text("此 App 為故事導讀，非官方作品。內容為自行整理的摘要與提問，插畫為 AI 生成。上方連結提供作品與作者的官方資訊；網頁需網路連線。")
                        .font(.caption2).lineSpacing(4)
                }
                .font(.caption).foregroundStyle(StoryTheme.muted).padding(.vertical, 24)
            }
        }
        .listStyle(.plain).contentMargins(.horizontal, 8).scrollContentBackground(.hidden)
        .navigationTitle("探索更多")
        .bookPage()
    }
}

#Preview {
    NavigationStack { ExploreView() }
}
