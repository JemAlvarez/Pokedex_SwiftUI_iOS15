//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var model: HeaderViewModel
    @EnvironmentObject var tabBarViewModel: TabBarViewModel
    @FocusState var searchFielActive: Bool
    @Environment(\.presentationMode) var presentationMode
    var inner: Bool = false
    var title: String = "Pokedex"
    
    var body: some View {
        VStack (spacing: 5) {
            if inner {
                ZStack {
                    Button {
                        model.unfocusSearchField()
                        
                        withAnimation {
                            model.searchText = ""
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.black)
                            .opacity(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(title) Region")
                        .bold()
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } else {
                Text(title)
                    .bold()
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ZStack {
                TextField(tabBarViewModel.tab == 0 ? (inner ? "Search" : "Nothing to serach here...") : "Search", text: $model.searchText)
                    .padding(.horizontal, 10)
                    .padding(.leading, 25)
                    .padding(.vertical, 7)
                    .background(.black.opacity(0.1))
                    .cornerRadius(99)
                    .focused($searchFielActive)
                    .onSubmit {
                        model.unfocusSearchField()
                    }
                    .submitLabel(.done)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") { model.unfocusSearchField() }
                        }
                    }
                    .disabled(tabBarViewModel.tab == 0 && !inner)
                
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if searchFielActive {
                        Image(systemName: "trash.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundColor(.red)
                            .onTapGesture {
                                model.unfocusSearchField()
                                model.searchText = ""
                            }
                            .font(.title2)
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
