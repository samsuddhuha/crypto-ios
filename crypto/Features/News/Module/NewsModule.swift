//
//  NewsModule.swift
//  crypto
//
//  Created by Samsud Dhuha on 28/07/21.
//

import Foundation
import SwiftyJSON
import iOSNFramework

protocol NewsDelegate {
    func news(categories: String)
}

class NewsModule: ModuleDelegate, NewsDelegate {
    
    let TAG_NEWS = "TAG-NEWS"
    
    override init(viewStateDelegate: ViewStateDelegate, controller: UIViewController) {
        super.init(viewStateDelegate: viewStateDelegate, controller: controller)
    }
    
    func news(categories: String) {
        self.network.networkConfiguration(tag: TAG_NEWS)
        self.network.onLoading(isLoading: true, message: "")

        commonService.request(Common.news(categories: categories), completion: {result in switch result {

        case .success(let response):
            self.network.onLoading(isLoading: false, message: "")
            let data = JSON.init(response.data)

            do {
                _ = try response.filterSuccessfulStatusCodes()
                switch data[KEY_TYPE] {
                case 100:
                    print(data)
                    let dataMap = try JSONDecoder().decode([DataNews].self, from: data[KEY_DATA].rawData())
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
