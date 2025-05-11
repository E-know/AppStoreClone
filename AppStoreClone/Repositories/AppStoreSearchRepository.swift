//
//  AppStoreSearchRepository.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

protocol AppStoreSearchRepositoryProtocol {
    func search(term: String) async throws -> AppStoreSearchDomain
}

struct AppStoreSearchRepository: AppStoreSearchRepositoryProtocol {
    private let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func search(term: String) async throws(NetworkError) -> AppStoreSearchDomain {
        let entity: AppStoreSearchEntity = try await service.request(target: AppStoreSearchAPI.search(term: term))
        return entity.toDomain()
    }
}
