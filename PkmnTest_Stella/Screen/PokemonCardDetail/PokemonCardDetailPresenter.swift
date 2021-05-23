//
//  PokemonCardDetailPresenter.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 23/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

class PokemonCardDetailPresenter: PokemonCardDetailViewToPresenterProtocol {
    var view: PokemonCardDetailPresenterToViewProtocol?
    var interactor: PokemonCardDetailPresenterToInteractorProtocol?
    var router: PokemonCardDetailPresenterToRouterProtocol?
    
    func startFetchingData(page: Int, subtype: [String], types: [String]) {
        interactor?.fetchData(page: page, subtype: subtype, types: types)
    }
}

extension PokemonCardDetailPresenter: PokemonCardDetailInteractorToPresenterProtocol{
    func dataFetchedSuccess(dataArray: Array<PokemonCardModel>) {
        view?.showData(array: dataArray)
    }
    
    func dataFetchFailed() {
        view?.showError()
    }
}
