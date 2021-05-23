//
//  PokemonCardListPresenter.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

class PokemonCardPresenter: PokemonCardViewToPresenterProtocol {
    var view: PokemonCardPresenterToViewProtocol?
    var interactor: PokemonCardPresenterToInteractorProtocol?
    var router: PokemonCardPresenterToRouterProtocol?
    
    func startFetchingData(page: Int, query: String) {
        interactor?.fetchData(page: page, query: query)
    }
}

extension PokemonCardPresenter: PokemonCardInteractorToPresenterProtocol{
    func dataFetchedSuccess(dataArray: Array<PokemonCardModel>) {
        view?.showData(array: dataArray)
    }
    
    func dataFetchFailed() {
        view?.showError()
    }
}
