import SwiftUI

struct ListOrderView: View {

    var orderName: String

    init(_ text: String) {
        self.orderName = text
    }

    @EnvironmentObject var datamodel: DataModel
    var body: some View {
        NavigationView {
            List {
                ForEach(datamodel.Order) {
                    fruit in
                    FruitView(fruit)
                }
            }
                    .listStyle(.plain)
                    .task {
                        await datamodel.loadOrderData(order: orderName)
                    }
                    .navigationTitle(orderName)
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ListOrderView(text).environmentObject(DataModel())
    }
}
