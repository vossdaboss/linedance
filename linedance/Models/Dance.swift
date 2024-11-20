import Foundation

struct Dance: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let description: String
    let steps: [DanceStep]
} 