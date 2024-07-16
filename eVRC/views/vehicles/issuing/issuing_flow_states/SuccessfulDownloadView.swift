import SwiftUI

struct SuccessfulDownloadView: View {
    
    var eVRCData: EVRCData
    var onButtonPress: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .foregroundStyle(.green)
            
            RichText("issuing.success.text".localized, fontBold: .body.bold(), fontRegular: .body)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack {
                HStack {
                    SectionHeader(eVRCData.licensePlateNumber, .numberPlate25)
                        .padding(15)
                    Spacer()
                }
                .background(Color.headerGray)
                
                SingleVehicleDataView(vehicle: eVRCData)
            }
            .background(Color.systemGray)
            .cornerRadius(10)
            .padding(.vertical)
            
            Spacer()
            
            ButtonRegular("general.continue".localized) {
                onButtonPress()
            }
        }
        .padding()
    }
}

#Preview("Main") {
    SuccessfulDownloadView(eVRCData: EVRCDataMock.example2, onButtonPress: {})
}

#Preview("Shared") {
    SuccessfulDownloadView(eVRCData: EVRCDataMock.exampleShared, onButtonPress: {})
}
