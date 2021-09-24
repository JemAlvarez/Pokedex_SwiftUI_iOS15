//

import Foundation

struct AllListModel: Codable {
    let count: Int
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}
