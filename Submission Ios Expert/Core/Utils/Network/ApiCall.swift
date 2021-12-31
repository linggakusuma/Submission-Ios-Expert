//
//  ApiCall.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation

struct ApiCall {
  static let baseUrl = "https://api.rawg.io/api/"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case games
    case detail
    
    var url: String{
      switch self {
      case .games: return "\(ApiCall.baseUrl)games?key=3cc4846006ef4df399de0b6f7a3a2892"
      case .detail: return "\(ApiCall.baseUrl)games/"
      }
    }
    
  }
}
