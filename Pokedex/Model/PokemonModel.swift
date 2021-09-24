//

import Foundation

struct PokemonModel {
    let pokemon: Pokemon
    let abilities: [PokemonAbility]
    let species: PokemonSpecies
}

// ====================

struct Pokemon: Codable {
    let abilities: [Ability]
    let base_experience: Int
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let weight: Int
    let types: [`Type`]
    let stats: [Stat]
    let sprites: Sprites
    let species: Species
    
    struct Species: Codable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable {
        let back_default: String
        let back_shiny: String
        let front_default: String
        let front_shiny: String
        let other: Other
        
        struct Other: Codable {
            let officialArtwork: Artwork
            
            struct Artwork: Codable {
                let front_default: String
            }
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
        }
    }

    struct Stat: Codable {
        let base_stat: Int
        let stat: StatInner
        
        struct StatInner: Codable {
            let name: String
            let url: String
        }
    }
    
    struct `Type`: Codable {
        let type: TypeInner
        
        struct TypeInner: Codable {
            let name: String
            let url: String
        }
    }
    
    struct Move: Codable {
        let move: MoveInner
        
        struct MoveInner: Codable {
            let name: String
            let url: String
        }
    }
    
    struct Ability: Codable {
        let ability: AbilityInner
        
        struct AbilityInner: Codable {
            let name: String
            let url: String
        }
    }
}

// ====================

struct PokemonAbility: Codable {
    let effect_entries: [EffectEntry]
    let name: String
    
    struct EffectEntry: Codable {
        let short_effect: String
    }
}

// ====================

struct PokemonSpecies: Codable {
    let capture_rate: Int
    let color: PokemonColor
    let is_legendary: Bool
    let is_mythical: Bool
    let evolution_chain: Chain

    struct Chain: Codable {
        let url: String
    }
    
    struct PokemonColor: Codable {
        let name: String
    }
}


// ====================

struct EvolutionChain: Codable {
    let chain: Chain
    let evolves_to: [Evolution]
    
    struct Evolution: Codable {
        let species: Species
        let evolves_to: [Evolution]
    }
    
    struct Chain: Codable {
        let species: Species
    }
    
    struct Species: Codable {
        let name: String
    }
}
