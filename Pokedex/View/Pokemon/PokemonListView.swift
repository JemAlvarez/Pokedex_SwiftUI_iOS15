//

import SwiftUI

struct PokemonListView: View {
    let gen: Int
    @State var generationData: GenerationModel? = nil
    
    var body: some View {
        VStack (spacing: 0) {
            HeaderView(inner: true, title: generationData?.main_region.name.splitWord() ?? "Unknown")
            
            HStack {
                Text("Default")
                Spacer()
                Text("Shiny")
                    .foregroundColor(.blue)
            }
            .padding()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    if generationData != nil {
                        ForEach(generationData!.pokemon_species, id: \.self.name) { pokemon in
                            PokemonRowView(name: pokemon.name, defaultImageUrl: pokemon.getImageUrl(), shinyImageUrl: pokemon.getImageUrl(true), id: Int(pokemon.getPokemonId()))
                            
                            if generationData!.pokemon_species.last!.name != pokemon.name {
                                Divider()
                                    .padding(.leading)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .task {
            let data = await ApiModel.api.fetchGeneration(gen: gen)
            
            withAnimation {
                generationData = data
            }
        }
        .navigationBarHidden(true)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(gen: 1)
    }
}
