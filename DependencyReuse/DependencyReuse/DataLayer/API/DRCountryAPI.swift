//
//  DRCountryAPI.swift
//  DependencyReuse
//
//  Created by Maulana Frasha on 01/07/22.
//

import Foundation
import Alamofire

class CountryAPI{
    
    func getCountryName(completionHandler: @escaping (Result<[CountryResponseModel], AFError>) -> Void){
        let url = "https://restcountries.com/v2/all?fields=name"
        let headers: HTTPHeaders = [.contentType("application/json")]
        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: [CountryResponseModel].self) { response in
            completionHandler(response.result)
        }
    }
    
}
