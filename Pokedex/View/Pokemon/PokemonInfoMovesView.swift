//

import SwiftUI

struct PokemonInfoMovesView: View {
    @ObservedObject var model: PokemonInfoViewModel
    @State var types: [String] = []
    
    var body: some View {
        VStack {
            ForEach(0..<model.pokemon!.pokemon.moves.count, id: \.self) { i in
                HStack {
                    Text(model.pokemon!.pokemon.moves[i].move.name.splitWord())
                    Spacer()
                    Image(types.count - 1 >= i ? types[i] : "placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(5)
                        .background(Color(types.count - 1 >= i ? types[i] : ""))
                        .clipShape(Circle())
                }
                .padding(.bottom, i == model.pokemon!.pokemon.moves.count - 1 ? 20 : 0)
                
                if i != model.pokemon!.pokemon.moves.count - 1 {
                    Divider()
                }
            }
        }
        .task {
            for move in model.pokemon!.pokemon.moves {
                let data = await ApiModel.api.fetchMove(move.move.url)
                
                withAnimation {
                    types.append(data?.type.name ?? "placeholder")
                }
            }
        }
    }
}

struct PokemonInfoMovesView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoMovesView(model: PokemonInfoViewModel())
    }
}
