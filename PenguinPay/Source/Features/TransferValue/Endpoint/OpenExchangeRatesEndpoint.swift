//
//  OpenExchangeRatesEndpoint.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

enum OpenExchangeRatesEndpoint {
    case rates
}

extension OpenExchangeRatesEndpoint: Requestable {
    var path: String {
        Constants.Endpoints.openExchangeRates
    }
    
    var httpMethod: HTTPMethod {
        .GET
    }
}
