//
//  APIClient.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import Foundation
import Alamofire

class APIClient: NSObject{
    
    static let sharedInstance = APIClient()
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetchVehicles(completion: @escaping ([Vehicle]?) -> Void){
        let url = "https://gist.githubusercontent.com/pstued/c6396805c6771f33eb2a694f0c4d7c97/raw/4c492a1dbb46c0a717feb2a8ba1f60e134db7659/vehicles.json"
        AF.request(url,encoding: JSONEncoding.default).responseDecodable(of: [Vehicle].self) {
            response in
               switch response.result {
            case let .success(result):
                completion(result)
               case let .failure(error):
                print(error)
                completion(nil)
            }
        }
    }
}
