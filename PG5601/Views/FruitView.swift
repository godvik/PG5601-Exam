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
							.foregroundColor(.init(generateColorFor(text: fruit.family)))
                            .padding()
                    Text(fruit.name)

                }
            }
        }
    }

	// Denne funksjonen er hentet fra https://anoop4real.medium.com/swift-generate-color-hash-uicolor-from-string-names-e0aa129fec6a

	func generateColorFor(text: String) -> UIColor{
		var hash = 0
		let colorConstant = 131
		let maxSafeValue = Int.max / colorConstant
		for char in text.unicodeScalars{
			if hash > maxSafeValue {
				hash = hash / colorConstant
			}
			hash = Int(char.value) + ((hash << 5) - hash)
		}
		let finalHash = abs(hash) % (256*256*256);
		let color = UIColor(red: CGFloat((finalHash & 0xFF0000) >> 16) / 255.0, green: CGFloat((finalHash & 0xFF00) >> 8) / 255.0, blue: CGFloat((finalHash & 0xFF)) / 255.0, alpha: 1.0)
		return color
	}
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView(fruit)
    }
}

