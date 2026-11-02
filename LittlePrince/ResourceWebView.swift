import SwiftUI
import WebKit

/// WebKit's native SwiftUI WebView keeps web content inside the navigation stack.
struct ResourceWebView: View {
    let resource: ReadingResource
    @State private var page = WebPage()
    @State private var loadingError = false
    @State private var reloadID = 0

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "globe")
                Text(verbatim: page.url?.host() ?? resource.url.host() ?? "")
                    .lineLimit(1).truncationMode(.middle)
                Spacer()
                Button {
                    reloadID += 1
                } label: {
                    Image(systemName: "arrow.clockwise").frame(width: 36, height: 36)
                }
                .accessibilityLabel("重新載入網頁")
            }
            .font(.caption).foregroundStyle(StoryTheme.muted)
            .padding(.horizontal, 18).padding(.vertical, 6)
            if page.isLoading {
                ProgressView(value: page.estimatedProgress).tint(StoryTheme.green)
                    .accessibilityLabel("網頁載入中")
            }
            ZStack {
                WebView(page)
                if loadingError {
                    ContentUnavailableView {
                        Label("暫時找不到這顆星球", systemImage: "wifi.exclamationmark")
                    } description: {
                        Text("網頁目前無法載入。請確認網路連線後再試一次。")
                    } actions: {
                        Button("重新嘗試") { reloadID += 1 }
                            .buttonStyle(.borderedProminent)
                    }
                    .background(StoryTheme.paper)
                }
            }
        }
        .navigationTitle(Text(resource.title))
        .bookPage()
        #if os(iOS)
        .toolbar(.hidden, for: .tabBar)
        #endif
        .task(id: reloadID) {
            loadingError = false
            do {
                for try await _ in page.load(resource.url) {
                    try Task.checkCancellation()
                }
            } catch {
                if !Task.isCancelled { loadingError = true }
            }
        }
    }
}
