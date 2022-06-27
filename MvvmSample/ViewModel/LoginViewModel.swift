//
//  LoginViewModel.swift
//  MvvmSample
//
//  Created by M1086289 on 07/06/22.
//

import UIKit
typealias CompletionHandler = (Swift.Result<Bool, Error>) -> Void

enum NetworkError: Error {
    case couldNotConnectServer
    case invalidResponse
    case badRequest
    case unknownError
    case invalidURL
}



class LoginViewModel {
    private let networkManager = NetworkManager()
    
    //MARK: - Public
    func signIn(username: String, password: String, completionHandler: @escaping CompletionHandler) {
        guard let url = URL(string: Constants.baseurl) else {
            completionHandler(.failure(NetworkError.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        networkManager.fetchData(for: request) { result in
            switch result {
            case .success(let responsedata):
                let result = self.validateResponse(email: username, password: password)
                completionHandler(.success(result))
//                do {
//                    let userdata = try JSONDecoder().decode(UserData.self, from: responsedata)
//                    completionHandler(.success(true))
//                    print(userdata)
//                }
//                catch {
//                    completionHandler(.failure(NetworkError.invalidResponse))
//                }
            
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    //MARK: - Private Functions
    private func validateResponse(email: String, password: String) -> Bool {
        if email == "sk123@gmail.com" && password == "Sk@123" {
            return true
        } else {
            return false
        }
        
    }
}
