//

import SwiftUI

struct ContentView: View {
    @State var berries: [BerryModel] = [BerryModel]()
    
    var body: some View {
        VStack {
            Button("Fetch Berries") {
                Task.init {
                    let data = await ApiModel.api.fetchBerries()
                    if data != nil {
                        berries = data!
                    }
                }
            }
            
            List(berries) { berry in
                HStack {
                    AsyncImage(url: URL(string: berry.berryItem.sprites.default))
                    Text(berry.name)
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
