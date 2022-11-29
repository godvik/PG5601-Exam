import SwiftUI

struct AnimatedFruit: View {
	@State private var animate = false
	var fruitCount: Int
	var fruitName: String

	internal init(fruitCount: Int, fruitName: String) {
		self.fruitCount = fruitCount
		self.fruitName = fruitName
	}
	var body: some View {
		// Animerer fallende frukt emojier basert på antall frukter logget. En sjelden gang blir emojiene "fast" før de faller inn i viewet. Løses ved at man logger en ny frukt av en eller annen grunn...

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
