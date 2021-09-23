//

import SwiftUI

struct ContentView: View {
    @State var berries: [BerryModel] = [BerryModel]()
    @State var items: [ItemModel] = [ItemModel]()
    @State var page = 0
    @State var loadingItems = false
    
    var body: some View {
        VStack {
            HStack {
                Button("Fetch Berries") {
                    berries = []
                    items = []
                    Task.init {
                        let data = await ApiModel.api.fetchBerries()
                        if data != nil {
                            berries = data!
                        }
                    }
                }
                
                Button("Fetch Items") {
                    berries = []
                    items = []
                    Task.init {
                        let data = await ApiModel.api.fetchItems(limit: 100, page: page)
                        if data != nil {
                            items = data!
                        }
                    }
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
                                    page += 1
                                    let data = await ApiModel.api.fetchItems(limit: 100, page: page)
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
