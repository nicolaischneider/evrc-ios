import SwiftUI

struct SharingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: SharingViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .onboardingView:
                    SharingOnboardingView() {
                        viewModel.proceedToEnterNickname()
                    }
                case .enterNicknameView:
                    SharingEnterNicknameView(viewModel: viewModel)
                case .enterValidity:
                    SharingEnterValidityView(viewModel: viewModel)
                case .retrieveQRCode:
                    DownloadingView(
                        title: "sharing.donwload.title".localized,
                        richTextDescription: "sharing.donwload.description".localized) { verificationSuccessful in
                            viewModel.userFinishedAuthenticating(verificationSuccessful)
                        }
                case .qrCodeView(let qrCodeString):
                    SharingQRCodeView(qrCodeString: qrCodeString) {
                        dismiss()
                    }
                case .error(let errorDescription):
                    ErrorView(errorString: errorDescription, onButtonPress: {
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
                            case .enterNicknameView:
                                viewModel.state = .onboardingView
                            case .enterValidity:
                                viewModel.state = .enterNicknameView
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
    SharingView(viewModel: SharingViewModel(vehicle: .constant(EVRCDataMock.example1)))
}
