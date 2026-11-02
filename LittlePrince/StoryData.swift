import Foundation

struct StoryChapter: Identifiable {
    let id: String
    let number: String
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let symbol: String
    let tint: StoryTint
    let paragraphs: [StoryParagraph]
    let thought: LocalizedStringResource
}

struct StoryParagraph: Identifiable {
    let id: Int
    let text: LocalizedStringResource
}

struct Planet: Identifiable {
    let id: String
    let name: LocalizedStringResource
    let resident: LocalizedStringResource
    let symbol: String
    let tint: StoryTint
    let summary: LocalizedStringResource
    let question: LocalizedStringResource
}

struct StoryCharacter: Identifiable {
    let id: String
    let name: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let symbol: String
    let tint: StoryTint
    let introduction: LocalizedStringResource
    let lesson: LocalizedStringResource
    let chapterID: String
}

struct ReadingResource: Identifiable {
    let id: String
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let symbol: String
    let url: URL
}

enum StoryLibrary {
    // Stable identifiers preserve row identity and saved reading progress.
    static let chapters: [StoryChapter] = [
        StoryChapter(id: "desert", number: "01", title: "沙漠裡的相遇", subtitle: "一位飛行員，一個意想不到的小訪客", symbol: "airplane", tint: .sand,
            paragraphs: [
                StoryParagraph(id: 1, text: "飛機故障後，飛行員獨自留在撒哈拉沙漠。遠離人群的清晨，一個金髮小男孩突然出現，請他畫一隻綿羊。"),
                StoryParagraph(id: 2, text: "幾次嘗試都不合心意，飛行員索性畫了一個箱子，告訴小男孩，綿羊就在裡面。小王子卻滿意地笑了——他的想像，看得見紙上沒有畫出的東西。"),
                StoryParagraph(id: 3, text: "隨著兩人交談，飛行員慢慢知道，這位小小的旅人來自遙遠的星球。他的故事，也讓飛行員重新想起自己曾經擁有的童心。")
            ], thought: "如果不急著尋找標準答案，我們會看見什麼？"),
        StoryChapter(id: "rose", number: "02", title: "一朵獨一無二的玫瑰", subtitle: "在 B-612，學習照顧與告別", symbol: "leaf", tint: .rose,
            paragraphs: [
                StoryParagraph(id: 1, text: "小王子的家是小行星 B-612。他每天清理火山、拔除猴麵包樹的幼苗，讓小小的星球保持整潔。難過的時候，只要挪動椅子，就能再看一次日落。"),
                StoryParagraph(id: 2, text: "有一天，一朵美麗的玫瑰開了。小王子替她澆水、擋風，卻也被她驕傲的話語弄得困惑。他還不懂，如何讀懂藏在逞強背後的溫柔。"),
                StoryParagraph(id: 3, text: "他決定出發，去看看外面的世界。直到告別時，玫瑰才坦白自己的心意。小王子帶著眷戀離開，也帶著一個尚未解開的問題：愛，究竟是什麼？")
            ], thought: "我們是否也曾用逞強，藏起真正想說的話？"),
        StoryChapter(id: "planets", number: "03", title: "大人們的奇妙星球", subtitle: "六次拜訪，六種看世界的方式", symbol: "sparkles", tint: .lavender,
            paragraphs: [
                StoryParagraph(id: 1, text: "旅途中，小王子拜訪了六顆小行星。國王想要統治一切，愛慕虛榮的人只想聽到讚美，酒鬼則困在羞愧與喝酒的循環裡。"),
                StoryParagraph(id: 2, text: "商人忙著數星星，把擁有的數量當作人生的意義。點燈人不停點燈、熄燈，即使星球轉得越來越快，也不肯放下自己的工作。"),
                StoryParagraph(id: 3, text: "地理學家記錄遠方，卻沒有親自去探索。他建議小王子前往地球。小王子繼續旅行，也開始分辨：忙碌、佔有與受到崇拜，是否真的等於重要？")
            ], thought: "今天忙了一整天的事，真的是心裡在乎的事嗎？"),
        StoryChapter(id: "fox", number: "04", title: "狐狸教他的事", subtitle: "讓平凡變得特別的，是彼此的陪伴", symbol: "pawprint", tint: .terracotta,
            paragraphs: [
                StoryParagraph(id: 1, text: "來到地球，小王子看見一整座玫瑰花園。他原本以為自己的玫瑰是宇宙中唯一的一朵，如今卻失落地發現，世上還有許多相似的花。"),
                StoryParagraph(id: 2, text: "這時，他遇見了狐狸。狐狸邀請他慢慢建立關係：保持耐心、約好相見的時間，讓每一次等待都有意義。從此，麥田的金色也會讓狐狸想起小王子的頭髮。"),
                StoryParagraph(id: 3, text: "小王子終於明白，自己的玫瑰之所以特別，是因為他曾為她付出時間、傾聽她，也照顧她。關係讓彼此不再只是萬千生命中普通的一個。")
            ], thought: "誰讓你的日常，多了一個值得期待的時刻？"),
        StoryChapter(id: "well", number: "05", title: "沙漠深處的一口井", subtitle: "一起走過的路，讓一杯水有了意義", symbol: "drop", tint: .sky,
            paragraphs: [
                StoryParagraph(id: 1, text: "在沙漠裡，飛行員和小王子的飲水逐漸用盡。他們一起走進夜色，尋找一口井。星空很安靜，兩人的陪伴讓荒涼不再那麼令人害怕。"),
                StoryParagraph(id: 2, text: "終於找到水時，井上的轆轤發出聲音。那杯水珍貴的地方，不只是解渴，還有一路的尋找、努力與共同的盼望。"),
                StoryParagraph(id: 3, text: "小王子讓飛行員發現，有些美好無法只從外表判斷。沙漠之所以令人感動，也許正因為它在某個地方，藏著一口井。")
            ], thought: "你珍惜的，是某件東西，還是它背後的回憶？"),
        StoryChapter(id: "stars", number: "06", title: "星星裡的笑聲", subtitle: "一場告別，也是一份留在心裡的禮物", symbol: "star", tint: .sand,
            paragraphs: [
                StoryParagraph(id: 1, text: "離家的日子將滿一年，小王子惦記著自己的星球與玫瑰。他告訴飛行員，當夜裡仰望天空時，可以把所有星星都想成他的笑聲。"),
                StoryParagraph(id: 2, text: "小王子選擇與蛇相約，準備踏上回家的路。故事留下了悲傷而含蓄的告別：隔天，飛行員沒有找到他的身體，也不知道遠方的玫瑰後來如何。"),
                StoryParagraph(id: 3, text: "多年以後，飛行員仍然記得這位朋友。星空不再只是星空，而是一份牽掛。故事沒有替所有問題作答，卻邀請我們繼續關心那些看不見、仍然重要的連結。")
            ], thought: "如果思念有一種聲音，你想把它留在哪顆星星？")
    ]

