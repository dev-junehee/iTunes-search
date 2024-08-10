//
//  SearchViewModel.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    var recentList: [String] = []
    
    struct Input {
        let searchText: ControlProperty<String?>
        let searchTab: ControlEvent<Void>
        let tableSelected: ControlEvent<SearchResults>
    }
    
    struct Output {
        let recentList: BehaviorSubject<[String]>
        let searchList: Observable<[SearchResults]>
        let tableSelected: ControlEvent<SearchResults>
    }
    
    func transform(input: Input) -> Output {
        let recentList = BehaviorSubject(value: UserDefaultsManager.recentSearch)
        let searchList = PublishSubject<[SearchResults]>()
        
        // input.searchText
        //     .orEmpty
        //     .withLatestFrom(input.searchText.orEmpty)
        //     .distinctUntilChanged()
        //     .map { searchText in
        //         return "\(searchText)"
        //     }
        //     .subscribe { searchText in
        //         var recentList = UserDefaultsManager.recentSearch
        //         // 이전 검색 리스트에 없을 때만 저장
        //         if !recentList.contains(searchText) && !searchText.isEmpty {
        //             recentList.insert(searchText, at: 0)
        //             UserDefaultsManager.recentSearch = recentList
        //         }
        //     }
        //     .disposed(by: disposeBag)
        
        input.searchTab
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText.orEmpty)
            .debug("확인1")
            .distinctUntilChanged()
            .map { searchText in
                return searchText
            }
            .flatMap { searchText in
                NetworkManager.shared.getSearch(query: searchText)
            }
            .subscribe(with: self) { owner, search in
                dump(search.results)
                searchList.onNext(search.results)
            } onError: { owner, error in
                print("Error:", error)
            } onCompleted: { value in
                print("Completed")
            } onDisposed: { value in
                print("Disposed")
            }
            .disposed(by: disposeBag)
            
            
        
        return Output(recentList: recentList,
                      searchList: searchList,
                      tableSelected: input.tableSelected)
    }
    
}
