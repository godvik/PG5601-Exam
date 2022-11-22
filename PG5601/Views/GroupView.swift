import SwiftUI

struct GroupView: View {
	@EnvironmentObject var datamodel: DataModel
	@State private var segment = 0
    var body: some View {
		NavigationView{
			VStack {
				Picker("", selection: $segment) {
					Text("Family").tag(0)
					Text("Genus").tag(1)
					Text("Order").tag(2)
				}
				.pickerStyle(.segmented)
				.navigationTitle("Group")
				.navigationBarTitleDisplayMode(.inline)
				Spacer()
				List {
					
					switch segment {
					case 0:
						ForEach(datamodel.Fruits) {
							fruit in
							HStack{
								Text(fruit.family)
							}
						}

					case 1:
						ForEach(datamodel.Fruits) {
							fruit in FruitView(fruit)
						}
					case 2:
						ForEach(datamodel.Fruits) {
							fruit in FruitView(fruit)
						}
					default:
						ForEach(datamodel.Fruits) {
							fruit in FruitView(fruit)
						}
					}




				}.task {
					await datamodel.loadData()
				}
			}



		}
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
		GroupView().environmentObject(DataModel())
    }
}
