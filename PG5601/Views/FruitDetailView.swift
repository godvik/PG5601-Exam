import SwiftUI

struct FruitDetailView: View {

    var fruit: Fruit
    @State private var switchColor = Color(.white)
	@State private var sugar = ""

    init(_ fruit: Fruit) {
        self.fruit = fruit
    }

    var body: some View {
        ZStack {
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
			VStack{
				Divider()
				Spacer()
			}

            VStack {
				Group{
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
				HStack{
					Text(sugar).task({
						if(fruit.nutritions.sugar > 10) {
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
}


struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailView(fruit)
    }
}
