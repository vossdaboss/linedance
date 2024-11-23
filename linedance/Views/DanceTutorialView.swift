import SwiftUI

struct DanceTutorialView: View {
    let dance: Dance
    @StateObject private var viewModel: DanceTutorialViewModel
    
    init(dance: Dance) {
        self.dance = dance
        _viewModel = StateObject(wrappedValue: DanceTutorialViewModel(dance: dance))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 16) {
                    Text(dance.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(dance.artist)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        DifficultyBadge(difficulty: dance.difficulty)
                    }
                    
                    Text(dance.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .background(Color(.systemBackground))
                
                // Current Step
                if let currentStep = dance.steps.first(where: { $0.stepNumber == viewModel.currentStep }) {
                    StepCard(step: currentStep, isCurrentStep: true)
                }
                
                // Navigation Buttons
                HStack(spacing: 20) {
                    Button(action: viewModel.previousStep) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Previous")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.opacity(0.1))
                        .foregroundColor(.accentColor)
                        .cornerRadius(10)
                    }
                    .disabled(!viewModel.canGoPrevious)
                    .opacity(viewModel.canGoPrevious ? 1.0 : 0.5)
                    
                    Button(action: viewModel.nextStep) {
                        HStack {
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(!viewModel.canGoNext)
                    .opacity(viewModel.canGoNext ? 1.0 : 0.5)
                }
                .padding(.horizontal)
                
                // Step Progress
                Text("Step \(viewModel.currentStep) of \(dance.steps.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StepCard: View {
    let step: DanceStep
    let isCurrentStep: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: step.imageSystemName)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                
                Text(step.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Step \(step.stepNumber)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            
            Text(step.description)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: isCurrentStep ? 4 : 2, y: isCurrentStep ? 2 : 1)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.accentColor, lineWidth: isCurrentStep ? 2 : 0)
        )
        .padding(.horizontal)
        .scaleEffect(isCurrentStep ? 1.02 : 1.0)
        .animation(.spring(), value: isCurrentStep)
    }
} 