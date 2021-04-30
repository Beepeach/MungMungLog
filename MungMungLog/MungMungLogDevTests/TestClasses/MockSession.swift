//
//  MockSession.swift
//  MungMungLogDevTests
//
//  Created by JunHee Jo on 2021/04/30.
//

import Foundation
@testable import MungMungLog

// 일단 보류 ㅠㅠ

class MockURLSession: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler, request: request)
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    internal init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, request: URLRequest) {
        self.completionHandler = completionHandler
        self.request = request
    }


    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    var request: URLRequest

    var resumeCalled = false

    override func resume() {
        resumeCalled = true
    }
}
