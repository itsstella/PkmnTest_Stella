//
//  PokemonCardDetailRouter.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 23/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import UIKit

class PokemonCardDetailRouter: PokemonCardDetailPresenterToRouterProtocol {
    static func initPresenter(vc: PokemonCardDetail) -> PokemonCardDetailViewToPresenterProtocol {
        let presenter: PokemonCardDetailViewToPresenterProtocol & PokemonCardDetailInteractorToPresenterProtocol = PokemonCardDetailPresenter()
        let interactor: PokemonCardDetailPresenterToInteractorProtocol = PokemonCardDetailInteractor()
        let router: PokemonCardDetailPresenterToRouterProtocol = PokemonCardDetailRouter()
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return presenter
    }
}
