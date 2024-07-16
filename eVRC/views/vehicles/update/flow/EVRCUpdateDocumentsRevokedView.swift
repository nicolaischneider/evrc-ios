//
//  EVRCUpdateDocumentsRevokedView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 05.06.24.
//

import SwiftUI

struct EVRCUpdateDocumentsRevokedView: View {
    let eVRCs: [EVRCData]
    var onButtonBress: () -> Void
    
    var descriptionText: String {
        return "update.revoke.description".localized
    }
    
    var body: some View {
        Form {
            AnyForm(headerText: "update.revoke.title") {
                VStack(alignment: .center, spacing: 15) {
                    
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.redDark)
                        .padding()

                    RichText(descriptionText, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    ForEach(eVRCs) { eVRC in
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(eVRC.licensePlateNumber)
                                    .font(.numberPlate25)
                                Text(eVRC.vehicleType)
                                    .font(.callout)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.systemGray)
                        .cornerRadius(10)
                    }
                    
                    ButtonRegular("general.understood".localized) {
                        onButtonBress()
                    }
                }
            }
        }
    }
}

#Preview {
    EVRCUpdateDocumentsRevokedView(eVRCs: [EVRCDataMock.example3 , EVRCDataMock.example1], onButtonBress: {})
}
