import SwiftUI

struct VerificationQRCodeView: View {
    
    let qrCode: UIImage
    let licensePlateNumber: String
    
    var body: some View {
        Form {
            AnyForm(headerText: "verification.qr.title".localized) {
                VStack(alignment: .center) {
                    RichText("verification.qr.description".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    TagView(text: licensePlateNumber, type: .info)
                    
                    Image(uiImage: qrCode)
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                    
                    InformationBox(
                        icon: Image(systemName: "info.circle.fill"),
                        text: "verification.qr.info".localized,
                        background: .blueLight,
                        iconColor: .blueDark)
                }
            }
        }
    }
}

#Preview {
    VerificationQRCodeView(qrCode: UIImage(systemName: "qrcode")!, licensePlateNumber: "AB CD 123")
}
