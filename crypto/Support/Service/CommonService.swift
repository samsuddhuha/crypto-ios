//
//  CommonService.swift
//  crypto
//
//  Created by Samsud Dhuha on 27/07/21.
//

import Foundation
import Moya
import SwiftyJSON

enum Common: Equatable {
    case topListCrypto
    case news(categories: String)
}

let commonClosure = { (target: Common) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    switch target {
    case .topListCrypto, .news:
        return defaultEndpoint
//        return defaultEndpoint.adding(newHTTPHeaderFields: ["authorization" : API_KEY])
    }
}

let commonService = MoyaProvider<Common>(endpointClosure: commonClosure)

extension Common: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .topListCrypto:
            return "top/totaltoptiervolfull"
        case .news:
            return "v2/news/"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var data = [String:Any]()
        
        switch self {
        case .topListCrypto:
            data["limit"] = 50
            data["tsym"] = "USD"
            
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
            
        case .news(let categories):
            data["categories"] = categories
            
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
