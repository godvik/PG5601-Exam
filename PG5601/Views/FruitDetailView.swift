import SwiftUI

struct FruitDetailView: View {

    @State private var sugar = ""
    var fruit: Fruit
	@FetchRequest var fetchRequest: FetchedResults<Consumption>

    init(_ fruit: Fruit) {
        self.fruit = fruit
		_fetchRequest = FetchRequest<Consumption>(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", fruit.name))
    }


    var body: some View {
        ZStack {
            AnimatedBackgroundView(fruit)
            VStack {
                Divider()
                Spacer()
            }
            VStack {
				Spacer()
                Text("You ate \(fetchRequest.filter({ $0.date! > Date().addingTimeInterval(-60*60*24*30) }).count) \(fruit.name)s in the last 30 days")
				Spacer()
                Group {
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
				Spacer()
				HStack {
					Text(sugar).task({
						if (fruit.nutritions.sugar > 10) {
							sugar = "Warning! This fruit contains high amounts of sugar!"
						}
					})
				}

					EatFruitButton(fruit)
            }
			.padding()
			.navigationTitle(fruit.name)
			.navigationBarTitleDisplayMode(.inline)
        }
    }




}


struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailView(fruit)
    }
}

struct EatFruitButton: View {
	var fruit: Fruit

	init(_ fruit: Fruit) {
		self.fruit = fruit
	}
	var body: some View {
		Spacer()
		NavigationLink("Eat Fruit", destination: EatFruitView(fruit))
			.buttonStyle(.bordered)
	}

}

struct FruityView: View {
    var name: String
    var property: String
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(property)
        }
    }
}

struct AnimatedBackgroundView: View {
    var fruit: Fruit

    init(_ fruit: Fruit) {
        self.fruit = fruit
    }

    @State private var switchColor = Color(.white)
    var body: some View {
        Rectangle()
                .foregroundColor(switchColor)
                .task {
                    if (fruit.nutritions.sugar > 10) {
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
                            switchColor = Color(.white)
                        }
                        withAnimation(Animation.easeInOut(duration: 4).repeatForever()) {
                            switchColor = Color(.red)
                        }
                    }
                }
    }
}
