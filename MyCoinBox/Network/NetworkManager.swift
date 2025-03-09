//
//  NetworkManager.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import Foundation
import Alamofire
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func callRequestToAPIServer<T: Decodable>(_ api: NetworkRequest,
                                              _ type: T.Type,
                                completionHandler: @escaping (Result<T, CustomError>) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameters)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { [weak self] response in
                switch response.result {
                case .success(let value):
                    print(#function, "success")
                    completionHandler(.success(value))
                case .failure(let error):
                    print(#function, "error", error)
                    guard let customError = self?.handleError(response: response, error: error) else { return }
                    completionHandler(.failure(customError))
                }
            }
    }
    
    private func handleError<T>(response: DataResponse<T, AFError>,
                             error: Error) -> CustomError {
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 400: return .statusCode_400
            case 401: return .statusCode_401
            case 403: return .statusCode_403
            case 404: return .statusCode_404
            case 405: return .statusCode_405
            case 429: return .statusCode_429
            case 500: return .statusCode_500
            default: return .defaultCase
            }
        } else if let urlError = response.error?.underlyingError as? URLError {
            switch urlError.code {
            case .notConnectedToInternet: return .url_noInternet
            case .timedOut: return .url_timedOut
            default: return .defaultCase
            }
        }
        return .defaultCase
    }
    
}

enum CustomError: String, Error {
    case statusCode_400 = "잘못된 요청입니다. 검색어를 확인해보세요."
    case statusCode_401 = "권한이 없습니다. 인증키를 확인해보세요."
    case statusCode_403 = "이 작업에 대한 권한이 없습니다."
    case statusCode_404 = "존재하지 않는 검색 API 입니다. 관리자에게 문의하세요."
    case statusCode_405 = "허용되지 않는 호출 방식 입니다. 관리자에게 문의하세요."
    case statusCode_429 = "호출 한도를 초과했습니다. 잠시 후 다시 시도해주세요."
    case statusCode_500 = "서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요."
    case url_noInternet = "인터넷 연결이 없습니다."
    case url_timedOut = "서버 요청이 시간 초과되었습니다."
    case defaultCase = "관리자에게 문의하세요."
}
