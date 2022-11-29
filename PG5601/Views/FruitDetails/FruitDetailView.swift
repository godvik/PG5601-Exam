import SwiftUI

struct FruitDetailView: View {
	@EnvironmentObject var router: Router
    @State private var sugar = ""
	@State private var viewID = 0
    @FetchRequest var fetchRequest: FetchedResults<Consumption>
	var fruit: Fruit
    var currentDate: Date
    var lastThirtyDays: Date
	var logFruit: Fruit

    init(_ fruit: Fruit) {
        self.fruit = fruit
        _fetchRequest = FetchRequest<Consumption>(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", fruit.name))
        currentDate = Date()
        lastThirtyDays = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
		self.logFruit = fruit
    }


    var body: some View {
			ZStack {
					AnimatedBackgroundView(fruit).zIndex(1)
					AnimatedFruit(fruitCount: fetchRequest.filter({ $0.date! > lastThirtyDays }).count, fruitName: fruit.name).zIndex(3).id(viewID)
					VStack {
						DisplayMonthlyIntake(fruitCount: fetchRequest.filter({ $0.date! > lastThirtyDays }).count, fruitName: fruit.name)
						List {
							FruitDetails(fruit: fruit)
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
						}.environmentObject(router)
					}.zIndex(2)
							.padding()
							.navigationTitle(fruit.name)
							.navigationBarTitleDisplayMode(.inline)

				}.task {
					viewID += 1
			}

    }
	
}



struct EatFruitButton: View {
	@EnvironmentObject var router: Router
    var fruit: Fruit

    init(_ fruit: Fruit) {
        self.fruit = fruit

    }

    var body: some View {
            HStack {
				NavigationLink(destination: EatFruitView(fruit)) {
                Image(systemName: "calendar.badge.plus")
                Text("Eat Fruit")
            }.buttonStyle(.bordered)
		}


    }
}



