//
//  PokemonCardListInteractor.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class PokemonCardInteractor: PokemonCardPresenterToInteractorProtocol{
    var presenter: PokemonCardInteractorToPresenterProtocol?

    func fetchData(page: Int, query: String) {
        var url = "https://api.pokemontcg.io/v2/cards?pageSize=20&page="+String(page)
        if query != "" {
            url = "https://api.pokemontcg.io/v2/cards?pageSize=20&page="+String(page)+"&q=name:"+query
        }

        let request = AF.request(url)
        
        request.responseJSON { (data) in
            switch data.result {
            case .success(let value):
                print(value)
                if let json = data.value as AnyObject? {
                    let arrayResponse = json["data"] as? NSArray
                    let arrayObject = Mapper<PokemonCardModel>().mapArray(JSONArray: arrayResponse as? [[String : Any]] ?? []);
                    self.presenter?.dataFetchedSuccess(dataArray: arrayObject)
                }
            case .failure(let error):
                print(error)
                self.presenter?.dataFetchFailed()
            }
        }
        
    }
}
