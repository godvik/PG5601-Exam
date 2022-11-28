import SwiftUI
import Foundation
struct LogView: View {
	@FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Consumption.date, ascending: false)]) var consumedFruits: FetchedResults<Consumption>
	@State private var dates: [String] = []
	@State private var shouldUpdate = false



	@Environment(\.managedObjectContext) var moc

	func removeFruit(at offsets: IndexSet) {
		for index in offsets {
			let fruit = consumedFruits[index]
				moc.delete(fruit)
		}
		do {
			try moc.save()
		} catch {
			print(error.localizedDescription)
		}
	}

	func refreshView() {
		for date in dates {
			if(consumedFruits.filter({ $0.date?.formatted(.dateTime.day().month(.wide).year()) == date }).count == 0) {
				dates.removeAll(where: { $0 == date })

			}
		}
	}


    var body: some View {
		VStack{
			VStack {
				if(!dates.isEmpty){
					List(dates, id: \.self) { date in
							Section(header: Text(date)) {
								ForEach(consumedFruits.filter({ $0.date?.formatted(.dateTime.day().month(.wide).year()) == date })) { fruit in
									Text(fruit.name ?? "Unknown")
								}
										.onDelete{
											removeFruit(at: $0)
											 refreshView()
										}
								VStack{
											HStack {
												Spacer()
												Text("Total").font(.title)
												Spacer()
											}
											HStack {
												Text("Calories")
												Spacer()
												Text("\(consumedFruits.filter({ $0.date?.formatted(.dateTime.day().month(.wide).year()) == date }).reduce(0, { $0 + ($1.calories ) }).formatted())kcal")
											}

											HStack {
												Text("Carbohydrates")
												Spacer()
												Text("\(consumedFruits.filter({ $0.date?.formatted(.dateTime.day().month(.wide).year()) == date }).reduce(0, { $0 + ($1.carbohydrates ) }).formatted())g")
											}

											HStack {
												Text("Protein")
												Spacer()
												Text("\(consumedFruits.filter({ $0.date?.formatted(.dateTime.day().month(.wide).year()) == date }).reduce(0, { $0 + ($1.protein ) }).formatted())g")
											}
											HStack {
												Text("Sugar")
												Spacer()
												Text("\(consumedFruits.filter({ $0.date?.formatted(.dateTime.day().month(.wide).year()) == date }).reduce(0, { $0 + ($1.sugar ) }).formatted())g")
											}
										}
							}
						}
				} else {
					Text("You haven't logged any fruit yet")
				}
			}
			}
			.task {
				separateDates()
			}
	}
	func separateDates() {
		for fruit in consumedFruits {
			if(!dates.contains((fruit.date?.formatted(.dateTime
				.day().month(.wide).year()))!)) {
				dates.append((fruit.date?.formatted(.dateTime
					.day().month(.wide).year()))!)
			}
		}
	}




}





struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
