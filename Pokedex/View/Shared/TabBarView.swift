//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var model: TabBarViewModel
    
    var body: some View {
        HStack {
            ForEach (0..<model.tabs.count) { i in
                VStack {
                    Spacer()
                    
                    Image(model.tabs[i])
                        .resizable()
                        .frame(maxWidth: 25, maxHeight: 25)
                    
                    Text(model.tabs[i].capitalized)
                    
                    Spacer()
                }
                .foregroundColor(.black)
                .onTapGesture {
                    if model.tab != i {
                        withAnimation {
                            model.tab = i
                        }
                    }
                }
                .opacity(model.tab != i ? 0.3 : 1)
                
                if i != model.tabs.count - 1 {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
