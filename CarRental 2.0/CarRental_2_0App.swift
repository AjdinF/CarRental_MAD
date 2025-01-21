import SwiftUI
import SwiftData

@main
struct CarRental_2_0App: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Car.self)
    }
}
