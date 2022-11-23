import SwiftUI

struct ListGenusView: View {

    var genusName: String

    init(_ text: String) {
        self.genusName = text
    }

    @EnvironmentObject var datamodel: DataModel
    var body: some View {
        NavigationView {
            List {
                ForEach(datamodel.Genus) {
                    fruit in
                    FruitView(fruit)
                }
            }
                    .listStyle(.plain)
                    .task {
                        await datamodel.loadGenusData(genus: genusName)
                    }
                    .navigationTitle(genusName)
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListGenusView_Previews: PreviewProvider {
    static var previews: some View {
        ListGenusView(text).environmentObject(DataModel())
    }
}
