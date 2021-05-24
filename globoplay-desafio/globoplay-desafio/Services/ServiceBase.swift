//
//  ServiceBase.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import Foundation

class ServiceBase {
    
    //MARK:- Properties
    var session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    internal var parameters: String {
        return "?" + ServiceParameters.apiKey + "=" + Keys.privateKey + "&" + ServiceParameters.language + "=" + Keys.language
    }
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getParameters() -> String {
        return parameters
    }
    
    internal func url(withPath path: String) -> URL? {
        return URL(string: Service.baseURL + path
            + parameters)
    }
    
    func fetch<T: Decodable>(listOf representable: T.Type,
                             withURL url: URL?,
                             completionHandler: @escaping (Result<T, FetchError>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        task = session.data(with: url) { (data, response, error) -> Void in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkFailed))
                }
                return
            }
            
            guard let dataResponse = data,
                  error == nil else {
              print(error?.localizedDescription ?? "Response Error")
              return
            }
            
            do {
                let decoder = JSONDecoder()
                let resultValue = try decoder.decode(T.self, from: dataResponse)
                DispatchQueue.main.async {
                    completionHandler(.success(resultValue))
                }
            } catch let parsingError {
                print("Error", parsingError)
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidJSON))
                }
            }
    
        }
        task?.resume()
    }
    
    internal func cancel() {
        task?.cancel()
    }
    
}
