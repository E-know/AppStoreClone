//
//  SearchState.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/11/25.
//

import SwiftUI

protocol SearchModelStateProtocol {
    var textTerm: String { get }
    var searchable: Bool { get }
    var appInfo: [AppStoreSearchResultViewModel] { get }
}


protocol SearchModelActionsProtocol: AnyObject {
    func presentSearchBarTerm(text: String?)
    func presentSearchable(_ value: Bool)
    
    func presentSearchApp(appInfo: [AppStoreSearchResultDomain])
}

@Observable
final class SearchState: SearchModelStateProtocol, SearchModelActionsProtocol {
    var textTerm: String = ""
    var searchable: Bool = false
    var appInfo: [AppStoreSearchResultViewModel] = []

    
    func presentSearchBarTerm(text: String?) {
        textTerm = text ?? ""
    }
    
    func presentSearchable(_ value: Bool) {
        self.searchable = value
    }
    
    func presentSearchApp(appInfo: [AppStoreSearchResultDomain]) {
        self.appInfo = appInfo.map { $0.toViewModel() }
    }
}
