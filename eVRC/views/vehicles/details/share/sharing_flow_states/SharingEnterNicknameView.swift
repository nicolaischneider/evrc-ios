import SwiftUI

struct SharingEnterNicknameView: View {
    
    @StateObject var viewModel: SharingViewModel
    
    @State private var textField = ""
    
    var body: some View {
        Form {
            AnyForm(headerText: "sharing.enter.nickname.header".localized) {
                VStack(alignment: .center) {
                    
                    Image(systemName: "person.crop.square.filled.and.at.rectangle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.blueDark)
                        .padding()
                    
                    RichText("sharing.enter.nickname.info".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    RichText("sharing.enter.nickname.disclaimer".localized, fontBold: .caption.bold(), fontRegular: .caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    TextField("sharing.onboarding.nickname.textField.placeholder".localized, text: $textField)
                        .padding()
                        .background(Color.systemGray)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    ButtonRegular("general.continue".localized, disabled: textField.isEmpty) {
                        viewModel.enteredNickname(textField)
                    }
                }
            }
        }
    }
}

#Preview {
    SharingEnterNicknameView(viewModel: SharingViewModel(vehicle: .constant(EVRCDataMock.example1)))
}
