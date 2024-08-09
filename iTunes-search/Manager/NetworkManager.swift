//
//  NetworkManager.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import Foundation
import RxSwift

enum APIError: String, Error {
    case invalidURL = "올바른 URL이 아닙니다."
    case unknownResponse = "알 수 없는 응답값입니다."
    case statusError = "상태코드 오류입니다."
    case unknownError = "알 수 없는 오류입니다."
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func getSearch(query: String) -> Observable<Search> {
        let url = API.BASE_URL + query
        print(url)
        
        let result = Observable<Search>.create { observer in
            guard let URL = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: URL) { data, response, error in
                if let error = error {
                    print("API ERROR", error)
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("API Respnse ERROR")
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let searchData = try? JSONDecoder().decode(Search.self, from: data) {
                    print("API Data", data)
                    print("API Search Data", searchData)
                    observer.onNext(searchData)
                    observer.onCompleted()
                } else {
                    print("API Unknown Data")
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            
            return Disposables.create()
            
        }.debug("iTunes Search 조회")
        
        return result
    }
    
}
