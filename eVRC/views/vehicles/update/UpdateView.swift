import SwiftUI

struct UpdateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: UpdateViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .noUpdate:
                    ImageTextButtonFormView(
                        title: "update.title".localized,
                        systemImage: "questionmark.circle.fill",
                        description: "update.noupdate.text".localized) {
                            dismiss()
                        }

                case .updateOneVehicle(let eVRCData):
                    EVRCUpdateAvailableView(eVRCs: [eVRCData]) {
                        viewModel.userRequestedUpdate()
                    }
                case .updateMultipleVehicles(let eVRCData):
                    EVRCUpdateDocumentsRevokedView(eVRCs: eVRCData) {
                        viewModel.userRequestedUpdate()
                    }
                case .updating:
                    DownloadingView(
                        title: "update.donwloading.title".localized,
                        richTextDescription: "update.donwloading.description".localized) { updated in
                            viewModel.didUpdate(updated)
                        }
                case .verified:
                    ImageTextButtonFormView(
                        title: "update.title".localized,
                        systemImage: "checkmark.seal.fill",
                        imageColor: .green,
                        description: "update.verified.description".localized) {
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
    UpdateView(viewModel: UpdateViewModel(state: .verified))
}
