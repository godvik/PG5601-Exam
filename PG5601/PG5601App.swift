import SwiftUI

@main
struct PG5601App: App {
	@StateObject var datamodel = DataModel()
	@StateObject private var dataController = DataController()
	@StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
			MainView()
				.environmentObject(datamodel)
				.environmentObject(router)
				.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
