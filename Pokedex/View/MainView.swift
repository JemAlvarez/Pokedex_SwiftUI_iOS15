//

import SwiftUI

struct MainView: View {
    @StateObject var tabBarViewModel = TabBarViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HeaderView()
                
                Spacer()
                
                TabBarView()
            }
        }
        .environmentObject(tabBarViewModel)
        .colorScheme(.light)
        .ignoresSafeArea(.keyboard)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
