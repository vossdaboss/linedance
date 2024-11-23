import SwiftUI

struct DanceMenuView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300, maximum: 400))], spacing: 12) {
                    ForEach(DanceCollection.dances) { dance in
                        NavigationLink(destination: DanceTutorialView(dance: dance)) {
                            DanceCard(dance: dance)
                        }
                    }
                }
                .padding(.horizontal, 8)
            }
            .navigationBarHidden(true)
        }
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
    let difficulty: Dance.Difficulty
    
    var backgroundColor: Color {
        switch difficulty {
        case .beginner: return .green
        case .highBeginner: return .blue
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
    
    var body: some View {
        Text(difficulty.rawValue.capitalized)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor.opacity(0.2))
            .foregroundColor(backgroundColor)
            .cornerRadius(8)
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