//

import SwiftUI

@main
struct PokedexApp: App {
    @StateObject var tabBarViewModel = TabBarViewModel()
    @StateObject var headerViewModel = HeaderViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(tabBarViewModel)
                .environmentObject(headerViewModel)
        }
    }
}
