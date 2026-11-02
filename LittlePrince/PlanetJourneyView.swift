import SwiftUI

struct PlanetJourneyView: View {
    @State private var selectedID = StoryLibrary.planets[0].id

    private var selectedIndex: Int { StoryLibrary.planets.firstIndex { $0.id == selectedID } ?? 0 }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        Eyebrow(text: "A JOURNEY AMONG THE STARS")
                        Text("每一顆星球，\n都有一個小小的答案。")
                            .font(.system(.title2, design: .serif, weight: .medium))
                            .lineSpacing(5).multilineTextAlignment(.center)
                        Text("左右滑動，拜訪八個不同的世界")
                            .font(.subheadline).foregroundStyle(StoryTheme.muted)
                    }
                    .padding(.top, 12).padding(.horizontal, 24)
                    #if os(iOS)
                    TabView(selection: $selectedID) {
                        ForEach(StoryLibrary.planets) { planet in
                            PlanetCard(planet: planet)
                                .padding(.horizontal, 26)
                                .tag(planet.id)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: max(400, min(520, geometry.size.height * 0.62)))
                    #else
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 16) {
                            ForEach(StoryLibrary.planets) { planet in
                                PlanetCard(planet: planet)
                                    .containerRelativeFrame(.horizontal)
                                    .id(planet.id)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: Binding(get: { selectedID }, set: { if let id = $0 { selectedID = id } }))
                    .scrollIndicators(.hidden)
                    .frame(height: 510).padding(.horizontal, 26)
                    #endif
                    JourneyControls(selectedID: $selectedID, selectedIndex: selectedIndex)
                        .padding(.bottom, 16)
                }
                .frame(maxWidth: 720).frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("星球旅行")
        .bookPage()
    }
}

private struct PlanetCard: View {
    let planet: Planet
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                Text(planet.resident).font(.system(.caption, design: .monospaced)).foregroundStyle(planet.tint.color)
                PlanetWatercolorView(planetID: planet.id)
                    .frame(height: 140)
                Text(planet.name).font(.system(.title2, design: .serif, weight: .semibold)).multilineTextAlignment(.center)
                Text(planet.summary).font(.system(.body, design: .serif))
                    .lineSpacing(7).multilineTextAlignment(.center)
                Rectangle().fill(planet.tint.color.opacity(0.2)).frame(width: 42, height: 1)
                Text(planet.question).font(.subheadline).foregroundStyle(planet.tint.color).multilineTextAlignment(.center)
            }
            .padding(22).frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
        .background(.white.opacity(0.52), in: RoundedRectangle(cornerRadius: 28))
        .overlay { RoundedRectangle(cornerRadius: 28).stroke(planet.tint.color.opacity(0.18), lineWidth: 1) }
    }
}

private struct JourneyControls: View {
    @Binding var selectedID: String
    let selectedIndex: Int

    var body: some View {
        HStack(spacing: 22) {
            Button {
                selectedID = StoryLibrary.planets[selectedIndex - 1].id
            } label: {
                Image(systemName: "arrow.left").frame(width: 44, height: 44)
            }
            .disabled(selectedIndex == 0).accessibilityLabel("上一顆星球")
            HStack(spacing: 7) {
                ForEach(StoryLibrary.planets) { planet in
                    Circle().fill(planet.id == selectedID ? StoryTheme.green : StoryTheme.green.opacity(0.19))
                        .frame(width: planet.id == selectedID ? 8 : 5, height: planet.id == selectedID ? 8 : 5)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("第 \(selectedIndex + 1) 站，共 \(StoryLibrary.planets.count) 站")
            Button {
                selectedID = StoryLibrary.planets[selectedIndex + 1].id
            } label: {
                Image(systemName: "arrow.right").frame(width: 44, height: 44)
            }
            .disabled(selectedIndex == StoryLibrary.planets.count - 1).accessibilityLabel("下一顆星球")
        }
        .buttonStyle(.plain).foregroundStyle(StoryTheme.green)
    }
}

#Preview {
    NavigationStack { PlanetJourneyView() }
}
