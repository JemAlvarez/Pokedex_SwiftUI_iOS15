//

import SwiftUI

struct PokemonRowView: View {
    let name: String
    let defaultImageUrl: String
    let shinyImageUrl: String
    let id: Int?
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: defaultImageUrl),
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
            
            Spacer()
            
            VStack {
                Text(name.splitWord())
                    .font(.title2)
                Text("#\(id != nil ? "\(id!)" : "???")")
                    .font(.title3)
                    .opacity(0.5)
            }
            
            Spacer()
            
            AsyncImage(
                url: URL(string: shinyImageUrl),
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
        }
        .background(.white)
        .frame(height: Constants.rowHeight)
        .padding(.horizontal)
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRowView(name: "balbasaur", defaultImageUrl: "pokeball", shinyImageUrl: "pokeball", id: 1)
    }
}
