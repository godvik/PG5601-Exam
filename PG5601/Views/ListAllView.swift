import SwiftUI

struct ListAllView: View {
    @EnvironmentObject var datamodel: DataModel
    var body: some View {
        NavigationView {
            List {
                ForEach(datamodel.Fruits.sorted(by: { $0.id < $1.id })) {
                    fruit in
                    FruitView(fruit)
                }
            }
                    .listStyle(.plain)
                    .task {
                        await datamodel.loadData(endpoint: "all")
                    }
                    .navigationTitle("Fruit")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListAllView_Previews: PreviewProvider {
    static var previews: some View {
        ListAllView().environmentObject(DataModel())
    }
}
