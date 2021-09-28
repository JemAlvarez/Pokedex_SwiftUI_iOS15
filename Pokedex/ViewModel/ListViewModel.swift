//

import SwiftUI

class ListViewModel: ObservableObject {
    @Published var data: AllListModel? = nil
    
    @MainActor
    func request(_ type: ApiModel.RequestType) {
        Task.init {
            let fetchedData = await ApiModel.api.fetchAllList(type)
            
            withAnimation {
                data = fetchedData
            }
        }
    }
}
