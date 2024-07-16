import SwiftUI

struct IssuingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: IssuingViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .scanQR:
                    QRCodeScannerView(viewModel: viewModel)
                case .enterLicensePlateNumber:
                    EnterLicensePlateNumber(viewModel: viewModel)
                case .confirmFaceIDusage:
                    ConfirmFaceIDOrPinView(viewModel: viewModel)
                case .downloadEVRC:
                    DownloadingView(
                        title: "issuing.download.title".localized,
                        richTextDescription: "issuing.download.text".localized) { verificationSuccessful in
                            viewModel.userFinishedAuthenticating(verificationSuccessful)
                        }
                case .successflDownload(let eVRC):
                    SuccessfulDownloadView(eVRCData: eVRC, onButtonPress: {
                        dismiss()
                    })
                case .error(let error):
                    ErrorView(errorString: error.localizedText, onButtonPress: {
                        dismiss()
                    })
                }
            }
            .toolbar {
                
                if viewModel.state.quitButtonAvailable {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("general.quit".localized) {
                            dismiss()
                        }
                    }
                }
                
                if viewModel.state.backButtonAvailable {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("general.back".localized) {
                            switch viewModel.state {
                            case .enterLicensePlateNumber:
                                viewModel.state = .scanQR
                            case .confirmFaceIDusage:
                                viewModel.state = .enterLicensePlateNumber
                            default:
                                print("nothing to do.")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    IssuingView(viewModel: IssuingViewModel(vehicles: .constant([])))
}
