//
//  APIServices.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/26/21.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()

    // Generic newtork function using Alamofire and fixed api key parametere
    
    func getData<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> ()) {
        let apiKey = ["api_key": "72e6acb880560e040496e75062622dc2"]
        
        AF.request(url, method: HTTPMethod.get, parameters: apiKey, encoding: URLEncoding.default, headers: nil).response { response in
      //  AF.request(url).responseJSON { (response) in
            guard let data = response.data else { return }
            switch response.result {
            case .success(_):
                do {
                let results = try JSONDecoder().decode(T.self, from: data)
                  completion(results, nil)

                } catch let error {
                    print (error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

