//
//  ErrorView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 02.05.24.
//

import SwiftUI

struct ErrorView: View {
    
    let errorString: String
    let onButtonPress: () -> Void
    
    var body: some View {
        VStack() {
            Spacer()
            
            Image(systemName: "wrongwaysign.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .foregroundStyle(.red)
            
            Text(errorString)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            ButtonRegular("Back", background: .black, onPress: {
                onButtonPress()
            })
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorString: "An error ocurred", onButtonPress: {})
}
