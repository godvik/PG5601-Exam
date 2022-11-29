import SwiftUI
import AlertToast

struct EatFruitView: View {
	@State private var date = Date()
	@EnvironmentObject var router: Router
	@State private var showToast = false
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.managedObjectContext) var moc
	var fruit: Fruit

	init(_ fruit: Fruit) {
		self.fruit = fruit
	}
	
    var body: some View {
			VStack {
				List {
					FruitDetails(fruit: fruit)
				}
						.scrollContentBackground(.hidden)
				LogTime(date: $date)
				Spacer()
				HStack {
					Button("Cancel",  role: .destructive, action: { presentationMode.wrappedValue.dismiss() } )
						.buttonStyle(.bordered)
						Button(action: eatFruit) {
								Label("Log fruit", systemImage: "calendar.badge.plus")
							}
						.buttonStyle(.bordered)

				}
			}.padding()
			.navigationBarTitle(fruit.name)
			.toast(isPresenting: $showToast){
				AlertToast(type: .complete(Color.green), title: "Fruit logged!")
				// Har tatt i bruk en ekstern pakke kalt AlertToast for å vise en fin bekreftelse
			}
    }

	func eatFruit() {
		let newConsumption = Consumption(context: moc)
		newConsumption.id = UUID()
		newConsumption.name = fruit.name
		newConsumption.order = fruit.order
		newConsumption.family = fruit.family
		newConsumption.genus = fruit.genus
		newConsumption.sugar = fruit.nutritions.sugar
		newConsumption.carbohydrates = fruit.nutritions.carbohydrates
		newConsumption.protein = fruit.nutritions.protein
		newConsumption.fat = fruit.nutritions.fat
		newConsumption.calories = Int16(fruit.nutritions.calories)
		newConsumption.date = date
		try? moc.save()

		// Vis bekreftelsestoast som varer i 2sek. Vent derfor 2sek før man popper tilbake til rootView
		showToast.toggle()
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			if(router.path.count >= 1) {
				router.path.removeLast(router.path.count)
			} else if (router.categoryPath.count >= 1) {
				router.categoryPath.removeLast(router.categoryPath.count)
			}
		}
	}
}


struct LogTime: View {
	@Binding var date: Date
	var body: some View {
		VStack {
			Text("When did you eat the fruit?").font(.title3).padding()
			HStack{
				Spacer()
				DatePicker(
					"",
					selection: $date,
					displayedComponents: [.date, .hourAndMinute]
				)
				.labelsHidden()
				.datePickerStyle(.compact)
				Spacer()
			}
		}.padding()
	}
}
