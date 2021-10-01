//

import SwiftUI

struct ListView: View {
    let listContent: ApiModel.RequestType
    @StateObject var model = ListViewModel()
    @EnvironmentObject var headerViewModel: HeaderViewModel
    
    var body: some View {
        VStack {
            if model.data != nil {
                ScrollView (showsIndicators: false) {
                    LazyVStack {
                        ForEach (0..<model.filtered.count, id: \.self) { i in
                            // row view
                            ListRowView(result: model.filtered[i], type: listContent)
                            
                            if model.filtered.count - 1 != i {
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                        
                    }
                    .padding()
                }
                
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(.ultraThinMaterial)
        .task {
            model.request(listContent)
        }
        .onChange(of: headerViewModel.searchText) { newValue in model.filter(newValue: newValue, text: headerViewModel.searchText)}
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(listContent: .moves)
    }
}
