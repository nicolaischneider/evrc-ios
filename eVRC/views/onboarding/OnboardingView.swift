//
//  OnboardingView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 17.05.24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var state = OnboardingPage.page1
    
    var body: some View {
        Group {
            switch state {
            case .page1:
                displayPage(for: .page1) {
                    state = .page2
                }
            case .page2:
                displayPage(for: .page2) {
                    state = .page3
                }
            case .page3:
                displayPage(for: .page3) {
                    dismiss()
                }
            }
        }
    }
    
    func displayPage(
        for state: OnboardingPage,
        action: @escaping (() -> Void)
    ) -> some View {
        VStack {
            
            state.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                .foregroundStyle(Color.blueDark)
                .padding(.vertical, 50)
            
            RichText(state.text, fontBold: .body.bold(), fontRegular: .body)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
            
            Spacer()
            
            ButtonRegular("general.continue".localized) {
                action()
            }
            .padding()
        }
    }
    
}

#Preview {
    OnboardingView()
}
