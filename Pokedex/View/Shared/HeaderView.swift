//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var model = HeaderViewModel()
    @FocusState var searchFielActive: Bool
    
    var body: some View {
        VStack (spacing: 5) {
            Text("Pokemon")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                TextField("Search", text: $model.searchText)
                    .padding(.horizontal, 10)
                    .padding(.leading, 25)
                    .padding(.vertical, 7)
                    .background(.black.opacity(0.1))
                    .cornerRadius(99)
                    .focused($searchFielActive)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if searchFielActive {
                        Image(systemName: "xmark.circle")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.red)
                            .onTapGesture(perform: model.unfocusSearchField)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .onChange(of: model.searchFielActive) { newValue in
            withAnimation {
                searchFielActive = newValue
            }
        }
        .onChange(of: searchFielActive) { newValue in
            withAnimation {
                model.searchFielActive = newValue
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
