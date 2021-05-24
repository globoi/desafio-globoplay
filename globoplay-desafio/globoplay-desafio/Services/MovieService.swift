//
//  MovieService.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import Foundation

class MovieService: ServiceBase {
    
    func fetch (path: MovieCategory, completionHandler: @escaping (Result<MovieResponse, FetchError>) -> Void) {
        
        fetch(listOf: MovieResponse.self, withURL: url(withPath: path.rawValue)) { (result) in
            switch result {
            case .success(let movies):
                completionHandler(Result.success(movies))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
            
        }
    }
}
