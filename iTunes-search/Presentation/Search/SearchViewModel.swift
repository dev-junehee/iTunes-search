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
    
    struct Input {
        let searchText: ControlProperty<String?>
        let searchTab: ControlEvent<Void>
        let tableSelected: ControlEvent<SearchResults>
    }
    
    struct Output {
        let searchList: Observable<[SearchResults]>
        let tableSelected: ControlEvent<SearchResults>
    }
    
    func transform(input: Input) -> Output {
        let searchList = PublishSubject<[SearchResults]>()
        
        
        input.searchTab
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText.orEmpty)
            .debug("확인1")
            .distinctUntilChanged()
            .map { searchText in
                print("검색어 확인", searchText)
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
            
            
        
        return Output(searchList: searchList,
                      tableSelected: input.tableSelected)
    }
    
}
