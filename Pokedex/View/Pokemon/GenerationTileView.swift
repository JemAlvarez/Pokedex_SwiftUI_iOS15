//

import SwiftUI

struct GenerationTileView: View {
    let gen: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("pokeball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .offset(x: geo.size.width / 2.7, y: 50)
                    .opacity(0.1)
                
                VStack (spacing: 0) {
                    Text("Generation \(gen + 1)")
                        .bold()
                        .font(.title2)
                    
                    Image("gen\(gen + 1)")
                        .resizable()
                        .scaledToFit()
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 7, x: 5, y: 5)
    }
}

struct GenerationTileView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationTileView(gen: 0)
    }
}
