//
//  RxSessionTests.swift
//  RxSessionTests
//
//  Created by Dominik Arnhof on 19.05.17.
//  Copyright © 2017 Dominik Arnhof. All rights reserved.
//

import XCTest
@testable import RxSession
import Endpoints
import RxSwift

class TestClient: AnyClient {
    init() {
        super.init(baseURL: URL(string: "https://httpbin.org/get")!)
    }
}

struct TestCall: ReactiveCall {
    typealias Parser = DictionaryParser<String, Any>
    
    var request: URLRequestEncodable {
        return Request(.get, "get", query: ["x": "z"])
    }
}

struct NotFoundCall: ReactiveCall {
    typealias Parser = NoContentParser
    
    var request: URLRequestEncodable {
        return Request(.get, "status/404")
    }
}

class RxSessionTests: XCTestCase {

    private var disposeBag = DisposeBag()
    private var client = TestClient()
    private lazy var session = Session<TestClient>(with: client)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        disposeBag = DisposeBag()
        client = TestClient()
        session = Session<TestClient>(with: client)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFailingCall() {
        let client = TestClient()
        let session = Session<TestClient>(with: client)

        let call = NotFoundCall()

        let exp = expectation(description: "Call fails with 404")

        session.start(call: call)
            .subscribe(onSuccess: { (result) in
                XCTFail("should fail with 404")
                exp.fulfill()
            }, onError: { (error) in
                if case StatusCodeError.unacceptable(code: let code, reason: _) = error {
                    XCTAssertEqual(code, 404)
                } else {
                    print(error)
                    XCTFail("should be unacceptable status code but is: \(error)")
                }
                exp.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 30.0)
    }

    func testSucceedingCall() {
        let call = TestCall()

        let exp = expectation(description: "Call succeeds")

        session.start(call: call)
            .subscribe(onSuccess: { (result) in
                XCTAssertNotEqual(result.value.count, 0, "result should not be an empty dictionary")
                exp.fulfill()
            }, onError: { (error) in
                XCTFail("should not fail, error: \(error)")
                exp.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 30.0)
    }
}
