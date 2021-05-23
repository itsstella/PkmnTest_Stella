//
//  PokemonCardDetailInteractor.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 23/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class PokemonCardDetailInteractor: PokemonCardDetailPresenterToInteractorProtocol{
    var presenter: PokemonCardDetailInteractorToPresenterProtocol?

    func fetchData(page: Int, subtype: [String], types: [String]) {
        
        var url = "https://api.pokemontcg.io/v2/cards?pageSize=10&page="+String(page)
        url += "&q=subtypes:" + subtype[0] + " -types:" + types[0]
        
        url = url.replacingOccurrences(of: " ", with: "%20")


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
