//
//  VerificationView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 28.05.24.
//

import SwiftUI

struct VerificationView: View {
    
    @Binding var vehicles: [EVRCData]
        
    @State private var vehicleToVerify: EVRCData?
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Spacer()
                Image(systemName: "shield.checkered")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
                    .foregroundStyle(Color.blueDark)
                    .padding(.vertical)
                Spacer()
            }
            
            Text("verification.selection.title")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            RichText("verification.selection.description".localized, fontBold: .body.bold(), fontRegular: .body)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            ScrollView {
                VStack {
                    ForEach(vehicles) { eVRC in
                        Button(action: {
                            self.vehicleToVerify = eVRC
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(eVRC.licensePlateNumber)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text(eVRC.vehicleType)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .padding()
        .sheet(item: $vehicleToVerify, onDismiss: {
            vehicleToVerify = nil
        }) { vehicleToVerify in
            VerificationFlowView(viewModel: VerificationFlowViewModel(eVRC: vehicleToVerify))
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    VerificationView(vehicles: .constant([EVRCDataMock.example1, EVRCDataMock.example2]))
}
