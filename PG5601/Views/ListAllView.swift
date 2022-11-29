import SwiftUI

struct ListAllView: View {
    @EnvironmentObject var datamodel: DataModel
	@EnvironmentObject var router: Router
	
    var body: some View {
		NavigationStack(path: $router.path) {
            List {
                ForEach(datamodel.Fruits.sorted(by: { $0.id < $1.id })) { fruit in
					NavigationLink(value: fruit) {
						FruitView(fruit)
					}
                }

			}.navigationDestination(for: Fruit.self) { fruit in
				FruitDetailView(fruit)
			}
                    .listStyle(.plain)
                    .task {
						await datamodel.loadData(endpoint: "all")
                    }
                    .navigationTitle("Fruit")
                    .navigationBarTitleDisplayMode(.inline)
        }
		.environmentObject(router)
    }
}

