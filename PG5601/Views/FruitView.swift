import SwiftUI

struct FruitView: View {
    var fruit: Fruit

    init(_ fruit: Fruit) {
        self.fruit = fruit
    }

    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: FruitDetailView(fruit)) {
                HStack {
                    Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                            .padding()
                    Text(fruit.name)

                }
            }
        }
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView(fruit)
    }
}

