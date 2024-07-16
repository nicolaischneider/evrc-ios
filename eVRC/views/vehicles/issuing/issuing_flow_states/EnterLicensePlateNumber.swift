import SwiftUI

struct EnterLicensePlateNumber: View {
    
    @StateObject var viewModel: IssuingViewModel
    
    @State private var textField = ""
    
    @State private var shouldShowAlterView = false
    
    var body: some View {
        Form {
            AnyForm(headerText: "issuing.enternumber.title") {
                VStack(alignment: .center) {
                    
                    RichText("issuing.enternumber.text".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    TextField("issuing.enternumber.textfield.placeholder".localized, text: $textField)
                        .font(.numberPlate32)
                        .multilineTextAlignment(.center)
                        .keyboardType(.asciiCapable)
                        .disableAutocorrection(true)
                        .padding()
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .padding(.top, 30)
                            , alignment: .bottomLeading)
                        .padding(.horizontal, 35)
                        .onChange(of: textField) {
                            textField = filterAlphanumeric(textField)
                        }
                        .padding(.bottom)
                    
                    ButtonRegular("general.continue".localized, disabled: textField.isEmpty) {
                        shouldShowAlterView = true
                    }
                }
            }
        }
        .alert(isPresented: $shouldShowAlterView, content: {
            Alert(
                title: Text("issuing.enternumber.alert.title"),
                message: Text("issuing.enternumber.alert.message".localized("\(textField.uppercased())")),
                primaryButton: .default(Text("issuing.enternumber.alert.correct".localized), action: {
                    viewModel.enteredLicensePlateNumber(textField)
                }),
                secondaryButton: .cancel())
        })
    }
    
    func filterAlphanumeric(_ string: String) -> String {
        string.filter { $0.isLetter || $0.isNumber }
    }
}

#Preview {
    EnterLicensePlateNumber(viewModel: IssuingViewModel(vehicles: .constant([])))
}
