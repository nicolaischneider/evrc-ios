import SwiftUI

struct VerificationFlowView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: VerificationFlowViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle, .generatingQRCode:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                case .advertising(let qr):
                    VerificationQRCodeView(
                        qrCode: qr,
                        licensePlateNumber: viewModel.eVRC.licensePlateNumber)
                case .loading:
                    Form {
                        AnyForm(headerText: "verification.loading.header".localized) {
                            VStack(alignment: .center, spacing: 15) {
                                
                                HStack {
                                    Spacer()
                                    RichText("verification.loading.description".localized, fontBold: .body.bold(), fontRegular: .body)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                    Spacer()
                                }
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .scaleEffect(1.5)
                                
                                Spacer().frame(height: 25)
                            }
                        }
                    }
                case .complete:
                    Form {
                        AnyForm(headerText: "verification.complete.header".localized) {
                            VStack(alignment: .center) {
                                Image(systemName: "checkmark.seal.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(.green)
                                    .padding()
                                
                                Text("verification.complete.description".localized(viewModel.eVRC.licensePlateNumber))
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                                
                                ButtonRegular("general.done".localized) {
                                    dismissAndQuitBLE()
                                }
                            }
                        }
                    }
                case .error:
                    ErrorView(errorString: "issuing.error.general".localized) {
                        dismissAndQuitBLE()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("general.quit".localized) {
                        dismissAndQuitBLE()
                    }
                }
            }
        }
    }
    
    func dismissAndQuitBLE() {
        viewModel.terminateConnection()
        dismiss()
    }
}

#Preview {
    VerificationFlowView(viewModel: VerificationFlowViewModel(eVRC: EVRCDataMock.example1))
}
