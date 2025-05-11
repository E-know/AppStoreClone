//
//  CustomProvider.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation
import Moya

final class CustomProvider: MoyaProvider<MultiTarget> {
    enum ProviderType {
        case live
        case stubbing
    }
    
    convenience init(type: ProviderType = .live, plugins: [PluginType] = [], timeoutInterval: TimeInterval) {
        let stubClosure: MoyaProvider<MultiTarget>.StubClosure
        switch type {
            case .live:
                stubClosure = MoyaProvider.neverStub
            case .stubbing:
                stubClosure = MoyaProvider.immediatelyStub
        }
        
        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = timeoutInterval
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }
        
        var unionPlugins: [PluginType] = [] // TODO: 나중에 추가 하려면 추가해도 될듯?
        unionPlugins.append(contentsOf: plugins)
        
        self.init(endpointClosure: MoyaProvider.defaultEndpointMapping,
                  requestClosure: requestClosure,
                  stubClosure: stubClosure,
                  callbackQueue: nil,
                  session: Session(configuration: URLSessionConfiguration.default),
                  plugins: unionPlugins,
                  trackInflights: false
        )
    }
    
    func request(_ target: Target) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(target) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
