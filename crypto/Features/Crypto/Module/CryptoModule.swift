//
//  CryptoModule.swift
//  crypto
//
//  Created by Samsud Dhuha on 27/07/21.
//

import Foundation
import SwiftyJSON
import iOSNFramework

protocol CryptoDelegate {
    func topListCrypto()
}

class CryptoModule: ModuleDelegate, CryptoDelegate {
    
    let TAG_TOP_CRYPTO = "TAG-TOP-CRYPTO"
    
    override init(viewStateDelegate: ViewStateDelegate, controller: UIViewController) {
        super.init(viewStateDelegate: viewStateDelegate, controller: controller)
    }
    
    func topListCrypto() {
        self.network.networkConfiguration(tag: TAG_TOP_CRYPTO)
        self.network.onLoading(isLoading: true, message: "")

        commonService.request(Common.topListCrypto, completion: {result in switch result {

        case .success(let response):
            self.network.onLoading(isLoading: false, message: "")
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()
                switch data[KEY_TYPE] {
                case 100:
                    print(data)
                    let dataMap = try JSONDecoder().decode([DataCrypto].self, from: data[KEY_DATA].rawData())
                    self.network.onSucess(data: dataMap, message: data[KEY_MESSAGE].stringValue)
                default:
                    print(data)
                    self.network.onFailure(data: data[KEY_TYPE].stringValue, message: data[KEY_MESSAGE].stringValue)
                }

            } catch {
                self.network.onLoading(isLoading: false, message: "")
                self.network.onFailure(data: data[KEY_TYPE].stringValue, message: data[KEY_MESSAGE].stringValue)
            }

        case .failure(_):
            self.network.onLoading(isLoading: false, message: "")
            self.network.onFailure(data: "", message: ERROR_MESSAGE)
        }})
    }
    
}
