import SwiftUI

struct SharingOnboardingView: View {
    
    let onButtonPress: () -> Void
    
    var body: some View {
        Form {
            AnyForm(headerText: "sharing.onboarding.header".localized) {
                VStack {
                    
                    InformationBox(
                        icon: Image(systemName: "qrcode"),
                        text: "sharing.onboarding.qrcode.info".localized,
                        background: .clear,
                        iconColor: .blueDark)
                    
                    InformationBox(
                        icon: Image(systemName: "info.circle.fill"),
                        text: "sharing.onboarding.licenseplate".localized,
                        background: .clear,
                        iconColor: .blueDark)
                    
                    InformationBox(
                        icon: Image(systemName: "exclamationmark.triangle.fill"),
                        text: "sharing.onboarding.restriction".localized,
                        background: .redLight,
                        iconColor: .redDark)
                    
                    ButtonRegular("general.continue".localized) {
                        onButtonPress()
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}

#Preview {
    SharingOnboardingView(onButtonPress: {})
}
