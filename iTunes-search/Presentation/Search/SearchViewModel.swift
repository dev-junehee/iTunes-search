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
    
    let searchList: [String] = ["테스트1", "테스트2"]
    
    struct Input {
        let tableSelected: ControlEvent<[String]>
    }
    
    struct Output {
        let searchList: BehaviorSubject<[String]>
        let tableSelected: ControlEvent<[String]>
    }
    
    func transform(input: Input) -> Output {
        let searchList = BehaviorSubject(value: searchList)
        
        return Output(searchList: searchList,
                      tableSelected: input.tableSelected)
    }
    
}
