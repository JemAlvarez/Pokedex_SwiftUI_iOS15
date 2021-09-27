//

import SwiftUI

struct PokemonRowLongPressView: View {
    @Binding var selectedPokemon: (name: String, id: Int)?
    
    var body: some View {
        ZStack {
            Spacer()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .onTapGesture {
                    withAnimation {
                        selectedPokemon = nil
                    }
                }
            
            VStack {
                Text(selectedPokemon!.name.splitWord())
                    .font(.title)
                    .bold()
                
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(selectedPokemon!.id).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 3)
            .background(
                Color.white
                    .shadow(radius: 10)
            )
            .cornerRadius(20)
        }
    }
}

struct PokemonRowLongPressView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRowLongPressView(selectedPokemon: .constant(nil))
    }
}
