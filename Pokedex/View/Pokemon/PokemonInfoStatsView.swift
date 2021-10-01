//

import SwiftUI

struct PokemonInfoStatsView: View {
    @ObservedObject var model: PokemonInfoViewModel
    
    @State var animate = false
    
    var body: some View {
        VStack (spacing: 20) {
            // base stats
            VStack {
                ForEach(0..<model.pokemon!.pokemon.stats.count, id: \.self) { i in
                    HStack {
                        Group {
                            switch i {
                            case 0:
                                Text("HP  ")
                                    .bold()
                            case 1:
                                Text("ATK ")
                                    .bold()
                            case 2:
                                Text("DEF ")
                                    .bold()
                            case 3:
                                Text("SATK")
                                    .bold()
                            case 4:
                                Text("SDEF")
                                    .bold()
                            case 5:
                                Text("SPD ")
                                    .bold()
                            default:
                                Text("----")
                            }
                        }
                        .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                        .frame(width: 50, alignment: .leading)
                        
                        Text("\(model.pokemon!.pokemon.stats[i].base_stat)")
                            .frame(width: 50, alignment: .leading)
                        
                        ProgressView(value: animate ? Float(model.pokemon!.pokemon.stats[i].base_stat) : 0, total: 255)
                            .tint(Color(model.pokemon!.pokemon.types[0].type.name))
                            .scaleEffect(x: 1, y: 1.5, anchor: .center)
                    }
                }
            }
            
            // abilities
            VStack {
                Text("Abilities")
                    .bold()
                    .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                    .font(.title3)
                
                ForEach(0..<model.pokemon!.abilities.count, id: \.self) { i in
                    Group {
                        Text(model.pokemon!.abilities[i].name.splitWord())
                            .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                        
                        ForEach (0..<model.pokemon!.abilities[i].effect_entries.count, id: \.self) { j in
                            if model.pokemon!.abilities[i].effect_entries[j].language.name == "en" {
                                Text(model.pokemon!.abilities[i].effect_entries[j].short_effect)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            // species
            VStack {
                Text("Species")
                    .bold()
                    .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                
                HStack (spacing: 0) {
                    Text("Is Legendary")
                    Spacer()
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title)
                        .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                }
                Divider()
                    .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                HStack (spacing: 0) {
                    Text("Is Mythical")
                    Spacer()
                    Image(systemName: "xmark.seal.fill")
                        .font(.title)
                        .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                }
                Divider()
                    .foregroundColor(Color(model.pokemon!.pokemon.types[0].type.name))
                HStack (spacing: 0) {
                    Text("Capture Rate ")
                    Text("(\(model.pokemon!.species.capture_rate)/255)")
                        .opacity(0.5)
                    Spacer()
                    ProgressView(value: animate ? Float(model.pokemon!.species.capture_rate) : 0, total: 255)
                        .progressViewStyle(GaugeProgressStyle(strokeColor: Color(model.pokemon!.pokemon.types[0].type.name), strokeWidth: 3))
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 5)
                }
            }
            .padding(.bottom)
        }
        .onAppear {
            withAnimation {
                animate = true
            }
        }
        .onDisappear {
            animate = false
        }
    }
}

struct PokemonInfoStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoStatsView(model: PokemonInfoViewModel())
    }
}
