//

import SwiftUI

struct MainView: View {
    @StateObject var tabBarViewModel = TabBarViewModel()
    // set header model as state object for searching between views
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    HeaderView()
                    
                    switch tabBarViewModel.tab {
                    case 0:
                        GenerationView()
                    case 1:
                        ListView(listContent: .moves)
                    case 2:
                        ListView(listContent: .items)
                    case 3:
                        ListView(listContent: .berries)
                    default:
                        EmptyView()
                    }
                    
                    TabBarView()
                }
            }
            .environmentObject(tabBarViewModel)
            .preferredColorScheme(.light)
            .ignoresSafeArea(.keyboard)
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
