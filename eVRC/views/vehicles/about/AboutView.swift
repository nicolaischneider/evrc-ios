//
//  AboutView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 20.05.24.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    AcknowledgementsView()
                } label: {
                    link(systmeImageName: "heart.circle.fill", text: "Acknowledgements")
                        .padding()
                }
                
                Spacer()
                
                Text(version)
                    .font(.caption)
                    .padding()
            }
            .navigationTitle("about.title")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("general.quit".localized) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func link(systmeImageName: String, text: String) -> some View {
        HStack {
            Image(systemName: systmeImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundStyle(.pink)
            Spacer()
            Text(text)
                .font(.body)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
    }
    
    var version: String {
        guard let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "???"
        }
        return "eVRC App v\(versionString)"
    }
}

#Preview {
    AboutView()
}
