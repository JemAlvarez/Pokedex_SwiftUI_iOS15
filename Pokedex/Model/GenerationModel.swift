//

import Foundation

struct GenerationModel: Codable {
    let main_region: Region
    var pokemon_species: [Pokemon]
    
    struct Region: Codable {
        let name: String
    }
    
    struct Pokemon: Codable {
        let name: String
        let url: String
        
        func getPokemonId() -> String {
            let slashComponents = self.url.components(separatedBy: "/")
            let pokemonId = slashComponents[slashComponents.count - 2]
            
            return pokemonId
        }
        
        func getImageUrl(_ shiny: Bool = false) -> String {
            let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
            
            return "\(url)\(shiny ? "shiny/" : "")\(self.getPokemonId()).png"
        }
        
        
    }
}
