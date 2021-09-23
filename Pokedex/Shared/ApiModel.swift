//

import Foundation

class ApiModel {
    static let api = ApiModel()
    
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
    
    // get all barries
    func fetchBerries() async -> [BerryModel]? {
        var berries: [BerryModel] = [BerryModel]()
        
        do {
            for i in 1...64 {
                guard let berryData = await request(apiUrl: "https://pokeapi.co/api/v2/berry/\(i)") else {return nil}
                let decodedBerry = try JSONDecoder().decode(Berry.self, from: berryData)
                
                guard let berryItemData = await request(apiUrl: decodedBerry.item.url) else {return nil}
                let decodedBerryItem = try JSONDecoder().decode(BerryItem.self, from: berryItemData)
                
                berries.append(
                    BerryModel(berryItem: decodedBerryItem, berry: decodedBerry)
                )
            }
        }
        catch {
            print(error)
            return nil
        }
        
        return berries
    }
}
