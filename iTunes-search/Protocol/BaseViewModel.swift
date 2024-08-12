//
//  BaseViewModel.swift
//  iTunes-search
//
//  Created by junehee on 8/12/24.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
