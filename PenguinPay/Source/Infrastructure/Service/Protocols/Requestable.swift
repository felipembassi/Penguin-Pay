//
//  Requestable.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol Requestable {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

extension Requestable {
    var baseURL: URL {
        guard let url = URL(string: Constants.Endpoints.baseUrl) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var parameters: [String: Any] {
        let dictionary = Bundle.main.infoDictionary
        if let key = dictionary?["Open Exchange Key"] as? String {
            return ["app_id": key]
        }
        return [:]
    }
}
