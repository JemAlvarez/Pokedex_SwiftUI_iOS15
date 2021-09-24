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
}
