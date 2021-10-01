//

import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var generationData: GenerationModel? = nil
    @Published var offset: CGFloat = 0
    @Published var selectedPokemon: (name: String, id: Int)? = nil
    @Published var filtered: [GenerationModel.Pokemon] = []
    
    @MainActor
    func fetchGen(gen: Int) {
        Task.init {
            let data = await ApiModel.api.fetchGeneration(gen: gen)
            
            withAnimation {
                generationData = data
                
                if data != nil {
                    filtered = data!.pokemon_species
                }
            }
        }
    }
    
    func setSelectedPokemon(pokemon: GenerationModel.Pokemon) {
        withAnimation {
            selectedPokemon = (pokemon.name, Int(pokemon.getPokemonId()) ?? 0)
        }
    }
    
    func filter(newValue: String, text: String) {
        if generationData != nil {
            if newValue != "" {
                filtered = generationData!.pokemon_species.filter({ $0.name.contains(text.lowercased()) })
            } else {
                filtered = generationData!.pokemon_species
            }
        }
    }
}
