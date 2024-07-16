//
//  ContentView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 26.04.24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var showOnboarding = false
    
    @State private var vehicles: [EVRCData]
        
    init() {
        _vehicles = State(initialValue: UserDataAccess.loadEVRCData())
        
        // Uncomment to use mock data
        //_vehicles = State(initialValue: [EVRCDataMock.example1, EVRCDataMock.example3])
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                VehiclesView(vehicles: $vehicles)
            }
            .tabItem {
                Label("vehicles.navigation.title".localized, systemImage: "car.fill")
            }
            .tag(0)
            
            NavigationStack {
                VerificationView(vehicles: $vehicles)
            }
            .tabItem {
                Label("Verification", systemImage: "qrcode")
            }
            .tag(1)
        }
        .onAppear {
            if !hasSeenOnboarding {
                showOnboarding = true
                hasSeenOnboarding = true
            }
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView()
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    ContentView()
}
