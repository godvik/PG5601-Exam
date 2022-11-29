import Foundation
import SwiftUI
final class Router: ObservableObject {
	@Published var path = NavigationPath()
	@Published var categoryPath = NavigationPath()
}

