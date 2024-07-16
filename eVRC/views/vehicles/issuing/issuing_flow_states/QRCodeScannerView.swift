import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    
    @StateObject var viewModel: IssuingViewModel
    
    private let sizeCameraView = UIScreen.main.bounds.width*2/3
    
    var body: some View {
        Form {
            AnyForm(headerText: "issuing.qrscanner.title".localized) {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        ZStack {
                            CodeScannerView(codeTypes: [.qr]) { result in
                                switch result {
                                case .success(let value):
                                    viewModel.scannedQRCode(value.string)
                                case .failure:
                                    viewModel.errorOccurred(.general)
                                }
                            }
                            Image("scan_area")
                                .resizable()
                                .padding()
                        }
                        .frame(width: sizeCameraView, height: sizeCameraView)
                        .clipped()
                        Spacer()
                    }
                        
                    RichText("issuing.qrscanner.description".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    QRCodeScannerView(viewModel: IssuingViewModel(vehicles: .constant([])))
}
