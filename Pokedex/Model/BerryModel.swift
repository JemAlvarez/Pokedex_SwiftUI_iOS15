//

import Foundation


struct BerryModel {
    var berryItem: BerryItem
    var berry: Berry
}

// ---------------------------------------

struct Berry: Codable {
    let firmness: Firmness
    let flavors: [Flavor]
    let growth_time: Int // hours
    let max_harvest: Int
    let size: Int // milimeter
    let smoothness: Int
    let soil_dryness: Int
    let id: Int
    let item: Item
    
    struct Flavor: Codable {
        let flavor: FlavorInner
        let potency: Int
    }

    struct FlavorInner: Codable {
        let name: String
    }

    struct Firmness: Codable {
        let name: String
    }

    struct Item: Codable {
        let url: String
    }
}

// ---------------------------------------

struct BerryItem: Codable {
    let cost: Int
    let effect_entries: [EffectEntry]
    var name: String
    let sprites: Sprite
    let category: Category
    
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
