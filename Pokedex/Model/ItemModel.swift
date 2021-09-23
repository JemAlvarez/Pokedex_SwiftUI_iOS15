//

import Foundation

struct ItemModel: Identifiable {
    let item: Item
    var id: Int {
        item.id
    }
    var category: String {
        item.category.name.splitWord()
    }
    var name: String {
        item.name.splitWord()
    }
}

// ==============================

struct Item: Codable {
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
