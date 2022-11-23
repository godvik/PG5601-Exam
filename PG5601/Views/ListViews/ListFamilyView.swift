import SwiftUI

struct ListFamilyView: View {

    var familyName: String

    init(_ text: String) {
        self.familyName = text
    }

    @EnvironmentObject var datamodel: DataModel
    var body: some View {
        NavigationView {
            List {
                ForEach(datamodel.Families) {
                    fruit in
                    FruitView(fruit)
                }
            }
                    .listStyle(.plain)
                    .task {
                        await datamodel.loadFamiliesData(family: familyName)
                    }
                    .navigationTitle(familyName)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
        }
    }
}

struct ListFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        ListFamilyView(text).environmentObject(DataModel())
    }
}
