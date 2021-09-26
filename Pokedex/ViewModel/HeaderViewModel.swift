//

import SwiftUI

class HeaderViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchFielActive = false
    
    func unfocusSearchField() {
        withAnimation {
            searchFielActive = false
        }
    }
}
