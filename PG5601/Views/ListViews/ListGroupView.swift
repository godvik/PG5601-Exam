import SwiftUI

struct ListGroupView: View {
    @EnvironmentObject var datamodel: DataModel
    @State private var segment = 0
    @State private var families: [String] = []
    @State private var genus: [String] = []
    @State private var order: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $segment) {
                    Text("Family").tag(0)
                    Text("Genus").tag(1)
                    Text("Order").tag(2)
                }
                        .pickerStyle(.segmented)
                        .navigationTitle("Group")
                        .navigationBarTitleDisplayMode(.inline)

                ScrollView {
                    Spacer()
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        Spacer()
                        switch segment {
                        case 0:
                            Spacer()
                            ForEach(families, id: \.self) {
                                family in
                                GroupFamilyView(family)
                            }
                        case 1:
                            Spacer()
                            ForEach(genus, id: \.self) {
                                genus in
                                GroupGenusView(genus)

                            }
                        case 2:
                            Spacer()
                            ForEach(order, id: \.self) {
                                order in
                                GroupOrderView(order)
                            }
                        default:
                            Spacer()
                            ForEach(families, id: \.self) {
                                family in
                                GroupFamilyView(family)
                            }
                        }
                    }
                            .task {
                                await datamodel.loadData()
                                separate()
                            }
                }


                Spacer()

            }
        }
    }

    func separate() {
        for fruit in datamodel.Fruits {
            if (!families.contains(fruit.family)) {
                families.append(fruit.family)
            }
            if (!genus.contains(fruit.genus)) {
                genus.append(fruit.genus)
            }
            if (!order.contains(fruit.order)) {
                order.append(fruit.order)
            }
        }
    }
}

struct ListGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ListGroupView().environmentObject(DataModel())
    }
}
