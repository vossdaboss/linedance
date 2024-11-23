import SwiftUI

struct DanceMenuView: View {
    @State private var selectedDifficulty: DanceDifficulty?
    @State private var sortOption: SortOption = .name
    
    // Define sort options
    enum SortOption {
        case name
        case steps
        case difficulty
    }
    
    // Break up the filtering and sorting logic
    var displayedDances: [Dance] {
        let filtered = filterDances(DanceCollection.dances)
        return sortDances(filtered)
    }
    
    // Separate function for filtering
    private func filterDances(_ dances: [Dance]) -> [Dance] {
        guard let difficulty = selectedDifficulty else {
            return dances
        }
        return dances.filter { $0.difficulty == difficulty }
    }
    
    // Separate function for sorting
    private func sortDances(_ dances: [Dance]) -> [Dance] {
        switch sortOption {
        case .name:
            return dances.sorted { $0.name < $1.name }
        case .steps:
            return dances.sorted { $0.steps.count < $1.steps.count }
        case .difficulty:
            return dances.sorted { $0.difficulty.rawValue < $1.difficulty.rawValue }
        }
    }
    
    // Define difficulties array
    private let difficulties: [DanceDifficulty] = [
        .beginner,
        .highBeginner,
        .intermediate,
        .advanced
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Difficulty Filter Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterPill(title: "All", isSelected: selectedDifficulty == nil) {
                                selectedDifficulty = nil
                            }
                            
                            ForEach(difficulties, id: \.self) { difficulty in
                                FilterPill(
                                    title: difficulty.rawValue,
                                    isSelected: selectedDifficulty == difficulty,
                                    color: difficulty.color
                                ) {
                                    selectedDifficulty = difficulty
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 8)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300, maximum: 400))], spacing: 16) {
                        ForEach(displayedDances) { dance in
                            NavigationLink(destination: DanceTutorialView(dance: dance)) {
                                DanceCard(dance: dance)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(hex: "121212").ignoresSafeArea())
            .navigationTitle("Line Dances")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            sortOption = .name
                        } label: {
                            HStack {
                                Text("Name (A-Z)")
                                if sortOption == .name {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        
                        Button {
                            sortOption = .steps
                        } label: {
                            HStack {
                                Text("Steps (Low to High)")
                                if sortOption == .steps {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        
                        Button {
                            sortOption = .difficulty
                        } label: {
                            HStack {
                                Text("Difficulty")
                                if sortOption == .difficulty {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.white)
                    }
                }
            }
            .toolbarBackground(Color(hex: "121212"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .navigationViewStyle(.stack)
        .preferredColorScheme(.dark)
    }
}

struct DanceCard: View {
    let dance: Dance
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(dance.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(dance.artist)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "8E8E93"))
                }
                
                Spacer()
                
                DifficultyBadge(difficulty: dance.difficulty)
            }
            
            Text(dance.description)
                .font(.body)
                .foregroundColor(Color(hex: "8E8E93"))
                .lineLimit(2)
            
            HStack {
                Image(systemName: "music.note")
                    .foregroundColor(.white)
                Text("\(dance.steps.count) steps")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(hex: "8E8E93"))
            }
            .font(.subheadline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "121212"))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(radius: 2, y: 1)
    }
}

struct DifficultyBadge: View {
    let difficulty: DanceDifficulty
    
    var backgroundColor: Color {
        difficulty.color
    }
    
    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor.opacity(0.2))
            .foregroundColor(backgroundColor)
            .cornerRadius(8)
    }
}

// New component for filter pills
struct FilterPill: View {
    let title: String
    let isSelected: Bool
    var color: Color = .blue
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? color.opacity(0.2) : Color(hex: "1C1C1E"))
                )
                .overlay(
                    Capsule()
                        .stroke(isSelected ? color : Color(hex: "48484A"), lineWidth: 1)
                )
                .foregroundColor(isSelected ? color : .white)
        }
    }
}

// Add this extension to support hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
} 