//
//  URLSessionDataTaskProtocol.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
