import SwiftUI
import SwiftData

struct UserCarListView: View {
    let currentUser: String
    @Query var cars: [Car]

    var body: some View {
        NavigationView {
            List {
                ForEach(cars.filter { car in
                    car.istVerfuegbar
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
            .navigationTitle("User - Car List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RentedCarsView(currentUser: currentUser, cars: cars)) {
                        Text("My Rented Cars")
                    }
                }
            }
        }
    }
}
