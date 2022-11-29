import SwiftUI

struct DisplayMonthlyIntake: View {
	@EnvironmentObject var router: Router
	var fruitCount: Int
	var fruitName: String

	internal init(fruitCount: Int, fruitName: String) {
		self.fruitCount = fruitCount
		self.fruitName = fruitName
	}

	var body: some View {
		// Viser en tekst hvis brukeren har logget en frukt
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
