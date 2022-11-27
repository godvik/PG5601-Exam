import SwiftUI

struct EatFruitView: View {
	@State private var date = Date()
	@State private var shouldNavigate = false
	@Environment(\.managedObjectContext) var moc
	var fruit: Fruit

	init(_ fruit: Fruit) {
		self.fruit = fruit
	}
    var body: some View {
		VStack {
			Spacer()
			Group{
				FruityView(name: "Name", property: fruit.name)
				FruityView(name: "Family", property: fruit.family)
				FruityView(name: "Order", property: fruit.order)
				FruityView(name: "Genus", property: fruit.genus)
				FruityView(name: "Carbohydrates", property: String(format: "%.1f", fruit.nutritions.carbohydrates))
				FruityView(name: "Protein", property: String(format: "%.1f", fruit.nutritions.protein))
				FruityView(name: "Fat", property: String(format: "%.1f", fruit.nutritions.fat))
				FruityView(name: "Calories", property: String(fruit.nutritions.calories))
				FruityView(name: "Sugar", property: String(format: "%.1f", fruit.nutritions.sugar))
			}

			HStack{
				DatePicker(
						"Time of consumption",
						selection: $date,
						displayedComponents: [.date, .hourAndMinute]
					)
				.datePickerStyle(.compact)
				.padding()
			}
			Spacer()
			HStack {
				Button("Cancel",  role: .destructive, action: navigateBack )
					.buttonStyle(.bordered)
				Button("Log fruit", action: eatFruit)
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
		shouldNavigate = true

	}
}

struct EatFruitView_Previews: PreviewProvider {
    static var previews: some View {
        EatFruitView(fruit)
    }
}