    static let planets: [Planet] = [
        Planet(id: "b612", name: "小王子的星球", resident: "B-612 · 旅程的起點", symbol: "leaf", tint: .sage, summary: "三座火山、一朵玫瑰，還有看不膩的日落。這顆小小的星球，裝著小王子最深的牽掛。", question: "你的心裡，住著哪一朵玫瑰？"),
        Planet(id: "b325", name: "國王的星球", resident: "B-325 · 第一站", symbol: "crown", tint: .lavender, summary: "國王以為萬物都聽命於他，卻連一位臣民也沒有。小王子發現，真正的權威也需要理解與合理的要求。", question: "被服從，和被理解，有什麼不同？"),
        Planet(id: "b326", name: "愛慕虛榮者的星球", resident: "B-326 · 第二站", symbol: "hands.clap", tint: .rose, summary: "這裡的居民只聽得見讚美，將每位來客都當作崇拜者。掌聲很多，真正的對話卻很少。", question: "沒有掌聲時，你仍然喜歡自己嗎？"),
        Planet(id: "b327", name: "酒鬼的星球", resident: "B-327 · 第三站", symbol: "cloud", tint: .sky, summary: "酒鬼為了忘記喝酒帶來的羞愧而喝酒。小王子看見一個讓人難過的循環，卻不知道怎麼幫助他。", question: "遇到難題時，可以向誰伸出手？"),
        Planet(id: "b328", name: "商人的星球", resident: "B-328 · 第四站", symbol: "star.circle", tint: .sand, summary: "商人不停計算星星，聲稱所有星星都屬於自己。小王子不明白：如果沒有照顧它們，擁有又有什麼意義？", question: "擁有得更多，就一定更快樂嗎？"),
        Planet(id: "b329", name: "點燈人的星球", resident: "B-329 · 第五站", symbol: "lamp.desk", tint: .terracotta, summary: "星球越轉越快，點燈人仍忠實地點燈、熄燈。小王子欣賞他的付出，也為他沒有休息的時間感到惋惜。", question: "照顧別人的時候，也記得照顧自己嗎？"),
        Planet(id: "b330", name: "地理學家的星球", resident: "B-330 · 第六站", symbol: "map", tint: .sage, summary: "地理學家記錄山川大海，卻留在桌前，等待探險家的報告。他推薦小王子前往地球，旅程於是繼續。", question: "有哪個地方，你想親自去看看？"),
        Planet(id: "earth", name: "地球", resident: "EARTH · 第七站", symbol: "globe.asia.australia", tint: .sky, summary: "在遼闊的地球上，小王子遇見蛇、玫瑰、狐狸與飛行員。他走得很遠，最後才懂得自己想回到哪裡。", question: "走過世界之後，你最想回到誰的身邊？")
    ]

