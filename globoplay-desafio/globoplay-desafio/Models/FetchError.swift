//
//  FetchError.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import Foundation

enum FetchError: Error {
    case invalidJSON
    case invalidURL
    case networkFailed
    case limite
}
