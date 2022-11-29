import SwiftUI

struct MainView: View {
    @EnvironmentObject var datamodel: DataModel
	@EnvironmentObject var router: Router

    var body: some View {
        TabView {
            ListAllView().tabItem() {
                Label("Fruits", systemImage: "house.fill")
			}
			ListGroupsView().tabItem() {
                Label("Group", systemImage: "rectangle.3.group.fill")
            }
			LogView().tabItem({
                Label("Log", systemImage: "list.bullet.clipboard.fill")
            })
        }

    }
}
