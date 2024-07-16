import SwiftUI

struct EVRCUpdateAvailableView: View {
    
    let eVRCs: [EVRCData]
    var onButtonBress: () -> Void
    
    var descriptionText: String {
        if eVRCs.count > 1 {
            return "update.available.descrition.multiple".localized
        } else {
            return "update.available.descrition.single".localized
        }
    }
    
    var body: some View {
        Form {
            AnyForm(headerText: "update.title") {
                VStack(alignment: .center, spacing: 15) {
                    
                    Image(systemName: "square.and.arrow.down.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundStyle(Color.blueDark)
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
                    
                    ButtonRegular("general.continue".localized) {
                        onButtonBress()
                    }
                }
            }
        }
    }
}

#Preview {
    EVRCUpdateAvailableView(eVRCs: [EVRCDataMock.example1 , EVRCDataMock.example2], onButtonBress: {})
}
