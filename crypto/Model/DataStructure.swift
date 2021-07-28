//
//  DataStructure.swift
//  crypto
//
//  Created by Samsud Dhuha on 27/07/21.
//

import Foundation


struct DataCrypto: Decodable{
    var CoinInfo: CoinInfo?
    var DISPLAY: Display?
}

struct CoinInfo: Decodable {
    var FullName, Name: String?
}

struct Display: Decodable {
    var USD: Usd?
}

struct Usd: Decodable {
    var PRICE, CHANGEPCTDAY, CHANGEPCTHOUR, CHANGEPCT24HOUR: String?
}


struct DataNews: Decodable {
    var body, title: String?
    var source_info: SourceInfo?
}

struct SourceInfo: Decodable {
    var name: String?
}

