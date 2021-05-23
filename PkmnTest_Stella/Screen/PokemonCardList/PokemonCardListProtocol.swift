//
//  PokemonCardListProtocol.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

protocol PokemonCardViewToPresenterProtocol: class{
    
    var view: PokemonCardPresenterToViewProtocol? {get set}
    var interactor: PokemonCardPresenterToInteractorProtocol? {get set}
    var router: PokemonCardPresenterToRouterProtocol? {get set}
    func startFetchingData(page: Int, query: String)
}

protocol PokemonCardPresenterToViewProtocol: class{
    func showData(array:Array<PokemonCardModel>)
    func showError()
}

protocol PokemonCardPresenterToRouterProtocol: class {
    static func initPresenter(vc: ViewController) -> PokemonCardViewToPresenterProtocol

}

protocol PokemonCardPresenterToInteractorProtocol: class {
    var presenter: PokemonCardInteractorToPresenterProtocol? {get set}
    func fetchData(page: Int, query: String)
}

protocol PokemonCardInteractorToPresenterProtocol: class {
    func dataFetchedSuccess(dataArray:Array<PokemonCardModel>)
    func dataFetchFailed()
}
