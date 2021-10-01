//

import SwiftUI

class ListViewModel: ObservableObject {
    @Published var data: AllListModel? = nil
    @Published var filtered: [Result] = []
    
    @MainActor
    func request(_ type: ApiModel.RequestType) {
        Task.init {
            let fetchedData = await ApiModel.api.fetchAllList(type)
            
            withAnimation {
                data = fetchedData
                
                if fetchedData != nil {
                    filtered = fetchedData!.results
                }
            }
        }
    }
    
    func filter(newValue: String, text: String) {
        if data != nil {
            if newValue != "" {
                filtered = data!.results.filter({ $0.name.contains(text.lowercased()) })
            } else {
                filtered = data!.results
            }
        }
    }
}
