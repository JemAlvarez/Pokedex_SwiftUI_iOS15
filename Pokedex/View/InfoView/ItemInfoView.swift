//

import SwiftUI

struct ItemInfoView: View {
    let itemUrl: String
    @State var item: ItemModel? = nil
    
    var body: some View {
        VStack {
            if item != nil {
                InfoView {
                    BackgroundView()
                } icon: {
                    AsyncImage(url: URL(string: item!.sprites.default)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                    }
                } content: {
                    VStack (spacing: 20) {
                        Text(item!.name.splitWord())
                            .font(.largeTitle)
                        
                        Text("\(item!.cost) ₽")
                            .bold()
                            .opacity(0.5)
                        
                        Text(item!.category.name.splitWord())
                        
                        VStack {
                            ForEach(0..<item!.effect_entries.count, id: \.self) { i in
                                Text(item!.effect_entries[i].short_effect)
                                    .opacity(0.7)
                            }
                        }
                        
                        Spacer()
                    }
                }

            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(BackgroundView())
            }
        }
        .task {
            let data = await ApiModel.api.fetchItem(itemUrl)
            
            withAnimation {
                item = data
            }
        }
    }
}

struct ItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ItemInfoView(itemUrl: "https://pokeapi.co/api/v2/item/15/")
    }
}
