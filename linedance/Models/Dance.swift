import Foundation
import SwiftUI

struct Dance: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let description: String
    let difficulty: DanceDifficulty
    let steps: [DanceStep]
    let tutorialGifURL: URL?
} 