//

import SwiftUI

struct ContentView: View {
    @State var list: AllListModel? = nil
    @State var listType: ApiModel.RequestType? = .berries
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Fetch Berries") {
                        Task.init {
                            list = nil
                            listType = .berries
                            let data = await ApiModel.api.fetchAllList(.berries)
                            if data != nil {
                                list = data!
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Fetch Items") {
                        Task.init {
                            list = nil
                            listType = .items
                            let data = await ApiModel.api.fetchAllList(.items)
                            if data != nil {
                                list = data!
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Fetch Moves") {
                        Task.init {
                            list = nil
                            listType = .moves
                            let data = await ApiModel.api.fetchAllList(.moves)
                            if data != nil {
                                list = data!
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        PokemonView()
                    } label: {
                        Text("Pokemon")
                    }
                    
                }
                
                if list != nil {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach (list!.results, id: \.self.name) { listItem in
                                HStack {
                                    if listType != .moves {
                                        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(listItem.name)\(listType == .berries ? "-berry" : "").png"))
                                            .frame(maxWidth: 100)
                                    }
                                    Text(listItem.name.splitWord())
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PokemonView: View {
    @State var pokemonList: GenerationModel? = nil
    
    var body: some View {
        VStack {
            HStack {
                Button("Gen 1") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 1)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
                
                Spacer()
                
                Button("Gen 2") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 2)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
                
                Spacer()
                
                Button("Gen 3") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 3)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
                
                Spacer()
                
                Button("Gen 4") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 4)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
            }
            
            HStack {
                Button("Gen 5") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 5)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
                
                Spacer()
                
                Button("Gen 6") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 6)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
                
                Spacer()
                
                Button("Gen 7") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 7)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
                
                Spacer()
                
                Button("Gen 8") {
                    Task.init {
                        pokemonList = nil
                        let data = await ApiModel.api.fetchGeneration(gen: 8)
                        if data != nil {
                            pokemonList = data!
                        }
                    }
                }
            }
            
            if pokemonList != nil {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach (pokemonList!.pokemon_species, id: \.self.name) { pokemon in
                            HStack {
                                AsyncImage(url: URL(string: pokemon.getImageUrl()))
                                    .frame(maxWidth: 100)
                                AsyncImage(url: URL(string: pokemon.getImageUrl(true)))
                                    .frame(maxWidth: 100)
                                Text("#\(pokemon.getPokemonId())")
                                    .opacity(0.7)
                                Text(pokemon.name.splitWord())
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
