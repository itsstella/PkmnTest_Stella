//
//  PokemonCardListRouter.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

class PokemonCardRouter: PokemonCardPresenterToRouterProtocol {
    static func initPresenter(vc: ViewController) -> PokemonCardViewToPresenterProtocol {
        let presenter: PokemonCardViewToPresenterProtocol & PokemonCardInteractorToPresenterProtocol = PokemonCardPresenter()
        let interactor: PokemonCardPresenterToInteractorProtocol = PokemonCardInteractor()
        let router: PokemonCardPresenterToRouterProtocol = PokemonCardRouter()
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return presenter
    }
}
