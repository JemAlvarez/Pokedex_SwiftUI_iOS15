//

import SwiftUI

struct ContentView: View {
    @State var berries: [BerryModel] = [BerryModel]()
    @State var items: [ItemModel] = [ItemModel]()
    @State var moves: AllListModel? = nil
    @State var itemsPage = 0
    @State var loadingItems = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Fetch Berries") {
                        berries = []
                        items = []
                        moves = nil
                        Task.init {
                            let data = await ApiModel.api.fetchBerries()
                            if data != nil {
                                berries = data!
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Fetch Items") {
                        berries = []
                        items = []
                        moves = nil
                        Task.init {
                            itemsPage = 0
                            let data = await ApiModel.api.fetchItems(limit: 100, page: itemsPage)
                            if data != nil {
                                items = data!
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Fetch Moves") {
                        berries = []
                        items = []
                        moves = nil
                        Task.init {
                            let data = await ApiModel.api.fetchMoves()
                            if data != nil {
                                moves = data!
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
                
                if berries.count != 0 {
                    ScrollView (showsIndicators: false) {
                        VStack {
                            ForEach (berries) { berry in
                                HStack {
                                    AsyncImage(url: URL(string: berry.berryItem.sprites.default))
                                        .frame(maxWidth: 100)
                                    Text(berry.name)
                                    Spacer()
                                }
                            }
                        }
                    }
                } else if items.count != 0 {
                    VStack {
                        List (items) { item in
                            HStack {
                                AsyncImage(url: URL(string: item.item.sprites.default))
                                    .frame(maxWidth: 100)
                                Text(item.name)
                                Spacer()
                            }
                            .task {
                                if items.count != 0 {
                                    if item.name == items.last!.name {
                                        loadingItems = true
                                        itemsPage += 1
                                        let data = await ApiModel.api.fetchItems(limit: 100, page: itemsPage)
                                        if data != nil {
                                            items.append(contentsOf: data!)
                                            loadingItems = false
                                        }
                                    }
                                }
                            }
                        }
                        if loadingItems {
                            ProgressView()
                        }
                    }
                } else if moves != nil {
                    VStack {
                        List (moves!.results, id: \.self.name) { move in
                            HStack {
                                Text(move.name.splitWord())
                                Spacer()
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
    var body: some View {
        VStack {
            HStack {
                Button("Gen 1") {
                    
                }
                
                Spacer()
                
                Button("Gen 2") {
                    
                }
                
                Spacer()
                
                Button("Gen 3") {
                    
                }
                
                Spacer()
                
                Button("Gen 4") {
                    
                }
            }
            
            HStack {
                Button("Gen 5") {
                    
                }
                
                Spacer()
                
                Button("Gen 6") {
                    
                }
                
                Spacer()
                
                Button("Gen 7") {
                    
                }
                
                Spacer()
                
                Button("Gen 8") {
                    
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
