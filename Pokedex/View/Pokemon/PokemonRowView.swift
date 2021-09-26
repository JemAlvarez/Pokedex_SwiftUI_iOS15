//

import SwiftUI

struct PokemonRowView: View {
    let name: String
    let image: String
    let id: Int?
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: image),
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                },
                placeholder: {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                }
            )
            
            VStack(alignment: .leading) {
                Text(name.splitWord())
                    .font(.title2)
                Text("#\(id != nil ? "\(id!)" : "???")")
                    .font(.title3)
                    .opacity(0.5)
            }
            
            Spacer()
            
            HStack {
                Image("bug")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(10)
                    .background(.red)
                    .cornerRadius(99)
                
                Image("dark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(10)
                    .background(.red)
                    .cornerRadius(99)
            }
        }
        .frame(height: 70)
        .padding(.horizontal)
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRowView(name: "balbasaur", image: "pokeball", id: 1)
    }
}
