//
//  URLSessionProtocol.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Swift.Void

protocol URLSessionProtocol {
    func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol

}

extension URLSession: URLSessionProtocol {
    internal func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}
