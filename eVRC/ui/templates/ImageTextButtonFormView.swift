import SwiftUI

struct ImageTextButtonFormView: View {
    
    var title: String
    var systemImage: String
    var imageColor: Color = Color.blueDark
    var description: String
    
    var onButtonBress: () -> Void
    
    var body: some View {
        Form {
            AnyForm(headerText: title) {
                VStack(alignment: .center, spacing: 15) {
                    
                    Image(systemName: systemImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundStyle(imageColor)
                        .padding()

                    RichText(description, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    ButtonRegular("general.continue".localized) {
                        onButtonBress()
                    }
                }
            }
        }
    }
}

#Preview {
    ImageTextButtonFormView(title: "update.title".localized, systemImage: "qrcode", description: "This is a *test*", onButtonBress: {})
}
