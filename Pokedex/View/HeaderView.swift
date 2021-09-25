//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var model = HeaderViewModel()
    
    var body: some View {
        VStack (spacing: 5) {
            Text("Pokemon")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("🔍 Search", text: $model.searchText)
                .padding(.horizontal, 10)
                .padding(.vertical, 7)
                .background(.black.opacity(0.1))
                .cornerRadius(99)
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
