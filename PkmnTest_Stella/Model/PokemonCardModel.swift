//
//  PokemonCardModel.swift
//  PkmnTest_Stella
//
//  Created by Stella Patricia on 22/05/21.
//  Copyright © 2021 Stella Patricia. All rights reserved.
//

import Foundation
import ObjectMapper

class PokemonCardModel: Mappable {
    
    var id: String?
    var name: String?
    var supertype: String?
    var subtypes: [String]?
    var level: String?
    var hp: String?
    var types: [String]?
    var evolvesFrom: String?
    var abilities: [AbilityModel]?
    var attacks: [AttackModel]?
    var weaknesses: [WeakResistModel]?
    var resistances: [WeakResistModel]?
    var retreatCost: [String]?
    var convertedRetreatCost: Int?
    var set: SetModel?
    var number: String?
    var artist: String?
    var rarity: String?
    var flavorText: String?
    var nationalPokedexNumbers: [Int]?
    var legalities: LegalityModel?
    var images: ImageModel?
    var tcgplayer: PlayerModel?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map["id"]
        name <- map["name"]
        supertype <- map["supertype"]
        subtypes <- map["subtypes"]
        level <- map["level"]
        hp <- map["hp"]
        types <- map["types"]
        evolvesFrom <- map["evolvesFrom"]
        abilities <- map["abilities"]
        attacks <- map["attacks"]
        weaknesses <- map["weaknesses"]
        resistances <- map["resistances"]
        retreatCost <- map["retreatCost"]
        convertedRetreatCost <- map["convertedRetreatCost"]
        set <- map["set"]
        number <- map["number"]
        artist <- map["artist"]
        rarity <- map["rarity"]
        flavorText <- map["flavorText"]
        nationalPokedexNumbers <- map["nationalPokedexNumbers"]
        legalities <- map["legalities"]
        images <- map["images"]
        tcgplayer <- map["tcgplayer"]
    }
}

class AbilityModel: Mappable {
    
    var name: String?
    var text: String?
    var type: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        name <- map["name"]
        text <- map["text"]
        type <- map["type"]
    }
}

class AttackModel: Mappable {
    
    var name: String?
    var cost: [String]?
    var convertedEnergyCost: String?
    var damage: String?
    var text: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        name <- map["name"]
        cost <- map["cost"]
        convertedEnergyCost <- map["convertedEnergyCost"]
        damage <- map["damage"]
        text <- map["text"]
    }
}

class WeakResistModel: Mappable {
    
    var type: String?
    var value: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        type <- map["type"]
        value <- map["value"]
    }
}

class SetModel: Mappable {

    var id: String?
    var name: String?
    var series: String?
    var printedTotal: String?
    var total: String?
    var legalities: LegalityModel?
    var ptcgoCode: String?
    var releaseDate: String?
    var updatedAt: String?
    var images: LogoModel?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map["id"]
        name <- map["name"]
        series <- map["series"]
        printedTotal <- map["printedTotal"]
        total <- map["total"]
        legalities <- map["legalities"]
        ptcgoCode <- map["ptcgoCode"]
        releaseDate <- map["releaseDate"]
        updatedAt <- map["updatedAt"]
        images <- map["images"]
    }
}

class LegalityModel: Mappable {
    
    var unlimited: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        unlimited <- map["unlimited"]
    }
}

class LogoModel: Mappable {
    
    var symbol: String?
    var logo: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        symbol <- map["symbol"]
        logo <- map["logo"]
    }
}

class ImageModel: Mappable {
    
    var small: String?
    var large: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        small <- map["small"]
        large <- map["large"]
    }
}

class PlayerModel: Mappable {
    
    var url: String?
    var updatedAt: String?
    var prices: PriceModel?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        url <- map["url"]
        updatedAt <- map["updatedAt"]
        prices <- map["prices"]
    }
}

class PriceModel: Mappable {
    
    var holofoil: PriceDetailModel?
    var reverseHolofoil: PriceDetailModel?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        holofoil <- map["holofoil"]
        reverseHolofoil <- map["reverseHolofoil"]
    }
}

class PriceDetailModel: Mappable {
    
    var low: String?
    var mid: String?
    var high: String?
    var market: String?
    var directLow: String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        low <- map["low"]
        mid <- map["mid"]
        high <- map["high"]
        market <- map["market"]
        directLow <- map["directLow"]
    }
}
