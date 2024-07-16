import SwiftUI
import CoreImage.CIFilterBuiltins

struct SharingQRCodeView: View {
    
    let qrCodeString: String
    let onButtonPress: () -> Void
    
    var body: some View {
        Form {
            AnyForm(headerText: "sharing.qr.code.header".localized) {
                VStack(alignment: .center) {
                    
                    Text("sharing.qr.code.instruction".localized)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
    
                    Image(uiImage: generateQRCode(from: qrCodeString))
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                    Text("sharing.qr.code.or")
                        .font(.footnote)
                    
                    ButtonCapsule("sharing.qr.code.share.button".localized, color: .pinkShare) {}
                    
                    Spacer()
                    
                    InformationBox(
                        icon: Image(systemName: "exclamationmark.triangle.fill"),
                        text: "sharing.qr-code.warning".localized,
                        background: .redLight,
                        iconColor: .redDark)
                    .padding(.vertical)
                    
                    ButtonRegular("general.done".localized) {
                        onButtonPress()
                    }
                    .padding(.bottom)
                }
            }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    SharingQRCodeView(qrCodeString: "ABCDEFGH", onButtonPress: {})
}
