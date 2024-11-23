import Foundation
import SwiftUI

final class DanceTutorialViewModel: ObservableObject {
    @Published var currentStep = 1
    private let dance: Dance
    
    var canGoNext: Bool {
        currentStep < dance.steps.count
    }
    
    var canGoPrevious: Bool {
        currentStep > 1
    }
    
    init(dance: Dance) {
        self.dance = dance
    }
    
    func nextStep() {
        guard canGoNext else { return }
        currentStep += 1
    }
    
    func previousStep() {
        guard canGoPrevious else { return }
        currentStep -= 1
    }
} 