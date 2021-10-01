//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    @EnvironmentObject var headerViewModel: HeaderViewModel
    @State var title = "Pokemon"
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    HeaderView(title: title)
                    
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
            .onChange(of: tabBarViewModel.tab, perform: { newValue in
                withAnimation {
                    headerViewModel.searchText = ""
                }
                
                switch newValue {
                case 0:
                    title = "Pokemon"
                case 1:
                    title = "Moves"
                case 2:
                    title = "Items"
                case 3:
                    title = "Berries"
                default:
                    title = "Pokemon"
                }
            })
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
