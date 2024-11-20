import Foundation
import SwiftUI

final class DanceTutorialViewModel: ObservableObject {
    @Published private(set) var currentStepIndex = 0
    let dance: Dance
    
    var currentStep: DanceStep {
        guard currentStepIndex < dance.steps.count else {
            return dance.steps[0] // Fallback to first step if index is out of bounds
        }
        return dance.steps[currentStepIndex]
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
        currentStepIndex += 1
    }
    
    func previousStep() {
        guard canGoPrevious else { return }
        currentStepIndex -= 1
    }
} 