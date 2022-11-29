import SwiftUI

struct AnimatedBackgroundView: View {
	var fruit: Fruit

	init(_ fruit: Fruit) {
		self.fruit = fruit
	}

	@State private var switchColor = Color(.white)
	var body: some View {
		// Pulserer bakgrunnnen fra rød til hvit hvis sukkernivå er over 10
		Rectangle()
				.foregroundColor(switchColor)
				.task {
					if (fruit.nutritions.sugar > 10) {
						withAnimation(Animation.easeInOut(duration: 4).repeatForever()) {
							switchColor = Color(.white)
						}
						withAnimation(Animation.easeInOut(duration: 4).repeatForever()) {
							switchColor = Color(.red)
						}
					}
				}
	}
}
