import SwiftUI
import SDWebImageSwiftUI

struct DanceTutorialView: View {
    let dance: Dance
    @State private var currentStepIndex = 0
    @State private var isPlaying = true
    @State private var playbackSpeed: Double = 1.0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Tutorial GIF with controls
                VStack(spacing: 8) {
                    if let gifURL = dance.tutorialGifURL {
                        AnimatedImage(url: gifURL)
                            .customLoopCount(0)
                            .playbackRate(playbackSpeed)
                            .playbackMode(.bounce)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                        
                        // Playback controls
                        HStack(spacing: 20) {
                            Button(action: { isPlaying.toggle() }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            
                            // Speed controls
                            Picker("Speed", selection: $playbackSpeed) {
                                Text("0.5x").tag(0.5)
                                Text("1x").tag(1.0)
                                Text("1.5x").tag(1.5)
                            }
                            .pickerStyle(.segmented)
                            .frame(width: 150)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Dance Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(dance.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(dance.artist)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(dance.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.top, 4)
                    
                    DifficultyBadge(difficulty: dance.difficulty)
                        .padding(.top, 4)
                }
                .padding(.horizontal)
                
                // Steps
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Steps")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Step navigation
                        HStack(spacing: 16) {
                            Button(action: previousStep) {
                                Image(systemName: "chevron.left.circle.fill")
                                    .foregroundColor(currentStepIndex > 0 ? .white : .gray)
                            }
                            .disabled(currentStepIndex == 0)
                            
                            Button(action: nextStep) {
                                Image(systemName: "chevron.right.circle.fill")
                                    .foregroundColor(currentStepIndex < dance.steps.count - 1 ? .white : .gray)
                            }
                            .disabled(currentStepIndex >= dance.steps.count - 1)
                        }
                        .font(.title2)
                    }
                    .padding(.horizontal)
                    
                    ForEach(Array(dance.steps.enumerated()), id: \.element.id) { index, step in
                        StepView(step: step, isActive: index == currentStepIndex)
                            .onTapGesture {
                                withAnimation {
                                    currentStepIndex = index
                                }
                            }
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color(hex: "121212"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func nextStep() {
        withAnimation {
            currentStepIndex = min(currentStepIndex + 1, dance.steps.count - 1)
        }
    }
    
    private func previousStep() {
        withAnimation {
            currentStepIndex = max(currentStepIndex - 1, 0)
        }
    }
}

struct StepView: View {
    let step: DanceStep
    let isActive: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Step number circle
            ZStack {
                Circle()
                    .fill(isActive ? Color.blue : Color(hex: "2C2C2E"))
                    .frame(width: 40, height: 40)
                
                Text("\(step.stepNumber)")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(step.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(step.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(nil)  // Allow multiple lines
                    .fixedSize(horizontal: false, vertical: true)  // Allow text to wrap
            }
            
            Spacer()
            
            // Step icon
            Image(systemName: step.imageSystemName)
                .foregroundColor(.gray)
                .font(.title3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: isActive ? "1C1C1E" : "121212"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isActive ? Color.blue.opacity(0.5) : Color.clear, lineWidth: 1)
        )
        .padding(.horizontal)
    }
} 
