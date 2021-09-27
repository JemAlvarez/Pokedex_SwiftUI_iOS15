//

import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var generationData: GenerationModel? = nil
    @Published var offset: CGFloat = 0
    @Published var selectedPokemon: (name: String, id: Int)? = nil
    
    @MainActor
    func fetchGen(gen: Int) {
        Task.init {
            let data = await ApiModel.api.fetchGeneration(gen: gen)
            
            withAnimation {
                generationData = data
            }
        }
    }
    
    func setSelectedPokemon(pokemon: GenerationModel.Pokemon) {
        withAnimation {
            selectedPokemon = (pokemon.name, Int(pokemon.getPokemonId()) ?? 0)
        }
    }
}
