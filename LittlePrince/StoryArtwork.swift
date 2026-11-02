import SwiftUI

/// All illustrations are bundled, so story pages remain available offline.
enum StoryArtwork: String {
    case prince = "Prince"
    case rose = "Rose"
    case fox = "Fox"
    case pilot = "Pilot"
    case well = "Well"
    case journey = "Journey"
    case storybook = "Storybook"

    var description: LocalizedStringResource {
        switch self {
        case .prince: "水彩插畫：穿著綠衣、戴著金色圍巾的小王子，捧著一顆星星"
        case .rose: "水彩插畫：玻璃罩裡的紅玫瑰與小澆水壺"
        case .fox: "水彩插畫：金色麥穗旁，捲起蓬鬆尾巴的狐狸"
        case .pilot: "水彩插畫：飛行員坐在沙漠裡畫畫，身旁停著螺旋槳飛機"
        case .well: "水彩插畫：小王子與飛行員在沙漠裡找到一口井"
        case .journey: "水彩插畫：以星光路徑連起的六顆小行星"
        case .storybook: "水彩插畫：小王子與狐狸坐在星球上，身旁是一朵玫瑰"
        }
    }
}

extension StoryChapter {
    var artwork: StoryArtwork {
        switch id {
        case "desert": .pilot
        case "rose": .rose
        case "planets": .journey
        case "fox": .fox
        case "well": .well
        default: .storybook
        }
    }
}

extension StoryCharacter {
    var artwork: StoryArtwork {
        switch id {
        case "rose": .rose
        case "fox": .fox
        case "pilot": .pilot
        default: .prince
        }
    }
}

struct StoryIllustration: View {
    let artwork: StoryArtwork
    var body: some View {
        Image(artwork.rawValue)
            .resizable().scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .accessibilityLabel(Text(artwork.description))
    }
}

struct ArtworkThumbnail: View {
    let artwork: StoryArtwork
    var size: CGFloat = 68
    var body: some View {
        Image(artwork.rawValue).resizable().scaledToFill()
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .accessibilityHidden(true)
    }
}

/// Each station reveals its own part of the hand-painted constellation artwork.
/// Cropping is a view layout operation; the original full illustration stays intact.
struct PlanetWatercolorView: View {
    let planetID: String

    private var crop: CGRect {
        switch planetID {
        case "b325": CGRect(x: 0.00, y: 0.39, width: 0.24, height: 0.48)
        case "b326": CGRect(x: 0.17, y: 0.12, width: 0.21, height: 0.37)
        case "b327": CGRect(x: 0.37, y: 0.015, width: 0.22, height: 0.35)
        case "b328": CGRect(x: 0.56, y: 0.15, width: 0.23, height: 0.39)
        case "b329": CGRect(x: 0.76, y: 0.27, width: 0.23, height: 0.43)
        default: CGRect(x: 0.67, y: 0.63, width: 0.27, height: 0.33)
        }
    }

    var body: some View {
        ZStack {
            if planetID == "b612" {
                StoryIllustration(artwork: .storybook)
            } else if planetID == "earth" {
                StoryIllustration(artwork: .well)
            } else {
                GeometryReader { geometry in
                    let scale = min(geometry.size.width / (1536 * crop.width), geometry.size.height / (1024 * crop.height))
                    let width = 1536 * scale
                    let height = 1024 * scale
                    Image("Journey").resizable()
                        .frame(width: width, height: height)
                        .offset(
                            x: -crop.minX * width,
                            y: -crop.minY * height
                        )
                        .frame(width: crop.width * width, height: crop.height * height, alignment: .topLeading)
                        .clipShape(PlanetCropBoundary(excludesUpperRight: planetID == "b330"))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
        .accessibilityHidden(true)
    }
}

private struct PlanetCropBoundary: Shape {
    let excludesUpperRight: Bool

    func path(in rect: CGRect) -> Path {
        guard excludesUpperRight else {
            return Path(roundedRect: rect, cornerRadius: 22)
        }
        // The telescope sits at upper left; the neighboring lamp is above right.
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.width * 0.52, y: 0))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.31),
            control1: CGPoint(x: rect.width * 0.56, y: rect.height * 0.31),
            control2: CGPoint(x: rect.width * 0.74, y: rect.height * 0.31)
        )
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
