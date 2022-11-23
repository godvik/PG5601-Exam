import Foundation
import SwiftUI

let url = "https://fruityvice.com/api/fruit/all"

@MainActor final class DataModel: ObservableObject {
    @Published var Fruits: [Fruit] = []
    @Published var Families: [Fruit] = []
    @Published var Genus: [Fruit] = []
    @Published var Order: [Fruit] = []


    func loadData() async {
        guard let apiUrl = URL(string: url) else {
            fatalError("No response from server:\n\n\(url)")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)
            Fruits = try JSONDecoder().decode([Fruit].self, from: data)
        } catch {
            fatalError("Cannot decode content from \n\n\(url)")
        }
    }


    func loadFamiliesData(family: String) async {
        guard let apiUrl = URL(string: "https://fruityvice.com/api/fruit/family/" + family) else {
            fatalError("No response from server: https://fruityvice.com/api/fruit/family/" + family)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)
            Families = try JSONDecoder().decode([Fruit].self, from: data)
        } catch {
            fatalError("Cannot decode content from https://fruityvice.com/api/fruit/family/" + family)
        }
    }

    func loadGenusData(genus: String) async {
        guard let apiUrl = URL(string: "https://fruityvice.com/api/fruit/genus/" + genus) else {
            fatalError("No response from server: https://fruityvice.com/api/fruit/genus/" + genus)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)
            Genus = try JSONDecoder().decode([Fruit].self, from: data)
        } catch {
            fatalError("Cannot decode content from https://fruityvice.com/api/fruit/genus/" + genus)
        }
    }

    func loadOrderData(order: String) async {
        guard let apiUrl = URL(string: "https://fruityvice.com/api/fruit/order/" + order) else {
            fatalError("No response from server: https://fruityvice.com/api/fruit/order/" + order)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: apiUrl)
            Order = try JSONDecoder().decode([Fruit].self, from: data)
        } catch {
            fatalError("Cannot decode content from https://fruityvice.com/api/fruit/order/" + order)
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

