import SwiftUI

struct ListGroupView: View {
	@EnvironmentObject var datamodel: DataModel
    var name: String
	var groupType: String
	init(_ text: String, _ groupType: String) {
        self.name = text
		self.groupType = groupType
    }

    var body: some View {
        NavigationStack {
            List {
				ForEach(datamodel.Fruits) {
                    fruit in
					FruitView(fruit)
                }
			}.task {

				await datamodel.loadData(endpoint: "\(groupType)/\(name)")
			}
                    .listStyle(.plain)
                    .navigationTitle(name)
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ListGroupView(text, "").environmentObject(DataModel())
    }
}
