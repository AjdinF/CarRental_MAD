import Foundation
import SwiftData

@Model
final class Car: Identifiable {
    @Attribute var marke: String
    @Attribute var model: String
    @Attribute var kraftstoff: String
    @Attribute var getriebeart: String
    @Attribute var leistung: Int
    @Attribute var kilometerstand: Int
    @Attribute var stundensatz: Double
    @Attribute var istVerfuegbar: Bool
    @Attribute var reserviertVon: String? = nil
    @Attribute var imageData: Data?


    init(marke: String, model: String, kraftstoff: String, getriebeart: String, leistung: Int, kilometerstand: Int, stundensatz: Double, istVerfuegbar: Bool, imageData: Data? = nil) {
        self.marke = marke
        self.model = model
        self.kraftstoff = kraftstoff
        self.getriebeart = getriebeart
        self.leistung = leistung
        self.kilometerstand = kilometerstand
        self.stundensatz = stundensatz
        self.istVerfuegbar = istVerfuegbar
        self.imageData = imageData
    }
}
