//

import Foundation

struct ItemModel: Codable {
    let category: Category
    let cost: Int
    let effect_entries: [EffectEntry]
    let id: Int
    let name: String
    let sprites: Sprite
    
    struct Sprite: Codable {
        let `default`: String
    }
    
    struct Category: Codable {
        var name: String
    }
    
    struct EffectEntry: Codable {
        let short_effect: String
    }
}
