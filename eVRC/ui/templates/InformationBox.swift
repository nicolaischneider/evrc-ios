import SwiftUI

struct InformationBox: View {
    
    let icon: Image?
    let text: String
    let background: Color
    var iconColor: Color = .black
    var showsChevron: Bool = false
    
    var body: some View {
        HStack {
                        
            if let icon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(iconColor)
                    .padding(.leading, 10)
            }
            
            RichText(text, fontBold: .body.bold(), fontRegular: .body)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.black)
                .padding(10)
            
            if showsChevron {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blueDark)
                    .padding(.trailing, 7)
            }
            
            Spacer()
        }
        .padding(10)
        .background(background)
        .cornerRadius(10)
    }
}

#Preview {
    VStack {
        InformationBox(icon: nil, text: "This will be some text that will describe some scenario. Not sure what exactly.", background: .blueLight)
        
        InformationBox(
            icon: Image(systemName: "info.circle.fill"),
            text: "This will be some *text that* will describe some scenario. Not sure what exactly.",
            background: .clear)
        
        InformationBox(
            icon: Image(systemName: "info.circle.fill"),
            text: "This will be some text that will describe some *scenario* Not sure what exactly.",
            background: .blueLight,
            iconColor: .blueDark,
            showsChevron: true)
    }
    .padding()
}
