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
            guard let berriesListData = await request(apiUrl: "https://pokeapi.co/api/v2/berry?limit=64") else {return nil}
            let decodedBerriesList = try JSONDecoder().decode(AllListModel.self, from: berriesListData)
            
            for berry in decodedBerriesList.results {
                guard let berryData = await request(apiUrl: berry.url) else {return nil}
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
    
    // get all items
    func fetchItems(limit: Int, page: Int) async -> [ItemModel]? {
        var items: [ItemModel] = [ItemModel]()
        
        do {
            guard let itemsListData = await request(apiUrl: "https://pokeapi.co/api/v2/item?limit=\(limit)&offset=\(page*limit)") else {return nil}
            let decodedItemsList = try JSONDecoder().decode(AllListModel.self, from: itemsListData)
            
            for item in decodedItemsList.results {
                guard let itemData = await request(apiUrl: item.url) else {return nil}
                let decodedItemData = try JSONDecoder().decode(Item.self, from: itemData)
                
                items.append(
                    ItemModel(item: decodedItemData)
                )
            }
        }
        catch {
            print(error)
            return nil
        }
        
        return items
    }
}
