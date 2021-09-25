//

import Foundation

extension String {
    func splitWord() -> String {
        let components = self.components(separatedBy: "-")
        var tempName = ""
        for word in components {
            tempName += word.capitalized + " "
        }
        return tempName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
