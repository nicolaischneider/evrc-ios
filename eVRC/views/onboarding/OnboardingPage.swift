import SwiftUI

enum OnboardingPage {
    case page1
    case page2
    case page3
    
    var image: Image {
        switch self {
        case .page1:
            return Image(systemName: "person.text.rectangle.fill")
        case .page2:
            return Image(systemName: "person.3.fill")
        case .page3:
            return Image(systemName: "shield.checkered")
        }
    }
    
    var text: String {
        switch self {
        case .page1:
            return "onboarding.page1.text".localized
        case .page2:
            return "onboarding.page2.text".localized
        case .page3:
            return "onboarding.page3.text".localized
        }
    }
}
