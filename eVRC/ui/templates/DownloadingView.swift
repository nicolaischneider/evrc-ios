import SwiftUI
import LocalAuthentication

struct DownloadingView: View {
    
    let title: String
    let richTextDescription: String
    var onComplete: ((Bool) -> Void)
    
    @State private var isAuthenticating = false
        
    var body: some View {
        Form {
            AnyForm(headerText: title) {
                VStack(alignment: .center, spacing: 15) {

                    HStack {
                        Spacer()
                        RichText(richTextDescription, fontBold: .body.bold(), fontRegular: .body)
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                authenticateUser()
            }
        }
    }
    
    private func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        let reason = "Identify yourself!"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            isAuthenticating = true
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    isAuthenticating = false
                    onComplete(success)
                }
            }
        } else {
            DispatchQueue.main.async {
                onComplete(false)
            }
        }
    }
}

#Preview {
    DownloadingView(
        title: "Some Step",
        richTextDescription: "We’re downloading your digital *Vehicle Registration Certificate*", 
        onComplete: { _ in })
}
