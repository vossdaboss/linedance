import Foundation
import SwiftUI

struct Dance: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    let description: String
    let difficulty: Difficulty
    let steps: [DanceStep]
    
    enum Difficulty: String {
        case beginner
        case highBeginner
        case intermediate
        case advanced
    }
} 