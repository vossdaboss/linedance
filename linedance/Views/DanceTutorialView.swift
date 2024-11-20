import SwiftUI

struct DanceTutorialView: View {
    @StateObject private var viewModel: DanceTutorialViewModel
    
    init(dance: Dance) {
        _viewModel = StateObject(wrappedValue: DanceTutorialViewModel(dance: dance))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            Text(viewModel.dance.name)
                .font(.largeTitle)
                .bold()
            
            Text(viewModel.dance.artist)
                .font(.title2)
                .foregroundColor(.secondary)
            
            // Step Display
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(systemName: viewModel.currentStep.imageSystemName)
                        .font(.system(size: 40))
                    
                    Text("Step \(viewModel.currentStep.stepNumber)")
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
                }
                .disabled(!viewModel.canGoPrevious)
                
                Button(action: viewModel.nextStep) {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.system(size: 44))
                }
                .disabled(!viewModel.canGoNext)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
} 