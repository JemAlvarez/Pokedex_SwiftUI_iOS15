//

import Foundation

struct MoveModel: Identifiable {
    var id: Int {
        move.id
    }
    let move: Move
}

// ========================

struct Move: Codable {
    let accuracy: Int?
    let damage_class: DamageClass
    let effect_entries: [EffectEntry]
    let id: Int
    let learned_by_pokemon: [Pokemon]
    let name: String
    let power: Int?
    let pp: Int
    let priority: Int
    let type: MoveType
    
    struct MoveType: Codable {
        let name: String
    }
    
    struct Pokemon: Codable {
        let name: String
        let url: String
    }
    
    struct DamageClass: Codable {
        let name: String
    }
    
    struct EffectEntry: Codable {
        let short_effect: String
    }
}
