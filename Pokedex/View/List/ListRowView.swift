//

import SwiftUI

struct ListRowView: View {
    let result: Result
    let type: ApiModel.RequestType
    
    @State var sheetPresented = false
    
    var body: some View {
        HStack {
            if type != .moves {
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(type == .berries ? "\(result.name)-berry" : result.name).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: Constants.rowHeight / 1.5)
            }
            
            Text(result.name.splitWord())
                .bold()
                .font(.title3)
            
            Spacer()
        }
        .onTapGesture {
            withAnimation {
                sheetPresented = true
            }
        }
        .frame(height: Constants.rowHeight)
        .sheet(isPresented: $sheetPresented) {
            if type == .moves {
                MoveInfoView(moveUrl: result.url)
            } else if type == .items {
                ItemInfoView(itemUrl: result.url)
            } else if type == .berries {
                BerryInfoView(berryUrl: result.url)
            }
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(result: Result(name: "Hey", url: "a"), type: .moves)
    }
}
