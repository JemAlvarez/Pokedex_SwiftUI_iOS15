//

import SwiftUI

struct MoveInfoView: View {
    let moveUrl: String
    @State var move: MoveModel? = nil
    
    var body: some View {
        VStack {
            if move != nil {
                InfoView() {
                    Color(move!.type.name)
                } icon: {
                    Image(move!.type.name)
                        .resizable()
                        .scaledToFit()
                        .padding(25)
                        .background(Color(move!.type.name))
                        .clipShape(Circle())
                        .shadow(radius: 15)
                } content: {
                    VStack (spacing: 20) {
                        Text(move!.name.splitWord())
                            .font(.largeTitle)
                        
                        HStack {
                            Image(move!.type.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text(move!.type.name.splitWord())
                                .bold()
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(move!.type.name))
                        .cornerRadius(99)
                        
                        ForEach(0..<move!.effect_entries.count, id: \.self) { i in
                            Text(move!.effect_entries[i].short_effect)
                                .opacity(0.7)
                        }
                        
                        ScrollView(showsIndicators: false) {
                            InfoRowView(title: "Accuracy", value: "\(move!.accuracy != nil ? "\(move!.accuracy!)" : "-")")
                            InfoRowView(title: "Damage Class", value: move!.damage_class.name.splitWord())
                            InfoRowView(title: "Power", value: "\(move!.power != nil ? "\(move!.power!)" : "-")")
                            InfoRowView(title: "PP", value: "\(move!.pp)")
                            InfoRowView(title: "Priority", value: "\(move!.priority)")
                            
                            Text("Learned by Pokemon (\(move!.learned_by_pokemon.count) Pokemon)")
                                .bold()
                            
                            VStack {
                                ForEach(0..<move!.learned_by_pokemon.count, id: \.self) { i in
                                    Text("\(move!.learned_by_pokemon[i].name.splitWord())")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .opacity(0.5)
                                }
                            }
                            .padding(.bottom, 50)
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
            let data = await ApiModel.api.fetchMove(moveUrl)
            
            withAnimation {
                move = data
            }
        }
    }
}

struct MoveInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MoveInfoView(moveUrl: "https://pokeapi.co/api/v2/move/15/")
    }
}
