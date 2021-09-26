//

import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var generationData: GenerationModel? = nil
    @Published var offset: CGFloat = 0
    
    @MainActor
    func fetchGen(gen: Int) {
        Task.init {
            let data = await ApiModel.api.fetchGeneration(gen: gen)
            
            withAnimation {
                generationData = data
            }
        }
    }
}
