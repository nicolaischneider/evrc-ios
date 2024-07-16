import SwiftUI

struct SectionHeader: View {
    
    private let title: String
    private let font: Font?
    
    // To allow for unnamed parameter
    init(_ title: String, _ font: Font? = nil) {
        self.title = title
        self.font = font
    }
    
    var body: some View {
        Text(title.localized)
            .foregroundColor(.black)
            .font(font ?? .title3)
            .bold()
            .lineLimit(2)
            .frame(minHeight: 38) // according to sketch
            .listRowBackground(Color.headerGray)
            .listRowSeparator(.hidden)
            .accessibilityIdentifier("\(title)")
    }
}

#Preview {
    Form {
        SectionHeader("Test")
        Text("t3st")
    }
}
