//
//  VehiclesView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 29.04.24.
//

import SwiftUI

struct VehiclesView: View {
    
    @Binding var vehicles: [EVRCData]
    
    @State private var shouldShowIssuingView = false
    @State private var shouldShowUpdateView = false
    @State private var shouldShowAboutSection = false
    @State private var shouldShowOnboarding = false
    
    var body: some View {
        Group {
            if vehicles.isEmpty {
                VStack {
                    Button {
                        self.shouldShowIssuingView = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("vehicles.add.vehicle.large.button")
                                .font(.subheadline)
                                .padding()
                            Spacer()
                        }
                        .frame(height: 150)
                        .background(Color.systemGray)
                        .cornerRadius(10)
                        .padding()
                    }
                    Spacer()
                }

            } else {
                List {
                    ForEach($vehicles.indices, id: \.self) { index in
                        AnyForm(headerAsLicensePlate: vehicles[index].licensePlateNumber) {
                            NavigationLink {
                                VehicleDetailsView(vehicle: $vehicles[index]) {
                                    vehicles.remove(at: index)
                                }
                            } label: {
                                SingleVehicleDataView(vehicle: vehicles[index])
                            }
                        }
                    }
                    
                    Button {
                        self.shouldShowIssuingView = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("vehicles.add.vehicle.small.button")
                            Spacer()
                        }
                    }

                }
            }
        }
        .navigationTitle("vehicles.navigation.title")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $shouldShowIssuingView) {
            IssuingView(viewModel: IssuingViewModel(vehicles: $vehicles))
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $shouldShowUpdateView, content: {
            UpdateView(viewModel: UpdateViewModel(state: .updateMultipleVehicles(vehicles)))
                .interactiveDismissDisabled()
        })
        .sheet(isPresented: $shouldShowAboutSection, content: {
            AboutView()
                .interactiveDismissDisabled()
        })
        .sheet(isPresented: $shouldShowOnboarding, content: {
            OnboardingView()
                .interactiveDismissDisabled()
        })
        .onChange(of: vehicles) { _, newValue in
            UserDataAccess.saveEVRCData(newValue)
        }
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.shouldShowOnboarding = true
                } label: {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    self.shouldShowAboutSection = true
                } label: {
                    HStack {
                        Image(systemName: "info.circle.fill")
                    }
                }
            }
        }
        .onAppear {
            // don't show updates for now
            // shouldShowUpdateView = true
        }
    }
}

#Preview("No Vehicle") {
    VehiclesView(vehicles: .constant([]))
}

#Preview("Vehicle issued") {
    VehiclesView(vehicles: .constant([EVRCDataMock.example1, EVRCDataMock.exampleShared]))
}
