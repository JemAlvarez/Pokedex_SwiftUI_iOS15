//

import SwiftUI

struct PokemonInfoView: View {
    let pokemonName: String
    @ObservedObject var model = PokemonInfoViewModel()
    
    var body: some View {
        VStack {
            if model.pokemon != nil {
                InfoView {
                    Color(model.pokemon!.pokemon.types[0].type.name)
                } icon: {
                    AsyncImage(url: URL(string: model.pokemon!.pokemon.sprites.other.officialArtwork.front_default)) {image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 300, height: 300)
                } content: {
                    VStack (spacing: 20) {
                        Text(model.pokemon!.pokemon.name.splitWord())
                            .font(.largeTitle)
                        
                        HStack {
                            Image(model.pokemon!.pokemon.types[0].type.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text(model.pokemon!.pokemon.types[0].type.name.splitWord())
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(model.pokemon!.pokemon.types[0].type.name))
                        .cornerRadius(99)
                        
                        Text(model.pokemon!.species.flavor_text_entries[0].flavor_text.components(separatedBy: .newlines).joined(separator: " "))
                            .frame(maxWidth: .infinity)
                            .opacity(0.7)
                        
                        // buttons  - STATS | EVOLUTIONS
                        
                        // scrollview
                            // if stats
                                // show sttas view
                                    // sprites
                                        // back front , shiny non shiny
                                    // capture rate circle progress
                            // else
                                // evolutions view
                        
                        Spacer()
                    }
                    .padding(.top, 50)
                }

            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(BackgroundView())
            }
        }
        .task {
            model.fetch(pokemonName)
        }
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemonName: "charizard")
    }
}
