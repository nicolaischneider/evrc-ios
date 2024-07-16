//
//  VehicleDetailsView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 30.04.24.
//

import SwiftUI

struct VehicleDetailsView: View {
    
    @Binding var vehicle: EVRCData
    
    var onDelete: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var shouldShowShareCopyView: Bool = false
    @State private var shouldShowAlertForDeletion = false
    @State private var shouldShowUpdateView = false
    
    var body: some View {
        Form {
            AnyForm(headerAsLicensePlate: vehicle.licensePlateNumber) {
                VStack {
                    infoBoxOnSharedInstances
                        .padding(.bottom)
                    
                    /*ButtonCapsule("Update", color: .blueDark, fullWidth: true) {
                        shouldShowUpdateView = true
                    }
                    .padding(.vertical, 10)*/
                    
                    ForEach(Array(vehicle.valuesAsArray().enumerated()), id: \.offset) { _, element in
                        HStack {
                            field(type: element.0, value: element.1)
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                }
            }
            
            HStack {
                Spacer()
                Button("details.delete.button".localized) {
                    shouldShowAlertForDeletion = true
                }
                .foregroundColor(.red)
                Spacer()
            }
        }
        .navigationTitle("details.navigation.title".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !vehicle.isSharedInstance {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("details.navigation.share.button".localized) {
                        self.shouldShowShareCopyView = true
                    }
                }
            }
        }
        .sheet(isPresented: $shouldShowShareCopyView, content: {
            SharingView(viewModel: SharingViewModel(vehicle: $vehicle))
        })
        .sheet(isPresented: $shouldShowUpdateView, content: {
            UpdateView(viewModel: UpdateViewModel(state: .updateMultipleVehicles([vehicle])))
                .interactiveDismissDisabled()
        })
        .alert(isPresented: $shouldShowAlertForDeletion, content: {
            Alert(title: Text("details.alert.title".localized),
                  message: Text("details.alert.message".localized(vehicle.licensePlateNumber)),
                  primaryButton:
                    .destructive(
                        Text("details.alert.delete".localized),
                        action: {
                            deleteDocument()
                        }), 
                  secondaryButton: .cancel())
        })
    }
    
    func field(type: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(type)
                .font(.callout)
                .bold()
            Text(value)
                .font(.callout)
                .multilineTextAlignment(.leading)

        }
    }
    
    @ViewBuilder var infoBoxOnSharedInstances: some View {
        
        if vehicle.isSharedInstance {
            
            VStack(spacing: 10) {
                InformationBox(
                    icon: Image(systemName: "info.circle.fill"),
                    text: "details.infobox.shared.text".localized,
                    background: .blueLight,
                    iconColor: .blueDark,
                    showsChevron: false)
                if let validity = vehicle.validity {
                    HStack(spacing: 10) {
                        InformationBox(
                            icon: nil,
                            text: "details.infobox.shared.validfrom".localized(DateManager.convertDateToString(date: validity.validFrom, format: .regularDate)),
                            background: .blueLight,
                            showsChevron: false)
                        InformationBox(
                            icon: nil,
                            text: "details.infobox.shared.validuntil".localized(DateManager.convertDateToString(date: validity.validUntil, format: .regularDate)),
                            background: .blueLight,
                            showsChevron: false)
                    }
                }
            }
            
        } else if !vehicle.sharedInstances.isEmpty {
            VStack {
                NavigationLink {
                    RevokationView(vehicle: $vehicle)
                } label: {
                    InformationBox(
                        icon: nil,
                        text: "details.infobox.main.info".localized(String(vehicle.sharedInstances.count)),
                        background: .clear,
                        showsChevron: false)
                }
            }
            .padding(.trailing, 10)
            .background(Color.blueLight)
            .cornerRadius(10)
            
        } else {
            EmptyView()
        }
    }
    
    func deleteDocument(){
        onDelete()
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    VehicleDetailsView(vehicle: .constant(EVRCDataMock.example1), onDelete: {})
}

#Preview {
    VehicleDetailsView(vehicle: .constant(EVRCDataMock.exampleShared), onDelete: {})
}
