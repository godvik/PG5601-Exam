import SwiftUI

struct JsonView: View {
	@EnvironmentObject var datamodel: DataModel
    var body: some View {
		NavigationView {
			List {
				ForEach(datamodel.Fruits) {
					fruit in FruitView(fruit)
				}
			}
			.listStyle(.plain)
			.task {
				await datamodel.loadData()
			}
			.navigationTitle("Fruit")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct JsonView_Previews: PreviewProvider {
    static var previews: some View {
		JsonView().environmentObject(DataModel())
    }
}
