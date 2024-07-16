//
//  RevokationView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 10.05.24.
//

import SwiftUI

struct RevokationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var vehicle: EVRCData
    
    @State private var shouldShowRevokeAlert = false
    
    @State var sharedInstanceToRevoke: SharedInstance? = nil
    
    @State private var shouldShowRevokationFlow = false
    
    var body: some View {
        Form {
            AnyForm(headerAsLicensePlate: vehicle.licensePlateNumber) {
                VStack(alignment: .leading, spacing: 15) {
                    
                    RichText("revocation.description".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.leading)
                    
                    ForEach(vehicle.sharedInstances, id: \.id) { shared in
                        sharedPerson(shared: shared)
                    }
                }
            }
        }
        .sheet(isPresented: $shouldShowRevokeAlert, onDismiss: {
            sharedInstanceToRevoke = nil
            presentationMode.wrappedValue.dismiss()
        }, content: {
            if let sharedInstanceToRevoke {
                RevokationFlowView(vehicle: $vehicle, sharedInstanceToRevoke: sharedInstanceToRevoke)
            }
        })
        .onChange(of: vehicle) { _, newValue in
            self.sharedInstanceToRevoke = nil
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func sharedPerson(shared: SharedInstance) -> some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(shared.nickname)
                    .font(.body)
                    .bold()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("general.validfrom".localized)
                            .font(.caption)
                        
                        Text("general.validuntil".localized)
                            .font(.caption)
                    }
                    
                    if let validity = shared.validity {
                        VStack(alignment: .leading) {
                            Text(DateManager.convertDateToString(date: validity.validFrom, format: .regularDate))
                                .font(.caption)
                                .bold()
                            Text(DateManager.convertDateToString(date: validity.validUntil, format: .regularDate))
                                .font(.caption)
                                .bold()
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text("revocation.shared.unlimited".localized)
                                .font(.caption)
                                .bold()
                            Text("revocation.shared.unlimited".localized)
                                .font(.caption)
                                .bold()
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                self.sharedInstanceToRevoke = shared
                self.shouldShowRevokeAlert = true
            } label: {
                TagView(text: "revocation.alert.revoke".localized, type: .red)
            }

        }
        .padding()
        .background(Color.systemGray)
        .cornerRadius(10)
    }
    
    func revokeSharedInstance(shared: SharedInstance?) {
        self.vehicle.sharedInstances.removeAll { $0 == shared }
        self.sharedInstanceToRevoke = nil
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    RevokationView(vehicle: .constant(EVRCDataMock.example1))
}
