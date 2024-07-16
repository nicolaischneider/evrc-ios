import SwiftUI

struct ButtonCapsule: View {
    
    var title: String
    var color: Color
    var fullWidth: Bool
    var onPress: () -> Void
    
    init(_ title: String, color: Color, fullWidth: Bool = false, onPress: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.fullWidth = fullWidth
        self.onPress = onPress
    }
    
    var body: some View {
        Button {
            onPress()
        } label: {
            HStack {
                if fullWidth {
                    Spacer()
                }
                Text(title)
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(.white)
                if fullWidth {
                    Spacer()
                }
            }
            .padding(7)
            .padding(.horizontal, 10)
            .background(self.color)
            .cornerRadius(30)
        }
    }
}

#Preview {
    ButtonCapsule("Longer word", color: Color.pinkShare) {
        // nothing to do
    }
}

#Preview {
    ButtonCapsule("Longer word", color: Color.pinkShare, fullWidth: true) {
        // nothing to do
    }
    .padding()
}