    static let characters: [StoryCharacter] = [
        StoryCharacter(id: "prince", name: "小王子", subtitle: "帶著好奇心的星際旅人", symbol: "sparkles", tint: .sage, introduction: "來自 B-612 的金髮小男孩。他不停提問，認真對待每一件小事，也願意用心聆聽。離開玫瑰之後，他在旅途中逐漸學會理解愛與責任。", lesson: "保留好奇，讓心裡的小孩陪你看世界。", chapterID: "desert"),
        StoryCharacter(id: "rose", name: "玫瑰", subtitle: "驕傲的外表，柔軟的心", symbol: "leaf", tint: .rose, introduction: "在小王子的星球上綻放的花。她美麗、敏感，偶爾愛逞強；那些看似任性的要求，藏著想被照顧與理解的心。", lesson: "學著聽見話語背後，沒說出口的在乎。", chapterID: "rose"),
        StoryCharacter(id: "fox", name: "狐狸", subtitle: "教會我們建立關係的朋友", symbol: "pawprint", tint: .terracotta, introduction: "狐狸邀請小王子用耐心與時間建立羈絆。牠讓小王子明白，陪伴會改變日常，也會讓一朵平凡的玫瑰，成為無可取代的存在。", lesson: "關係需要時間，也值得我們溫柔地等待。", chapterID: "fox"),
        StoryCharacter(id: "pilot", name: "飛行員", subtitle: "在沙漠裡，重新遇見童心", symbol: "airplane", tint: .sky, introduction: "故事的敘述者。因為飛機故障而留在沙漠，意外遇見小王子。他一邊修理飛機，一邊聽見另一個世界的故事，也找回被成人生活遺忘的想像力。", lesson: "長大以後，依然可以用孩子的眼睛去看。", chapterID: "well")
    ]

    static let resources: [ReadingResource] = [
        ReadingResource(id: "official", title: "走進小王子的世界", subtitle: "小王子官方網站 · 英文", symbol: "globe", url: URL(string: "https://www.lepetitprince.com/en/")!),
        ReadingResource(id: "book", title: "關於這本書", subtitle: "故事、作者與作品介紹 · 英文", symbol: "book.closed", url: URL(string: "https://www.lepetitprince.com/en/the-book/")!),
        ReadingResource(id: "author", title: "認識聖修伯里", subtitle: "作者官方網站 · 法文", symbol: "pencil.and.scribble", url: URL(string: "https://www.antoinedesaintexupery.org/")!)
    ]

    static func nextChapter(after chapter: StoryChapter) -> StoryChapter? {
        guard let index = chapters.firstIndex(where: { $0.id == chapter.id }), chapters.indices.contains(index + 1) else { return nil }
        return chapters[index + 1]
    }
}
