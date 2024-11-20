import SwiftUI

struct DanceMenuView: View {
    var body: some View {
        List {
            ForEach(DanceCollection.dances) { dance in
                NavigationLink(destination: DanceTutorialView(dance: dance)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(dance.name)
                                .font(.headline)
                            Text(dance.artist)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        // Difficulty indicator
                        VStack(alignment: .trailing) {
                            Image(systemName: dance.difficulty.icon)
                                .foregroundColor(dance.difficulty.color)
                            Text(dance.difficulty.rawValue)
                                .font(.caption)
                                .foregroundColor(dance.difficulty.color)
                        }
                    }
                }
            }
        }
        .navigationTitle("Line Dances")
    }
} 