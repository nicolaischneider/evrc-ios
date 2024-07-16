import SwiftUI

struct SingleVehicleDataView: View {
    
    let vehicle: EVRCData
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(alignment: .top, spacing: 20) {
                
                VStack(alignment: .leading) {
                    field(type: "single.vehicle.brand", value: vehicle.brand)
                        .padding(.bottom)
                    field(type: "single.vehicle.owner", value: vehicle.vehicleOwnerName)
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    field(type: "single.vehicle.vehicle.type", value: vehicle.vehicleType)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            
            HStack {
                tagView()
                    .padding(.bottom, 10)
            }
            
        }
    }
    
    func field(type: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(type.localized)
                .font(.callout)
                .bold()
            Text(value)
                .font(.callout)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
        }
    }
    
    @ViewBuilder func tagView() -> some View {
        if vehicle.isSharedInstance, let validity = vehicle.validity {
            HStack {
                TagView(
                    text: "single.vehicle.valdiity.from".localized("\(DateManager.convertDateToString(date: validity.validFrom, format: .regularDate))"),
                    type: .red)
                TagView(
                    text: "single.vehicle.valdiity.until".localized("\(DateManager.convertDateToString(date: validity.validUntil, format: .regularDate))"),
                    type: .red)
            }
        } else if !vehicle.sharedInstances.isEmpty {
            TagView(text: "single.vehicle.shared.with".localized("\(vehicle.sharedInstances.count)"), type: .blue)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    List {
        AnyForm(headerAsLicensePlate: "12345") {
            SingleVehicleDataView(vehicle: EVRCDataMock.example1)
        }
        
        AnyForm(headerAsLicensePlate: "12345") {
            SingleVehicleDataView(vehicle: EVRCDataMock.exampleShared)
        }
    }
}
