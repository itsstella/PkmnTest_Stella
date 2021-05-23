//
//  PokemonCardDetailProtocol.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 23/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

protocol PokemonCardDetailViewToPresenterProtocol: class{
    
    var view: PokemonCardDetailPresenterToViewProtocol? {get set}
    var interactor: PokemonCardDetailPresenterToInteractorProtocol? {get set}
    var router: PokemonCardDetailPresenterToRouterProtocol? {get set}
    func startFetchingData(page: Int, subtype: [String], types: [String])
}

protocol PokemonCardDetailPresenterToViewProtocol: class{
    func showData(array:Array<PokemonCardModel>)
    func showError()
}

protocol PokemonCardDetailPresenterToRouterProtocol: class {
    static func initPresenter(vc: PokemonCardDetail) -> PokemonCardDetailViewToPresenterProtocol

}

protocol PokemonCardDetailPresenterToInteractorProtocol: class {
    var presenter: PokemonCardDetailInteractorToPresenterProtocol? {get set}
    func fetchData(page: Int, subtype: [String], types: [String])
}

protocol PokemonCardDetailInteractorToPresenterProtocol: class {
    func dataFetchedSuccess(dataArray:Array<PokemonCardModel>)
    func dataFetchFailed()
}
