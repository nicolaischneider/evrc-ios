import SwiftUI

enum TagType {
    case blue
    case info
    case red
    
    var background: Color{
        switch self {
        case .blue:
            return Color.blueLight
        case .red:
            return Color.redLight
        case .info:
            return Color.blueVeryLight
        }
    }
    
    var foreground: Color{
        switch self {
        case .blue:
            return Color.blueDark
        case .red:
            return Color.redDark
        case .info:
            return .black
        }
    }
}

struct TagView: View {
    
    let text: String
    let type: TagType
    
    var body: some View {
        Text(text)
            .font(.caption)
            .bold()
            .padding(5)
            .padding(.horizontal, 12)
            .background(type.background)
            .foregroundStyle(type.foreground)
            .cornerRadius(20)
    }
}

#Preview {
    VStack(spacing: 20) {
        TagView(text: "Test", type: .blue)
        TagView(text: "Test Long", type: .red)
        TagView(text: "Test Long", type: .info)
    }
}
