//
//  ViewController.swift
//  DPAPI
//
//  Created by dave.me on 02/13/2019.
//  Copyright (c) 2019 dave.me. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import DPAPI

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.Test().request()
            .subscribe(onNext: { (result) in
                print("result: \(result)")
            }, onError: { (error) in
                print("error: \(error)")
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


struct DPDomain: DomainConfig {
    static var domain: String = "https://jsonplaceholder.typicode.com"
    static var headers: Alamofire.HTTPHeaders { return [String: String]() }
    static var parameters: Parameters? { return nil }
    
    static var alamoManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        return Alamofire.SessionManager(configuration: configuration)
    }()
}

struct API {}

extension API {
    struct Test {}
}

extension API.Test: APIConfig {
    typealias Response = API.Test.Result
    
    static var domainConfig: DomainConfig.Type = DPDomain.self
    
    var method: Alamofire.HTTPMethod { return .get }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var path: String { return "/posts/42" }
    var parameters: Alamofire.Parameters? { return nil }
}


extension API.Test {
    struct Result: APIModelCodable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
}
