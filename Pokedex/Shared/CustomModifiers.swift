//

import SwiftUI

struct SwipeToPop: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.startLocation.x < 40 {
                            withAnimation {
                                offset = gesture.translation.width
                            }
                        }
                    }
                    .onEnded { gesture in
                        if gesture.startLocation.x < 40 && gesture.translation.width > 100 {
                            presentationMode.wrappedValue.dismiss()
                        }
                        withAnimation {
                            offset = 0
                        }
                    }
            )
    }
}

struct InfoRoundedStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical, 10)
    }
}
