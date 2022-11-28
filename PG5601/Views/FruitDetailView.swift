import SwiftUI

struct FruitDetailView: View {
    @State private var sugar = ""
	@State private var viewID = 0
    var fruit: Fruit
    @FetchRequest var fetchRequest: FetchedResults<Consumption>
    var currentDate: Date
    var lastThirtyDays: Date

    init(_ fruit: Fruit) {
        self.fruit = fruit
        _fetchRequest = FetchRequest<Consumption>(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", fruit.name))
        currentDate = Date()
        lastThirtyDays = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
    }

    var body: some View {
        ZStack {
			AnimatedBackgroundView(fruit).zIndex(1)
			AnimatedFruit(fruitCount: fetchRequest.filter({ $0.date! > lastThirtyDays }).count, fruitName: fruit.name).zIndex(3).id(viewID)
            VStack {
                ExtractedView(fruitCount: fetchRequest.filter({ $0.date! > lastThirtyDays }).count, fruitName: fruit.name)
				
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

					Text(sugar).task({
						if (fruit.nutritions.sugar > 10) {
							sugar = "Warning! This fruit contains high amounts of sugar!"
						}
					})
                }
                        .scrollContentBackground(.hidden)

				HStack {
					Button(action: {viewID += 1}) {
						Label("Replay animation", systemImage: "repeat")
					}.buttonStyle(.bordered)
					EatFruitButton(fruit)
				}
			}.zIndex(2)
                    .padding()
                    .navigationTitle(fruit.name)
                    .navigationBarTitleDisplayMode(.inline)
		}.task {
			viewID += 1
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
        NavigationLink(destination: EatFruitView(fruit)) {
            HStack {
                Image(systemName: "calendar.badge.plus")
                Text("Eat Fruit")
            }
        }
                .buttonStyle(.bordered)
    }

}

struct FruityView: View {
    var name: String
    var nutrition: String
    var property: String?
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(nutrition + (property ?? ""))
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

struct AnimatedFruit: View {
    @State private var animate = false
    var fruitCount: Int
    var fruitName: String

    internal init(fruitCount: Int, fruitName: String) {
        self.fruitCount = fruitCount
        self.fruitName = fruitName
    }
    var body: some View {

        ForEach(0..<fruitCount, id: \.self) { _ in
            Text(fruitEmoji(fruitName: fruitName))
				.font(.system(size: animate ? 3.6 : 72.0))
                    .rotationEffect(.degrees(animate ? 1080 : 0))
                    .offset(x: Double.random(in: -200..<200), y: animate ? 500 : Double.random(in: -900 ... -400))
                    .task({
                        withAnimation(Animation.linear(duration: 10)) {
                            animate.toggle()
                        }
                    })
        }
	}
}

struct ExtractedView: View {
    var fruitCount: Int
    var fruitName: String

    internal init(fruitCount: Int, fruitName: String) {
        self.fruitCount = fruitCount
        self.fruitName = fruitName
    }

    var body: some View {
        HStack {
            Spacer()
            if (fruitCount != 0) {
				if (fruitCount == 1) {
					Text("You ate \(fruitCount) \(fruitName) in the last month")
				} else {
					Text("You ate \(fruitCount) \(fruitName)s in the last month")
				}

            }
            Spacer()
        }
    }
}
