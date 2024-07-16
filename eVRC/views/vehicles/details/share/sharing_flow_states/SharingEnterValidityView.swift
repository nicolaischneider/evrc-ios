//
//  SharingEnterValidityView.swift
//  eVRC
//
//  Created by Nicolai Schneider on 09.05.24.
//

import SwiftUI

struct SharingEnterValidityView: View {
    
    @StateObject var viewModel: SharingViewModel
    
    @State var shouldShowAlertWithValidity = false
    @State private var isToggledForUnlimited = false
    @State var selectedDateStart: Date = Date()
    @State var selectedDateEnd: Date = Date()
    
    var body: some View {
        Form {
            AnyForm(headerText: "shared.validity.header".localized) {
                VStack(alignment: .center) {
                    
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.blueDark)
                        .padding()
                    
                    RichText("sharing.validity.access.duration".localized, fontBold: .body.bold(), fontRegular: .body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    InformationBox(
                        icon: Image(systemName: "info.circle.fill"),
                        text: "sharing.validity.revoke.info".localized,
                        background: .blueLight,
                        iconColor: .blueDark)
                    .padding(.top)
                    
                    Toggle(isOn: $isToggledForUnlimited) {
                        Text("sharing.validity.unlimited.access")
                            .font(.callout)
                            .bold()
                    }
                    .padding()
                    
                    if !isToggledForUnlimited {
                        HStack {
                            Text("general.validfrom")
                            DatePicker("", selection: $selectedDateStart, displayedComponents: .date)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("general.validuntil")
                            DatePicker("", selection: $selectedDateEnd, displayedComponents: .date)
                        }
                        .padding(.horizontal)
                        
                        if buttonDisabled {
                            Text("sharing.validity.minimum.validity".localized)
                                .font(.caption2)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.red)
                                .padding()
                        }
                        
                    }
                    
                    ButtonRegular("general.continue".localized, disabled: buttonDisabled) {
                        shouldShowAlertWithValidity = true
                    }
                }
            }
            .alert(isPresented: $shouldShowAlertWithValidity, content: {
                Alert(
                    title: Text("issuing.enternumber.alert.title".localized),
                    message: Text(alertDescription),
                    primaryButton: .default(Text("issuing.enternumber.alert.correct"), action: {
                        viewModel.enteredValidity(
                            isToggledForUnlimited ?
                            nil 
                            : Validity(validFrom: selectedDateStart, validUntil: selectedDateEnd))
                    }),
                    secondaryButton: .cancel({
                        shouldShowAlertWithValidity = false
                    }))
            })
        }
    }
    
    var buttonDisabled: Bool {
        if isToggledForUnlimited {
            return false
        } else {
            return DateManager.daysBetweenDates(selectedDateStart, selectedDateEnd) <= 0
        }
    }
    
    var alertDescription: String {
        if isToggledForUnlimited {
            return "sharing.validity.alert.message.unlimited".localized
        } else {
            let startDateAsString = DateManager.convertDateToString(date: selectedDateStart, format: .regularDate)
            let endDateAsString = DateManager.convertDateToString(date: selectedDateEnd, format: .regularDate)
            let daysInBetween = DateManager.daysBetweenDates(selectedDateStart, selectedDateEnd)
            return "sharing.validity.alert.message.limited".localized(startDateAsString, endDateAsString, String(daysInBetween))
        }
    }
}

#Preview {
    SharingEnterValidityView(viewModel: SharingViewModel(vehicle: .constant(EVRCDataMock.example1)))
}
