//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color("limeGreen"), Color("splashColor")], startPoint: .trailing, endPoint: .leading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
