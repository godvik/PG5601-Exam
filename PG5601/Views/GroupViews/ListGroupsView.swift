import SwiftUI

struct ListGroupsView: View {
    @EnvironmentObject var datamodel: DataModel
	@EnvironmentObject var router: Router
    @State private var segment = 0
    @State private var families: [String] = []
    @State private var genus: [String] = []
    @State private var order: [String] = []

    var body: some View {
		NavigationStack(path: $router.categoryPath){
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
                                GroupSegmentView(family, "family")
                            }
                        case 1:
                            Spacer()
                            ForEach(genus, id: \.self) {
                                genus in
                                GroupSegmentView(genus, "genus")
                            }
                        case 2:
                            Spacer()
                            ForEach(order, id: \.self) {
                                order in
                                GroupSegmentView(order, "order")
                            }
                        default:
                            Spacer()
                            ForEach(families, id: \.self) {
                                family in
                                GroupSegmentView(family, "family")
                            }
                        }
                    }
                            .task {
                                await datamodel.loadData(endpoint: "all")
                                splitIntoCategories()
                            }
                }
				Spacer()
            }
        }
    }

    func splitIntoCategories() {
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

