//

import SwiftUI

struct BerryInfoView: View {
    let berryUrl: String
    @State var berry: BerryModel? = nil
    
    var body: some View {
        VStack {
            if berry != nil {
                InfoView {
                    BackgroundView()
                } icon: {
                    AsyncImage(url: URL(string: berry!.berryItem.sprites.default)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("placeholder")
                            .resizable()
                            .scaledToFit()
                    }
                } content: {
                    VStack {
                        VStack (spacing: 20) {
                            Text(berry!.berryItem.name.splitWord())
                                .font(.largeTitle)
                            
                            Text("\(berry!.berryItem.cost) ₽")
                                .bold()
                                .opacity(0.5)
                            
                            Text(berry!.berryItem.category.name.splitWord())
                            
                            VStack {
                                ForEach(0..<berry!.berryItem.effect_entries.count, id: \.self) { i in
                                    Text(berry!.berryItem.effect_entries[i].short_effect)
                                        .opacity(0.7)
                                }
                            }
                            
                            ScrollView(showsIndicators: false) {
                                InfoRowView(title: "Firmness", value: "\(berry!.berry.firmness.name.splitWord())")
                                InfoRowView(title: "Growth Time", value: "\(berry!.berry.growth_time) hours")
                                InfoRowView(title: "Max Harvest", value: "\(berry!.berry.max_harvest)")
                                InfoRowView(title: "Size", value: "\(berry!.berry.size) milimeters")
                                InfoRowView(title: "Smoothness", value: "\(berry!.berry.smoothness)")
                                InfoRowView(title: "Soil Dryness", value: "\(berry!.berry.soil_dryness)")
                                
                                Text("Flavors")
                                    .bold()
                                
                                VStack {
                                    ForEach(0..<berry!.berry.flavors.count, id: \.self) {i in
                                        InfoRowView(title: berry!.berry.flavors[i].flavor.name.splitWord(), value: "\(berry!.berry.flavors[i].potency)", divider: berry!.berry.flavors.count - 1 != i)
                                    }
                                }
                                .padding(.bottom, 50)
                            }
                        }
                    }
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(BackgroundView())
            }
        }
        .task {
            let data = await ApiModel.api.fetchBerry(berryUrl)
            
            withAnimation {
                berry = data
            }
        }
    }
}

struct BerryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BerryInfoView(berryUrl: "https://pokeapi.co/api/v2/berry/15/")
    }
}
