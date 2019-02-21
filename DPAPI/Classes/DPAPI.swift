//
//  DPAPI.swift
//  DPAPI
//
//  Created by Dave on 12/02/2019.
//  Copyright © 2019 Dave. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public protocol DomainConfig {
    static var domain: String { get }
    static var headers: Alamofire.HTTPHeaders { get }
    static var parameters: Alamofire.Parameters? { get }
    static var alamoManager: Alamofire.SessionManager { get }
}

public protocol APIConfig {
    associatedtype Response: APIModelCodable
    static var domainConfig: DomainConfig.Type { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var parameters: Alamofire.Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension APIConfig {
    public func request() -> Observable<Self.Response> {
        return Observable.create { (observer: AnyObserver<Self.Response>) -> Disposable in
            let request = Self.domainConfig.alamoManager
                .request(Self.domainConfig.domain + self.path,
                         method: self.method,
                         parameters: Self.domainConfig.parameters?.merging(self.parameters ?? [:], uniquingKeysWith: { (_, last) in last }),
                         encoding: self.encoding,
                         headers: Self.domainConfig.headers)
            
            request
                .validate()
                .responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        do {
                            let parsedData = try Self.Response.from(data: data)
                            observer.onNext(parsedData!)
                            observer.onCompleted()
                        } catch (let err) {
                            observer.onError(err)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

public protocol APIModelCodable: Codable {}

extension APIModelCodable where Self: Codable {
    static func from(json: String, using encoding: String.Encoding = .utf8) throws -> Self? {
        guard let data = json.data(using: encoding) else { return nil }
        return try from(data: data)
    }
    
    static func from(data: Data) throws -> Self? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(Self.self, from: data)
    }
    
    var jsonData: Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(self)
    }
    
    var jsonString: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
