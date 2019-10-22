//
//  RxSession.swift
//  Planet3
//
//  Created by Dominik Arnhof on 24.01.17.
//  Copyright © 2017 Hutchison Drei Austria GmbH. All rights reserved.
//

import Foundation
import Endpoints
import RxSwift
import RxCocoa

/// Result of the Request.
public struct RxResult<Value> {
    
    /// The parsed Response Object
    public let value: Value
    
    /// The HTTPURLResponse
    public let response: HTTPURLResponse
    
    init(value: Value, response: HTTPURLResponse) {
        self.value = value
        self.response = response
    }
}

public protocol ReactiveSession {
    func start<C: Call>(call: C) -> Single<RxResult<C.Parser.OutputType>>
}

extension Session: ReactiveSession {
    public func start<C: Call>(call: C) -> Single<RxResult<C.Parser.OutputType>> {
        
        return Single.create { single in
                        
            let task = self.start(call: call, completion: { result in
                if let error = result.error {
                    single(.error(error))
                    return
                }
                
                guard let value = result.value, let response = result.response else {
                    single(.error(RxError.noElements))
                    return
                }
                
                single(.success(RxResult(value: value, response: response)))
            })
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

/// Convenience Protocol to support call.rx
public protocol ReactiveCall: Call, ReactiveCompatible {
    
}

extension Reactive where Base: ReactiveCall {
    /// Creates an Single Observable that can execute the Call.
    ///
    /// - Parameter client: The client that will be used to process the call.
    /// - Returns: Singe Observable containing the RxResult
    public func response<C: Endpoints.Client>(with client: C) -> Single<RxResult<Base.Parser.OutputType>> {
        return Session(with: client).start(call: self.base)
    }
    
    /// Creates an Single Observable that can execute the Call.
    ///
    /// - Parameter client: The client that will be used to process the call.
    /// - Returns: Singe Observable containing the parsed response object
    public func value<C: Endpoints.Client>(with client: C) -> Single<Base.Parser.OutputType> {
        return Session(with: client).start(call: self.base).map { $0.value }
    }
}
