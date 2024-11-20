import SwiftUI

struct DanceMenuView: View {
    var body: some View {
        List(DanceCollection.dances) { dance in
            NavigationLink(destination: DanceTutorialView(dance: dance)) {
                VStack(alignment: .leading) {
                    Text(dance.name)
                        .font(.headline)
                    Text(dance.artist)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Line Dances")
    }
} 