//
//  NetworkService.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation
import Moya

enum NetworkError: Error {
    case parsingError
    case moyaError(String)
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(target: TargetType) async throws(NetworkError) -> T
}

struct NetworkService: NetworkServiceProtocol {
    private let provider: CustomProvider
    
    init(providerType: CustomProvider.ProviderType = .live, timeoutInterval: TimeInterval = 60.0) {
        self.provider = CustomProvider(type: providerType, timeoutInterval: timeoutInterval)
    }
    
    func request<T: Decodable>(target: TargetType) async throws(NetworkError) -> T {
        let result = await provider.request(MultiTarget(target))
        
        switch result {
            case .success(let response):
                guard let parsed = try? JSONDecoder().decode(T.self, from: response.data) else {
                    throw NetworkError.parsingError
                }
                return parsed
            case .failure(let error):
                throw NetworkError.moyaError(error.localizedDescription)
        }
    }
}
