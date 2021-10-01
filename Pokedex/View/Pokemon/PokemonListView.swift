//

import SwiftUI

struct PokemonListView: View {
    let gen: Int
    @StateObject var model = PokemonListViewModel()
    @EnvironmentObject var headerViewModel: HeaderViewModel
    
    var body: some View {
        ZStack {VStack {
                HeaderView(inner: true, title: model.generationData?.main_region.name.splitWord() ?? "Unknown")
                
                VStack {
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
                                ForEach(model.filtered, id: \.self.name) { pokemon in
                                    PokemonRowView(name: pokemon.name, defaultImageUrl: pokemon.getImageUrl(), shinyImageUrl: pokemon.getImageUrl(true), id: Int(pokemon.getPokemonId()))
                                        .onTapGesture { }
                                        .onLongPressGesture {
                                            model.setSelectedPokemon(pokemon: pokemon)
                                        }
                                    
                                    if model.filtered.last!.name != pokemon.name {
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
                .background(.ultraThinMaterial)
            }
            
            if model.selectedPokemon != nil {
                PokemonRowLongPressView(selectedPokemon: $model.selectedPokemon)
            }
        }
        .offset(x: model.offset)
        .background(BackgroundView())
        .task {
            model.fetchGen(gen: gen)
        }
        .onChange(of: headerViewModel.searchText) { newValue in model.filter(newValue: newValue, text: headerViewModel.searchText)}
        .modifier(SwipeToPop(offset: $model.offset))
        .navigationBarHidden(true)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(gen: 1)
    }
}
