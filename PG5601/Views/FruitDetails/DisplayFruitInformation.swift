import SwiftUI

struct DisplayFruitInformation: View {
	@EnvironmentObject var router: Router
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
