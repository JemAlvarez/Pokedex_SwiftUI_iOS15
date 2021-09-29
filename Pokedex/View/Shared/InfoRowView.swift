//

import SwiftUI

struct InfoRowView: View {
    let title: String
    let value: String
    var divider = true
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .bold()
                Spacer()
                Text(value)
                    .opacity(0.5)
            }
            
            if divider {
                Divider()
            }
        }
    }
}

struct InfoViewRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(title: "Accuracy", value: "100")
    }
}
