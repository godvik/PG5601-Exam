import SwiftUI

struct FruitDetailView: View {

    var fruit: Fruit
//	@State private var showAnimation = false

    init(_ fruit: Fruit) {
        self.fruit = fruit
    }

    var body: some View {
        VStack {
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
                .padding()
                .navigationTitle(fruit.name)
				.background(setBackgroundColor())

    }
	func setBackgroundColor() -> Color {
		if(fruit.nutritions.sugar > 10) {
			return Color(.red)
		}
		return Color(.white)
	}
}


struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
		FruitDetailView(fruit)
    }
}
