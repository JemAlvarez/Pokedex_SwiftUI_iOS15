//

import SwiftUI

struct GenerationView: View {
    @ObservedObject var model = GenerationViewModel()
    var cols = [GridItem(spacing: 20), GridItem(spacing: 20)]
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVGrid(columns: cols, spacing: 20) {
                ForEach (0..<model.generations.count) { i in
                    NavigationLink {
                        Text("Generation \(i + 1)")
                    } label: {
                        GenerationTileView(gen: i)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(.ultraThinMaterial)
    }
}

struct GenerationView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationView()
    }
}
