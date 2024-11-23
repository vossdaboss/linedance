import Foundation

struct DanceStep: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let stepNumber: Int
    let imageSystemName: String
} 