//

import SwiftUI

struct PokemonInfoButtonsView: View {
    var model: PokemonInfoViewModel
    @State var selected: PokemonInfoViewModel.SelectedButton = .stats
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("STATS")
                .modifier(InfoRoundedStyle())
                .background(selected == .stats ? Color(model.pokemon!.pokemon.types[0].type.name) : .clear)
                .cornerRadius(99)
                .onTapGesture {
                    model.switchButtons(.stats)
                    withAnimation {
                        selected = model.selectedButton
                    }
                }
            
            Spacer()
            
            Text("EVOLUTIONS")
                .modifier(InfoRoundedStyle())
                .background(selected == .evolutions ? Color(model.pokemon!.pokemon.types[0].type.name) : .clear)
                .cornerRadius(99)
                .onTapGesture {
                    model.switchButtons(.evolutions)
                    withAnimation {
                        selected = model.selectedButton
                    }
                }
            
            
            Spacer()
            
            Text("MOVES")
                .modifier(InfoRoundedStyle())
                .background(selected == .moves ? Color(model.pokemon!.pokemon.types[0].type.name) : .clear)
                .cornerRadius(99)
                .onTapGesture {
                    model.switchButtons(.moves)
                    withAnimation {
                        selected = model.selectedButton
                    }
                }
            
            Spacer()
        }
        .font(.body.bold())
    }
}

struct PokemonInfoButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoButtonsView(model: PokemonInfoViewModel())
    }
}
