import SwiftUI

struct AnyForm<Content: View>: View {
    
    let header: SectionHeader
    let formView: Content
    
    init(headerText: String, formView: @escaping () -> Content) {
        self.header = SectionHeader(headerText.localized)
        self.formView = formView()
    }
    
    init(headerAsLicensePlate: String, formView: @escaping () -> Content) {
        self.header = SectionHeader(headerAsLicensePlate, .numberPlate25)
        self.formView = formView()
    }
    
    var body: some View {
        Section {
            header
            formView
        }
    }
}

#Preview {
    Form {
        AnyForm(
            headerText: "Some Text") {
                VStack(spacing: 20) {
                    InformationBox(
                        icon: Image(systemName: "info.circle.fill"),
                        text: "This will be some text that will describe some scenario. Not sure what exactly.",
                        background: .blueLight)
                    
                    Text("Here would be some more text.")
                    
                    ButtonRegular("Some Button", onPress: {})
                }
            }
    }
}

#Preview {
    Form {
        AnyForm(
            headerAsLicensePlate: "AB CD 123") {
                VStack(spacing: 20) {
                    InformationBox(
                        icon: Image(systemName: "info.circle.fill"),
                        text: "This will be some text that will describe some scenario. Not sure what exactly.",
                        background: .redLight)
                }
            }
    }
}
