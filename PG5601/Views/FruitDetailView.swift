import SwiftUI

struct FruitDetailView: View {

	var fruit: Fruit
    init(_ fruit: Fruit) {
        self.fruit = fruit
    }

    var body: some View {
        ZStack {
			AnimatedBackgroundView(fruit)
            VStack {
                Divider()
                Spacer()
            }
			FruitInformationView(fruit)
			Button("Eat fruit", action: addFruit)
				.buttonStyle(.bordered)
        }
    }

	func addFruit() {

	}
}


struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailView(fruit)
    }
}

struct FruitInformationView: View {
	var fruit: Fruit
	init(_ fruit: Fruit) {
		self.fruit = fruit
	}
	@State private var sugar = ""
	var body: some View {
		VStack {
			Group {
				HStack {
					Text("Name")
					Spacer()
					Text(fruit.name)
				}
				HStack {
					Text("Family")
					Spacer()
					Text(fruit.family)
				}
				HStack {
					Text("Order")
					Spacer()
					Text(fruit.order)
				}
				HStack {
					Text("Genus")
					Spacer()
					Text(fruit.genus)
				}
				HStack {
					Text("Carbohydrates")
					Spacer()
					Text("\(fruit.nutritions.carbohydrates)")
				}
				HStack {
					Text("Protein")
					Spacer()
					Text("\(fruit.nutritions.protein)")
				}
				HStack {
					Text("Fat")
					Spacer()
					Text("\(fruit.nutritions.fat)")
				}
				HStack {
					Text("Calories")
					Spacer()
					Text("\(fruit.nutritions.calories)")
				}
				HStack {
					Text("Sugar")
					Spacer()
					Text("\(fruit.nutritions.sugar)")
				}

			}
			Spacer()
			HStack {
				Text(sugar).task({
					if (fruit.nutritions.sugar > 10) {
						sugar = "Warning! This fruit contains high amounts of sugar!"
					}
				})
			}
			Spacer()
		}
		.padding()
		.navigationTitle(fruit.name)
		.navigationBarTitleDisplayMode(.inline)
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
			.ignoresSafeArea()
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
