//

import Foundation


struct BerryModel: Identifiable {
    var id: Int {
        berry.id
    }
    var berryItem: BerryItem
    var berry: Berry
    var name: String {
        berryItem.name.splitWord()
    }
    var firmness: String {
        berry.firmness.name.splitWord()
    }
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
}

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

// ---------------------------------------

struct BerryItem: Codable {
    let cost: Int
    let effect_entries: [EffectEntry]
    var name: String
    let sprites: Sprite
}

struct Sprite: Codable {
    let `default`: String
}

struct EffectEntry: Codable {
    let short_effect: String
}
