//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var model = HeaderViewModel()
    @FocusState var searchFielActive: Bool
    @Environment(\.presentationMode) var presentationMode
    var inner: Bool? = false
    var title: String = "Pokemon"
    
    var body: some View {
        VStack (spacing: 5) {
            if inner != nil && inner == true {
                ZStack {
                    Button {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(title) Region")
                        .bold()
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                Text("Pokemon")
                    .bold()
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
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
        HeaderView(inner: true)
    }
}
