//

import SwiftUI

struct PokemonInfoEvolutionView: View {
    @ObservedObject var model: PokemonInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<model.pokemon!.evolutions.count, id: \.self) { i in
                if i != 0 {
                    Label("Level \(model.pokemon!.evolutions[i].level)\(model.pokemon!.evolutions[i].level == 0 ? " (Baby)" : "")", systemImage: "chevron.down")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .opacity(0.7)
                }
                
                HStack {
                    Text("#\(model.pokemon!.evolutions[i].pokemonId)")
                        .opacity(0.5)
                    
                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(model.pokemon!.evolutions[i].pokemonId).png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 100, height: 100)
                    
                    Text(model.pokemon!.evolutions[i].pokemonName.splitWord())
                        .font(.title3)
                }
            }
        }
    }
}

struct PokemonInfoEvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoEvolutionView(model: PokemonInfoViewModel())
    }
}
