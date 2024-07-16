import SwiftUI

struct ConfirmFaceIDOrPinView: View {
    
    @StateObject var viewModel: IssuingViewModel
    
    var body: some View {
        Form {
            AnyForm(headerText: "issuing.auth.info.title") {
                VStack(alignment: .center, spacing: 15) {
                    
                    Image(systemName: "faceid")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.blueDark)
                        .padding()

                    RichText("issuing.auth.info.text".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    ButtonRegular("general.continue".localized) {
                        viewModel.acceptedUsageOfFaceID()
                    }
                }
            }
        }
    }
}

#Preview {
    ConfirmFaceIDOrPinView(viewModel: IssuingViewModel(vehicles: .constant([])))
}
