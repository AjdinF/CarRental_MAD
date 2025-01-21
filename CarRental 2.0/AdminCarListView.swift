import SwiftUI
import SwiftData


struct AdminCarListView: View {
    @Query var cars: [Car]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(cars) { car in
                        NavigationLink(destination: AdminCarDetailView(car: car)) {
                            VStack(alignment: .leading) {
                                Text("\(car.marke) \(car.model)")
                                    .font(.headline)
                                Text("Kraftstoff: \(car.kraftstoff), Getriebeart: \(car.getriebeart)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteCar)
                }
                .navigationTitle("Admin - Car List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Car") {
                            addCar()
                        }
                    }
                }
            }
        }
    }

    func addCar() {
        let newCar = Car(
            marke: "Neue Marke",
            model: "Neues Model",
            kraftstoff: "Benzin",
            getriebeart: "Manuell",
            leistung: 100,
            kilometerstand: 0,
            stundensatz: 10.0,
            istVerfuegbar: true,
            imageData: nil
        )
        context.insert(newCar)
        try? context.save()
    }

    func deleteCar(at offsets: IndexSet) {
        for index in offsets {
            context.delete(cars[index])
        }
        try? context.save()
    }
}
