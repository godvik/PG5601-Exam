import SwiftUI

@main
struct PG5601App: App {
	@StateObject var datamodel = DataModel()
    var body: some Scene {
        WindowGroup {
			JsonView().environmentObject(datamodel)
        }
    }
}
