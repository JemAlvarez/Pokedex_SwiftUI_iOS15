//

import SwiftUI

class PokemonInfoViewModel: ObservableObject {
    @Published var pokemon: PokemonModel? = nil
    
    @MainActor
    func fetch(_ name: String) {
        Task.init {
            let data = await ApiModel.api.fetchPokemon(name)
            
            withAnimation {
                pokemon = data
            }
        }
    }
}
