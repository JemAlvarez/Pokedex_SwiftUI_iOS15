//

import SwiftUI

struct PokemonListView: View {
    let gen: Int
    @ObservedObject var model = PokemonListViewModel()
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                HeaderView(inner: true, title: model.generationData?.main_region.name.splitWord() ?? "Unknown")
                
                HStack {
                    Text("Default")
                    Spacer()
                    Text("Shiny")
                        .foregroundColor(.blue)
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        if model.generationData != nil {
                            ForEach(model.generationData!.pokemon_species, id: \.self.name) { pokemon in
                                PokemonRowView(name: pokemon.name, defaultImageUrl: pokemon.getImageUrl(), shinyImageUrl: pokemon.getImageUrl(true), id: Int(pokemon.getPokemonId()))
                                    .onTapGesture { }
                                    .onLongPressGesture {
                                        model.setSelectedPokemon(pokemon: pokemon)
                                    }
                                
                                if model.generationData!.pokemon_species.last!.name != pokemon.name {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
            
            if model.selectedPokemon != nil {
                PokemonRowLongPressView(selectedPokemon: $model.selectedPokemon)
            }
        }
        .offset(x: model.offset)
        .task {
            model.fetchGen(gen: gen)
        }
        .modifier(SwipeToPop(offset: $model.offset))
        .navigationBarHidden(true)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(gen: 1)
    }
}
