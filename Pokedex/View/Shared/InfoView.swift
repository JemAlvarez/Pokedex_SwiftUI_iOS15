//

import SwiftUI

struct InfoView<Icon: View, Content: View, Background: View>: View {
    @ViewBuilder let background: Background
    @ViewBuilder let icon: Icon
    @ViewBuilder let content: Content
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.title2)
                    .padding(15)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .onTapGesture {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
            ZStack (alignment: .top) {
                VStack {
                    content
                        .padding(.top, 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
                .background(.ultraThinMaterial)
                .cornerRadius(50)
                .edgesIgnoringSafeArea(.all)
                
                icon
                    .frame(width: 100, height: 100)
                    .offset(y: -50)
            }
            .padding(.top, 100)
        }
        .padding(.top)
        .background(background)
        .edgesIgnoringSafeArea(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView() {
            BackgroundView()
        } icon: {
            Image("placeholder")
                .resizable()
                .scaledToFit()
                .padding(25)
                .background(
                    Color.blue
                        
                )
                .clipShape(Circle())
        } content: {
            VStack {
                Text("C")
                
                Spacer()
            }
        }
    }
}
