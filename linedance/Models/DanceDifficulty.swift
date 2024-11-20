import Foundation
import SwiftUI

enum DanceDifficulty: String {
    case beginner = "Beginner"
    case highBeginner = "High Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    
    var color: Color {
        switch self {
        case .beginner: return .green
        case .highBeginner: return .blue
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
    
    var icon: String {
        switch self {
        case .beginner: return "1.circle.fill"
        case .highBeginner: return "2.circle.fill"
        case .intermediate: return "3.circle.fill"
        case .advanced: return "4.circle.fill"
        }
    }
} 