import SwiftUI
import SwiftData
import PhotosUI

struct AdminCarDetailView: View {
    @Bindable var car: Car
    @Environment(\.modelContext) private var context
    
    @State private var isEditing = false
    
    @State private var showImagePicker = false
    @State private var selectedItem: PhotosPickerItem?

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
                .onTapGesture {
                    if isEditing {
                        showImagePicker = true
                    }
                }

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Marke:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Marke", text: $car.marke)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Model:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Model", text: $car.model)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Kraftstoff:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Kraftstoff", text: $car.kraftstoff)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Getriebeart:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Getriebeart", text: $car.getriebeart)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Leistung (PS):")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Leistung (PS)", value: $car.leistung, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Kilometerstand:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Kilometerstand", value: $car.kilometerstand, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Stundensatz (€):")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        TextField("Stundensatz (€)", value: $car.stundensatz, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(!isEditing)
                    }

                    HStack {
                        Text("Ist verfügbar:")
                            .font(.headline)
                            .frame(width: 120, alignment: .leading)
                        Toggle("", isOn: $car.istVerfuegbar)
                            .disabled(!isEditing)
                    }
                }
                .padding()

                Spacer()

                Button(isEditing ? "Änderungen speichern" : "Bearbeiten") {
                    if isEditing {
                        try? context.save()
                    }
                    isEditing.toggle()
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Car Details")
        .navigationBarTitleDisplayMode(.inline)
        
        .photosPicker(
            isPresented: $showImagePicker,
            selection: $selectedItem,
            matching: .images
        )
        .onChange(of: selectedItem) { newItem in
            Task {
                if let newItem = newItem {
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        car.imageData = data
                    }
                }
            }
        }
    }
}
