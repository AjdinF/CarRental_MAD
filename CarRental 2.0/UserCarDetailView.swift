import SwiftUI
import SwiftData
import PhotosUI

struct UserCarDetailView: View {
    @Bindable var car: Car
    @Environment(\.modelContext) private var context
    
    let currentUser: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Group {
                    if let imageData = car.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Marke:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Marke", text: .constant(car.marke))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Model:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Model", text: .constant(car.model))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Kraftstoff:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Kraftstoff", text: .constant(car.kraftstoff))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Getriebeart:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Getriebeart", text: .constant(car.getriebeart))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Leistung (PS):")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Leistung (PS)", value: .constant(car.leistung), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Kilometerstand:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Kilometerstand", value: .constant(car.kilometerstand), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Stundensatz (€):")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Stundensatz (€)", value: .constant(car.stundensatz), formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }

                    HStack {
                        Text("Ist verfügbar:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("", text: .constant(car.istVerfuegbar ? "Ja" : "Nein"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                            .foregroundColor(car.istVerfuegbar ? .green : .red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()

                if car.istVerfuegbar {
                    Button("Mieten") {
                        rentCar()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } else if car.reserviertVon == currentUser {
                    Button("Zurückgeben") {
                        returnCar()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } else {
                    Text("Car is currently rented by another user.")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle("Car Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func rentCar() {
        car.istVerfuegbar = false
        car.reserviertVon = currentUser
        try? context.save()
    }

    func returnCar() {
        car.istVerfuegbar = true
        car.reserviertVon = nil
        try? context.save()
    }
}
