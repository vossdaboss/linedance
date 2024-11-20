import SwiftUI

struct DanceTutorialView: View {
    @StateObject private var viewModel: DanceTutorialViewModel
    
    init(dance: Dance) {
        self._viewModel = StateObject(wrappedValue: DanceTutorialViewModel(dance: dance))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text(viewModel.dance.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(viewModel.dance.artist)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    // Difficulty badge
                    HStack {
                        Image(systemName: viewModel.dance.difficulty.icon)
                        Text(viewModel.dance.difficulty.rawValue)
                    }
                    .font(.subheadline)
                    .foregroundColor(viewModel.dance.difficulty.color)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(viewModel.dance.difficulty.color.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // Progress indicator
                ProgressView(value: Double(viewModel.currentStepIndex + 1), total: Double(viewModel.dance.steps.count))
                    .tint(viewModel.dance.difficulty.color)
                    .padding(.horizontal)
                
                // Step Display
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: viewModel.currentStep.imageSystemName)
                            .font(.system(size: 40))
                            .foregroundColor(viewModel.dance.difficulty.color)
                        
                        Text("Step \(viewModel.currentStep.stepNumber) of \(viewModel.dance.steps.count)")
                            .font(.title)
                    }
                    
                    Text(viewModel.currentStep.name)
                        .font(.title2)
                        .bold()
                    
                    Text(viewModel.currentStep.description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Navigation Buttons
                HStack(spacing: 40) {
                    Button(action: viewModel.previousStep) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(viewModel.dance.difficulty.color)
                    }
                    .disabled(!viewModel.canGoPrevious)
                    .opacity(viewModel.canGoPrevious ? 1.0 : 0.3)
                    
                    Button(action: viewModel.nextStep) {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(viewModel.dance.difficulty.color)
                    }
                    .disabled(!viewModel.canGoNext)
                    .opacity(viewModel.canGoNext ? 1.0 : 0.3)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
} 