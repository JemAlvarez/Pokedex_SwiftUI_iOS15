//

import SwiftUI

struct ListView: View {
    let listContent: ApiModel.RequestType
    
    @ObservedObject var model = ListViewModel()
    
    var body: some View {
        VStack {
            if model.data != nil {
                ScrollView (showsIndicators: false) {
                    LazyVStack {
                        ForEach (0..<model.data!.results.count, id: \.self) { i in
                            // row view
                            ListRowView(result: model.data!.results[i], type: listContent)
                            
                            if model.data!.results.count - 1 != i {
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
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(listContent: .moves)
    }
}
