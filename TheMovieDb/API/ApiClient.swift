//
//  ApiClient.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 21/01/22.
//

import NetworkLayer

final class ApiClient {
    
    static let shared = ApiClient(baseUrl: URL(string: AppConstants.API.baseURL))
    
    public let networkClient: NetworkClient?
    
    public init(baseUrl: URL?) {
        if let base = baseUrl {
            networkClient = NetworkClient(baseURL: base)
        } else {
            networkClient = nil
        }
    }
}
