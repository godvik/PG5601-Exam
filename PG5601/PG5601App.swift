import SwiftUI

@main
struct PG5601App: App {
	@StateObject var datamodel = DataModel()
	@StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
			MainView()
				.environmentObject(datamodel)
				.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
