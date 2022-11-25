import Foundation
import SwiftUI

let baseUrl = "https://fruityvice.com/api/fruit/"

@MainActor final class DataModel: ObservableObject {
    @Published var Fruits: [Fruit] = []

	func loadData(endpoint: String ) async {
        guard let apiUrl = URL(string: baseUrl + endpoint) else {
            fatalError("No response from server:\(baseUrl+endpoint)")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)
            Fruits = try JSONDecoder().decode([Fruit].self, from: data)
        } catch {
            fatalError("Cannot decode content from \(baseUrl+endpoint)")
        }
    }

}


struct Fruit: Decodable, Identifiable {
    let id: Int
    let order, genus, name, family: String
    let nutritions: Nutritions
}


struct Nutritions: Codable {
    let sugar, protein, fat, carbohydrates: Double
    let calories: Int
}

let nutritions = Nutritions(sugar: 0, protein: 0, fat: 0, carbohydrates: 0, calories: 0)
let fruit = Fruit(id: 0, order: "Order", genus: "Genus", name: "Name", family: "Family", nutritions: nutritions)
let text = "placeholder"

