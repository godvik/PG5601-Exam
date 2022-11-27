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


// Denne funksjonen er hentet fra https://anoop4real.medium.com/swift-generate-color-hash-uicolor-from-string-names-e0aa129fec6a

func generateColorFor(text: String) -> UIColor {
	var hash = 0
	let colorConstant = 131
	let maxSafeValue = Int.max / colorConstant
	for char in text.unicodeScalars {
		if hash > maxSafeValue {
			hash = hash / colorConstant
		}
		hash = Int(char.value) + ((hash << 5) - hash)
	}
	let finalHash = abs(hash) % (256 * 256 * 256);
	let color = UIColor(red: CGFloat((finalHash & 0xFF0000) >> 16) / 255.0, green: CGFloat((finalHash & 0xFF00) >> 8) / 255.0, blue: CGFloat((finalHash & 0xFF)) / 255.0, alpha: 1.0)
	return color
}

func fruitEmoji(fruitName: String) -> String {
	let fruitEmojis = [
		"Apple": "🍎",
		"Avocado": "🥑",
		"GreenApple": "🍏",
		"Blueberry": "🫐",
		"Melon": "🍈",
		"Lemon": "🍋",
		"Tomato": "🍅",
		"Banana": "🍌",
		"Orange": "🍊",
		"Pear": "🍐",
		"Pineapple": "🍍",
		"Strawberry": "🍓",
		"Watermelon": "🍉",
		"Grape": "🍇",
		"Cherry": "🍒",
		"Pomegranate": "🍐",
		"Mango": "🥭",
		"Kiwi": "🥝",]

	if(fruitEmojis[fruitName] != nil) {
		return fruitEmojis[fruitName]!
	} else {
		return "💯"
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

