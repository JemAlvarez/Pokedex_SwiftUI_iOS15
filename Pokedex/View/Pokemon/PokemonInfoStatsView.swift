//

import SwiftUI

struct PokemonInfoStatsView: View {
    @ObservedObject var model: PokemonInfoViewModel
    
    var body: some View {
        Text("Pokemon")
    }
}

struct PokemonInfoStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoStatsView(model: PokemonInfoViewModel())
    }
}
