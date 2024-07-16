import SwiftUI

class RevokationFlowViewModel: ObservableObject {
    
    enum RevokationState {
        case askForConsent
        case loading
        case deleted
        case error(String)
    }
    
    @Published var state: RevokationState = .askForConsent
}

struct RevokationFlowView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var vehicle: EVRCData
    
    var sharedInstanceToRevoke: SharedInstance
    
    @StateObject var viewModel = RevokationFlowViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .askForConsent:
                    ImageTextButtonFormView(
                        title: "revocation.alert.revoke",
                        systemImage: "minus.circle.fill",
                        imageColor: Color.redDark,
                        description: "revocation.alert.title".localized(sharedInstanceToRevoke.nickname)) {
                            viewModel.state = .loading
                        }
                    
                case .loading:
                    DownloadingView(
                        title: "revocation.alert.revoke".localized,
                        richTextDescription: "revocation.loading.description".localized(sharedInstanceToRevoke.nickname)) { deleted in
                            if deleted {
                                viewModel.state = .deleted
                            } else {
                                viewModel.state = .error("issuing.error.general".localized)
                            }
                        }
                
                case .deleted:
                    ImageTextButtonFormView(
                        title: "revocation.alert.revoke",
                        systemImage: "checkmark.seal.fill",
                        imageColor: Color.green,
                        description: "revoke.done.description".localized(sharedInstanceToRevoke.nickname)) {
                            vehicle.sharedInstances.removeAll { $0 == sharedInstanceToRevoke }
                            dismiss()
                        }
                
                case .error(let string):
                    ErrorView(errorString: string) {
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("general.quit".localized) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    RevokationFlowView(vehicle: .constant(EVRCDataMock.example1), sharedInstanceToRevoke: SharedInstance(nickname: "Test"))
}
