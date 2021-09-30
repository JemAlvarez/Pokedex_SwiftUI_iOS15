//

import SwiftUI

class PokemonInfoViewModel: ObservableObject {
    @Published var pokemon: PokemonModel? = nil
    @Published var selectedButton: SelectedButton = .stats
    
    @MainActor
    func fetch(_ name: String) {
        Task.init {
            let data = await ApiModel.api.fetchPokemon(name)
            
            withAnimation {
                pokemon = data
            }
        }
    }
    
    func switchButtons(_ to: SelectedButton) {
        selectedButton = to
    }
    
    enum SelectedButton {
        case stats
        case evolutions
        case moves
    }
}
