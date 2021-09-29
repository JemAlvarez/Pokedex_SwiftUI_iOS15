//

import Foundation

class ApiModel {
    static let api = ApiModel()
    
    // request type enum
    enum RequestType {
        case berries
        case items
        case moves
    }
    
    // request
    private func request(apiUrl: String) async -> Data? {
        guard let url = URL(string: apiUrl) else { return nil}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        catch {
            return nil
        }
    }
    
    // get all list
    func fetchAllList(_ requestType: RequestType) async -> AllListModel? {
        var url = ""
        
        switch requestType {
        case .berries:
            url = "https://pokeapi.co/api/v2/berry?limit=64"
        case .items:
            url = "https://pokeapi.co/api/v2/item?limit=954"
        case .moves:
            url = "https://pokeapi.co/api/v2/move?limit=844"
        }
        
        do {
            guard let listData = await request(apiUrl: url) else {return nil}
            let decodedList = try JSONDecoder().decode(AllListModel.self, from: listData)
            
            return decodedList
        }
        catch {
            print(error)
            return nil
        }
    }
    
    // get all generation pokemons
    func fetchGeneration(gen: Int) async -> GenerationModel? {
        do {
            guard let generationData = await request(apiUrl: "https://pokeapi.co/api/v2/generation/\(gen)") else {return nil}
            var decodedGeneration = try JSONDecoder().decode(GenerationModel.self, from: generationData)
            decodedGeneration.pokemon_species = decodedGeneration.pokemon_species.sorted { Int($0.getPokemonId()) ?? 0 < Int($1.getPokemonId()) ?? 0 }
            
            return decodedGeneration
        }
        catch {
            print(error)
            return nil
        }
    }
    
    // get single berry
    func fetchBerry(_ url: String) async -> BerryModel? {
        do {
            // get berry info
            guard let berryData = await request(apiUrl: url) else {return nil}
            let decodedBerry = try JSONDecoder().decode(Berry.self, from: berryData)
            
            // get berry item info
            guard let berryItemData = await request(apiUrl: decodedBerry.item.url) else {return nil}
            let decodedBerryItem = try JSONDecoder().decode(BerryItem.self, from: berryItemData)
            
            return BerryModel(berryItem: decodedBerryItem, berry: decodedBerry)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    // get single item
    func fetchItem(_ url: String) async -> ItemModel? {
        do {
            guard let itemData = await request(apiUrl: url) else {return nil}
            let decodedItem = try JSONDecoder().decode(ItemModel.self, from: itemData)
            
            return decodedItem
        }
        catch {
            print(error)
            return nil
        }
    }
    
    // get single move
    func fetchMove(_ url: String) async -> MoveModel? {
        do {
            guard let moveData = await request(apiUrl: url) else {return nil}
            let decodedMove = try JSONDecoder().decode(MoveModel.self, from: moveData)
            
            return decodedMove
        }
        catch {
            print(error)
            return nil
        }
    }
    
    // get single pokemon
    func fetchPokemon(_ name: String) async -> PokemonModel? {
        do {
            // get pokemon info
            guard let pokemonData = await request(apiUrl: "https://pokeapi.co/api/v2/pokemon/\(name)") else {return nil}
            let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: pokemonData)
            
            // get pokemon abilities
            var abilities: [PokemonAbility] = [PokemonAbility]()
            for ability in decodedPokemon.abilities {
                guard let abilitiesData = await request(apiUrl: ability.ability.url) else {return nil}
                let decodedAbility = try JSONDecoder().decode(PokemonAbility.self, from: abilitiesData)
                
                abilities.append(decodedAbility)
            }
            
            // get pokemon species info
            guard let pokemonSpeciesData = await request(apiUrl: decodedPokemon.species.url) else {return nil}
            let decodedPokemonSpecies = try JSONDecoder().decode(PokemonSpecies.self, from: pokemonSpeciesData)
            
            // get evolution chain
            guard let evolutionData =  await request(apiUrl: decodedPokemonSpecies.evolution_chain.url) else {return nil}
            let decodedEvolution = try JSONDecoder().decode(EvolutionChain.self, from: evolutionData)
            
            return PokemonModel(pokemon: decodedPokemon, abilities: abilities, species: decodedPokemonSpecies, evolutionChain: decodedEvolution)
        }
        catch {
            print(error)
            return nil
        }
    }
}
