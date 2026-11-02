import SwiftUI

enum StoryTint {
    case sage, sand, rose, lavender, terracotta, sky

    var color: Color {
        switch self {
        case .sage: Color(red: 0.36, green: 0.46, blue: 0.36)
        case .sand: Color(red: 0.58, green: 0.42, blue: 0.19)
        case .rose: Color(red: 0.61, green: 0.34, blue: 0.34)
        case .lavender: Color(red: 0.47, green: 0.40, blue: 0.57)
        case .terracotta: Color(red: 0.64, green: 0.36, blue: 0.21)
        case .sky: Color(red: 0.29, green: 0.45, blue: 0.53)
        }
    }
}

enum StoryTheme {
    static let paper = Color(red: 0.98, green: 0.965, blue: 0.935)
    static let ink = Color(red: 0.25, green: 0.29, blue: 0.25)
    static let muted = Color(red: 0.42, green: 0.45, blue: 0.40)
    static let green = StoryTint.sage.color
}

struct PaperBackground: View {
    var body: some View {
        StoryTheme.paper
            .overlay {
                Canvas { context, size in
                    // Deterministic paper flecks: no random work or animation on redraw.
                    for index in 0..<900 {
                        let x = CGFloat((index * 73 + 19) % 997) / 997 * size.width
                        let y = CGFloat((index * 151 + 43) % 991) / 991 * size.height
                        let dot = CGRect(x: x, y: y, width: 0.8, height: 0.8)
                        context.fill(Path(ellipseIn: dot), with: .color(.brown.opacity(0.065)))
                    }
                }
            }
            .ignoresSafeArea()
            .accessibilityHidden(true)
    }
}

struct WatercolorEmblem: View {
    let symbol: String
    let tint: StoryTint
    var size: CGFloat = 58

    var body: some View {
        ZStack {
            Circle().fill(tint.color.opacity(0.08))
                .overlay { Ellipse().fill(tint.color.opacity(0.07)).rotationEffect(.degrees(-25)).padding(3) }
            Circle().stroke(tint.color.opacity(0.12), lineWidth: 1).padding(3)
            Image(systemName: symbol)
                .font(.system(size: size * 0.38, weight: .light))
                .foregroundStyle(tint.color)
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}

struct Eyebrow: View {
    let text: String
    var body: some View {
        Text(verbatim: text).font(.system(.caption2, design: .serif, weight: .medium))
            .tracking(3).foregroundStyle(StoryTint.sand.color)
    }
}

struct ReflectionCard: View {
    let thought: LocalizedStringResource
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("留一點時間，給心裡的答案", systemImage: "sparkle")
                .font(.caption).foregroundStyle(StoryTint.sand.color)
            Text(thought).font(.system(.body, design: .serif)).lineSpacing(6)
        }
        .padding(22).frame(maxWidth: .infinity, alignment: .leading)
        .background(StoryTint.sand.color.opacity(0.07), in: RoundedRectangle(cornerRadius: 20))
        .overlay { RoundedRectangle(cornerRadius: 20).stroke(StoryTint.sand.color.opacity(0.14), lineWidth: 1) }
    }
}

struct BookButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.subheadline, weight: .semibold))
            .padding(.vertical, 17).padding(.horizontal, 22)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(StoryTheme.green.opacity(configuration.isPressed ? 0.75 : 1), in: RoundedRectangle(cornerRadius: 17))
    }
}

struct BookPageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background { PaperBackground() }
            .foregroundStyle(StoryTheme.ink)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(StoryTheme.paper, for: .navigationBar)
            #endif
    }
}

extension View {
    func bookPage() -> some View { modifier(BookPageModifier()) }
}
