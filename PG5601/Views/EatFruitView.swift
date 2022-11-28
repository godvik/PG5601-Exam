import SwiftUI

struct EatFruitView: View {
	@State private var date = Date()
	@State private var fruitAdded = false
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.managedObjectContext) var moc
	var fruit: Fruit

	init(_ fruit: Fruit) {
		self.fruit = fruit
	}
    var body: some View {
		VStack {

			List {
				Section("Categories") {
					FruityView(name: "Family", nutrition: fruit.family)
					FruityView(name: "Order", nutrition: fruit.order)
					FruityView(name: "Genus", nutrition: fruit.genus)
				}
				Section("Nutrition per 100 grams") {
					FruityView(name: "Carbohydrates", nutrition: fruit.nutritions.carbohydrates.formatted(), property: "g")
					FruityView(name: "Protein", nutrition: fruit.nutritions.protein.formatted(), property: "g")
					FruityView(name: "Fat", nutrition: fruit.nutritions.fat.formatted(), property: "g")
					FruityView(name: "Calories", nutrition: fruit.nutritions.calories.formatted(), property: "kcal")
					FruityView(name: "Sugar", nutrition: fruit.nutritions.sugar.formatted(), property: "g")
				}
			}
					.scrollContentBackground(.hidden)


			VStack {
				Text("When did you eat the fruit?").font(.title3).padding()
				HStack{
					Spacer()
					DatePicker(
							"",
							selection: $date,
							displayedComponents: [.date, .hourAndMinute]
						)
					.labelsHidden()
					.datePickerStyle(.compact)
					Spacer()

				}
			}.padding()
			Spacer()
			HStack {
				Button("Cancel",  role: .destructive, action: { self.presentationMode.wrappedValue.dismiss() } )
					.buttonStyle(.bordered)
					Button(action: {eatFruit(); fruitAdded = true}) {
							Label("Log fruit", systemImage: "calendar.badge.plus")
						}
					.buttonStyle(.bordered)

			}

		}.padding()
			.navigationBarTitle(fruit.name)

    }

	func navigateBack() {

	}

	func eatFruit() {
		let newConsumption = Consumption(context: moc)
		newConsumption.id = UUID()
		newConsumption.name = fruit.name
		newConsumption.order = fruit.order
		newConsumption.family = fruit.family
		newConsumption.genus = fruit.genus
		newConsumption.sugar = fruit.nutritions.sugar
		newConsumption.carbohydrates = fruit.nutritions.carbohydrates
		newConsumption.protein = fruit.nutritions.protein
		newConsumption.fat = fruit.nutritions.fat
		newConsumption.calories = Int16(fruit.nutritions.calories)
		newConsumption.date = date
		try? moc.save()

	}
}

struct EatFruitView_Previews: PreviewProvider {
    static var previews: some View {
        EatFruitView(fruit)
    }
}
