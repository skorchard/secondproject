//
//  NetworkManager.swift
//  MvvmSample
//
//  Created by M1086289 on 08/06/22.
//

import Foundation
typealias NetworkManagerCompletionHandler = (Swift.Result<Data, Error>) -> Void

class NetworkManager {
    
    func fetchData(for request: URLRequest, completionHandler: @escaping NetworkManagerCompletionHandler) {
        let datatask = URLSession.shared.dataTask(with: request) { data, response, error in
//             guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
//                 completionHandler(.failure(NetworkError.couldNotConnectServer))
//                 return }
            // line 19,20,21 are not required while performing actual API Call
            let testdata = Data("test".utf8)
            completionHandler(.success(testdata))
            return
            switch (data,error) {
            case (.some(let resposedata), .none ) :
                completionHandler(.success(resposedata))
            case (.none, .some(let error)):
                completionHandler(.failure(error))
            default:
                completionHandler(.failure(NetworkError.unknownError))
            }
        }
        datatask.resume()
    }
}
