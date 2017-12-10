//
//  APNetworkManager.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 11/18/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import SwiftyJSON

enum APHttpMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

final class APNetworkManager {
    
    static let baseURL = "http://env-monitor-stage-1163794038.ap-southeast-1.elb.amazonaws.com"
    
    static func request(url: String, method: APHttpMethod = .get, params: [String: AnyObject]? = nil, completion: @escaping (JSON, HTTPURLResponse?, Error?) -> ()) {
        guard let url = URL(string: url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest = encode(urlRequest, method: method, with: params)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    completion(JSON(data), response as? HTTPURLResponse, error)
                }
                completion(JSON([:]), response as? HTTPURLResponse, error)
            }
            
        }
    }
    
    private static func encode(_ urlRequest: URLRequest, method: APHttpMethod, with parameters: [String: AnyObject]?) -> URLRequest {
        guard let parameters = parameters else { return urlRequest }
        var encodedRequest = urlRequest
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        encodedRequest.httpBody = jsonData
        encodedRequest.httpMethod = method.rawValue
        return encodedRequest
    }

    
}
