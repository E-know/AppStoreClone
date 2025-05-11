//
//  AppStoreSearchWorker.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import Foundation
import Moya

struct AppStoreSearchWorker {
    private let repository: AppStoreSearchRepositoryProtocol
    
    init(repository: AppStoreSearchRepositoryProtocol = AppStoreSearchRepository()) {
        self.repository = repository
    }
    
    func search(term: String) async throws -> AppStoreSearchDomain {
        let domainData = try await repository.search(term: term)
        return domainData
    }
}
