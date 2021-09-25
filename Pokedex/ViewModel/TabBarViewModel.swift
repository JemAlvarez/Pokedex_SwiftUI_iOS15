//

import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var tab = 0
    
    let tabs = ["pokemon", "moves", "items", "berries", "settings"]
}
