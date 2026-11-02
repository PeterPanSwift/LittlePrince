# 小王子 · SwiftUI 故事導讀

以奶油色紙張、低彩度水彩插畫與繁體中文內容，介紹《小王子》的故事與角色。

## 功能與程式碼對照

| 需求 | 實作位置 | 操作方式 |
| --- | --- | --- |
| 多頁面、分檔定義 | `StoryHomeView.swift`、`ChapterDetailView.swift`、`PlanetJourneyView.swift`、`CharactersView.swift`、`ExploreView.swift`、`ResourceWebView.swift` | 每個主要頁面有獨立檔案 |
| `TabView` 與 `Tab` | `ContentView.swift` | 故事、星球旅行、角色、探索四個分頁 |
| `NavigationStack` 與 `NavigationLink` | `ContentView.swift` 與各分頁 | 每個分頁有自己的導覽堆疊；點選故事或角色進入詳細頁 |
| 傳資料到下一頁 | `ChapterDetailView(chapter:)`、`CharacterDetailView(character:)`、`ResourceWebView(resource:)` | 將點選的自訂 struct 傳給目的頁 |
| Navigation bar 標題 | 各頁 `.navigationTitle` | 詳細頁顯示目前故事、角色或網站的名稱 |
| struct、array 與 `Identifiable` | `StoryData.swift` | 六篇故事、八站旅程、四位角色與三個網站；各自有穩定 ID |
| `List` | `StoryHomeView.swift`、`CharactersView.swift`、`ExploreView.swift` | 顯示故事、角色和延伸閱讀列表 |
| `.page` 水平分頁 | `PlanetJourneyView.swift` | iOS 以 `TabView(selection:)` 搭配 `.tabViewStyle(.page)`；提供頁碼圓點和上／下一站按鈕 |
| WebView | `ResourceWebView.swift` | 使用 WebKit 原生 SwiftUI `WebView` 與 `WebPage`，提供載入進度、失敗提示及重試 |
| 可愛水彩風格 | `StoryTheme.swift`、`Assets.xcassets/Storybook.imageset` | 紙張底紋、水彩主插畫、植物綠按鈕與淡彩圖示 |
| 閱讀進度 | `StoryHomeView.swift`、`ChapterDetailView.swift` | 讀完後可標記；使用 `@AppStorage` 保留進度，再次點選可取消標記 |

## 執行

以 Xcode 開啟 `LittlePrince.xcodeproj`，選取 `LittlePrince` scheme 及 iPhone 模擬器後執行。維持原專案的 SDK 與部署版本設定。原生 SwiftUI `WebView` 需要 iOS 26 / macOS 26 或更新版本；此專案目前設定的部署版本更高。

專案也保留 macOS 的編譯支援；macOS 沒有 iOS 的 `.page` 樣式，因此星球旅行使用水平捲動與對齊分頁。

故事、角色、星球資料與插畫皆隨 App 提供，可離線閱讀；探索頁的外部網站需要網路。沒有第三方套件。

## 內容與素材

- 故事為自行整理的摘要與閱讀提問，並非原著全文或官方 App。
- 作者、出版及作品背景參考：[小王子官方作品介紹](https://www.lepetitprince.com/en/the-book/)、[作者官方網站](https://www.antoinedesaintexupery.org/)。
- 七張水彩插畫由 imagegen 產生：首頁、小王子、玫瑰、狐狸、飛行員、沙漠水井與星球旅程。資產已複製進專案，不依賴本機其他目錄。`StoryArtwork.swift` 統一管理圖片對應與無障礙說明；星球頁透過 SwiftUI 裁切展示各站插畫，保留原始完整圖檔。
- WebKit API 參考：[Apple WebKit for SwiftUI](https://developer.apple.com/documentation/webkit/webkit-for-swiftui)。

## 已驗證的主要流程

- iPhone 17 模擬器編譯與啟動。
- 四個分頁切換、首頁閱讀按鈕、故事詳細頁標題與內容。
- 閱讀標記新增、保存與取消；驗證後恢復為 0 / 6 篇。
- 星球卡片左右滑動、上／下一站按鈕。
- 角色列表、角色詳細頁與相關故事導覽。
- 官方網站透過 WebView 實際載入，重新載入與返回探索頁。
- 七個插畫資產集的檔案參照完整，無外部路徑依賴。

截圖位於同目錄的 `home.png`、`characters.png` 與 `planets.png`。
