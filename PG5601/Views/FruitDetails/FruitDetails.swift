import SwiftUI

struct FruitDetails: View {
	var fruit: Fruit

	var body: some View {
		Section("Categories") {
			DisplayFruitInformation(name: "Family", nutrition: fruit.family)
			DisplayFruitInformation(name: "Order", nutrition: fruit.order)
			DisplayFruitInformation(name: "Genus", nutrition: fruit.genus)
		}
		Section("Nutrition per 100 grams") {
			DisplayFruitInformation(name: "Carbohydrates", nutrition: fruit.nutritions.carbohydrates.formatted(), property: "g")
			DisplayFruitInformation(name: "Protein", nutrition: fruit.nutritions.protein.formatted(), property: "g")
			DisplayFruitInformation(name: "Fat", nutrition: fruit.nutritions.fat.formatted(), property: "g")
			DisplayFruitInformation(name: "Calories", nutrition: fruit.nutritions.calories.formatted(), property: "kcal")
			DisplayFruitInformation(name: "Sugar", nutrition: fruit.nutritions.sugar.formatted(), property: "g")
		}
	}
}
