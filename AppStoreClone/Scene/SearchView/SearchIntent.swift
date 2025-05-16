//
//  SearchIntent.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

protocol SearchIntentProtocol {
    func setSearchBarTerm(_ term: String)
    func setSearchable(_ value: Bool)
    
    func searchApp(_ term: String)
    func setNavigationPath(_ path: [SearchNavigationPath])
    func appendNavigationPath(_ appID: Int)
}

final class SearchIntent: SearchIntentProtocol {
    
    private weak var state: SearchModelActionsProtocol?
    private var appSearchResult: AppStoreSearchDomain?
    
    init(state: SearchModelActionsProtocol) {
        self.state = state
    }
    
    func setSearchBarTerm(_ term: String) {
        state?.presentSearchBarTerm(text: term)
    }
    
    func setSearchable(_ value: Bool) {
        state?.presentSearchable(value)
    }
    
    
    // MARK: 비지니스 로직이 들어감.
    func searchApp(_ term: String) {
        Task {
            let worker = AppStoreSearchWorker()
            let domainData = try await worker.search(term: term)
            self.appSearchResult = domainData
            
            state?.presentSearchApp(appInfo: domainData.results)
        }
    }
    
    func setNavigationPath(_ path: [SearchNavigationPath]) {
        Task {
            state?.presentNavigationPath(path)
        }
    }
    
    
    func appendNavigationPath(_ appID: Int) {
        guard let domain = appSearchResult?.results.filter({ $0.appId == appID }).first else { return }
        let path = SearchNavigationPath.appDetail(data: domain)
        Task {
            state?.presentNavigationPath(path)
        }
    }
}

enum SearchNavigationPath: Hashable {
    case appDetail(data: AppStoreSearchResultDomain)
}
