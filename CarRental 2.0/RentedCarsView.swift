import SwiftUI
import SwiftData

struct RentedCarsView: View {
    let currentUser: String
    let cars: [Car]

    var body: some View {
        List {
            ForEach(cars.filter { car in
                car.reserviertVon == currentUser
            }) { car in
                NavigationLink(destination: UserCarDetailView(car: car, currentUser: currentUser)) {
                    VStack(alignment: .leading) {
                        Text("\(car.marke) \(car.model)")
                            .font(.headline)
                        Text("Kraftstoff: \(car.kraftstoff), Getriebeart: \(car.getriebeart)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Stundensatz: €\(car.stundensatz, specifier: "%.2f")")
                            .font(.footnote)
                    }
                }
            }
        }
        .navigationTitle("My Rented Cars")
    }
}
