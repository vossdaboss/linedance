import Foundation
import SwiftUI

class DanceTutorialViewModel: ObservableObject {
    @Published var currentStepIndex = 0
    let dance: Dance
    
    var currentStep: DanceStep {
        dance.steps[currentStepIndex]
    }
    
    var canGoNext: Bool {
        currentStepIndex < dance.steps.count - 1
    }
    
    var canGoPrevious: Bool {
        currentStepIndex > 0
    }
    
    init(dance: Dance) {
        self.dance = dance
    }
    
    func nextStep() {
        guard canGoNext else { return }
        withAnimation {
            currentStepIndex += 1
        }
    }
    
    func previousStep() {
        guard canGoPrevious else { return }
        withAnimation {
            currentStepIndex -= 1
        }
    }
} 