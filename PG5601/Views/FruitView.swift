import SwiftUI

struct FruitView: View {
	@EnvironmentObject var router: Router
    var fruit: Fruit

    init(_ fruit: Fruit) {
        self.fruit = fruit
    }

    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.init(generateColorFor(text: fruit.family)))
                            .padding()
                    Text(fruit.name)
                }
        }
    }
}
