//

import Foundation

struct PokemonEvolution: Identifiable {
    let id = UUID()
    let pokemonName: String
    let pokemonId: Int
    let level: Int
}

// =============

struct PokemonModel {
    let pokemon: Pokemon
    let abilities: [PokemonAbility]
    let species: PokemonSpecies
    let evolutionChain: EvolutionChain
    var evolutions: [PokemonEvolution] {
        var evolution: EvolutionChain.Chain? = nil
        var evolutions: [PokemonEvolution] = []
        
        // first evolution
        let basePokemon = PokemonEvolution(pokemonName: self.evolutionChain.chain.species.name, pokemonId: self.evolutionChain.chain.species.getIdFromUrl(), level: 0)
        evolutions.append(basePokemon)
        
        if !self.evolutionChain.chain.evolves_to.isEmpty {
            // second evolution
            evolution = self.evolutionChain.chain.evolves_to[0]
            let secondEvolution = PokemonEvolution(pokemonName: evolution!.species.name, pokemonId: evolution!.species.getIdFromUrl(), level: evolution!.evolution_details[0].min_level)
            evolutions.append(secondEvolution)

            // subsequent evolutions
            while !evolution!.evolves_to.isEmpty {
                evolution = evolution!.evolves_to[0]
                let subsequentEvolution = PokemonEvolution(pokemonName: evolution!.species.name, pokemonId: evolution!.species.getIdFromUrl(), level: evolution!.evolution_details[0].min_level)
                evolutions.append(subsequentEvolution)
            }
        }
        
        return evolutions
    }
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
    let flavor_text_entries: [FlavorText]
    
    struct FlavorText: Codable {
        let flavor_text: String
    }

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
    
    struct Chain: Codable {
        let evolution_details: [EvolutionsDetails]
        let species: Species
        let evolves_to: [Chain]
        
        struct EvolutionsDetails: Codable {
            let min_level: Int
        }
    }
}

struct Species: Codable {
    let name: String
    let url: String
    
    func getIdFromUrl() -> Int {
        let id = url.dropLast().components(separatedBy: "/").last ?? "0"
        return Int(id) ?? 0
    }
}
