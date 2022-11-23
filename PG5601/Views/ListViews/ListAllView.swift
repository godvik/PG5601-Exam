import SwiftUI

struct ListAllView: View {
    @EnvironmentObject var datamodel: DataModel
    var body: some View {
        NavigationView {
            List {
                ForEach(datamodel.Fruits) {
                    fruit in
                    FruitView(fruit)
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

struct ListAllView_Previews: PreviewProvider {
    static var previews: some View {
        ListAllView().environmentObject(DataModel())
    }
}
