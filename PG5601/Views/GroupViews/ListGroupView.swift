import SwiftUI

struct ListGroupView: View {
	@EnvironmentObject var datamodel: DataModel
	@EnvironmentObject var router: Router
    var name: String
	var groupType: String
	init(_ text: String, _ groupType: String) {
        self.name = text
		self.groupType = groupType
    }


    var body: some View {
		NavigationStack(path: $router.path) {
			List{
					ForEach(datamodel.Fruits) { fruit in
						NavigationLink(value: fruit){
							FruitView(fruit)
						}

					}
				}
				.navigationDestination(for: Fruit.self) { fruit in
					FruitDetailView(fruit)
				}
				.task {
					await datamodel.loadData(endpoint: "\(groupType)/\(name)")
				}
						.listStyle(.plain)
						.navigationTitle(name)
					.navigationBarTitleDisplayMode(.inline)
		}
    }
}


