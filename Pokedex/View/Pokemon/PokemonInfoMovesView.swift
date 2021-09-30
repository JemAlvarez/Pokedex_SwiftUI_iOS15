//

import SwiftUI

struct PokemonInfoMovesView: View {
    @ObservedObject var model: PokemonInfoViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PokemonInfoMovesView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoMovesView(model: PokemonInfoViewModel())
    }
}
