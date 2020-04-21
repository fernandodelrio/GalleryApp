//
//  XCTestCase+Utils.swift
//
//  Created by Fernando del Rio on 20/11/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Combine
import XCTest

private var disposeBag = Set<AnyCancellable>()

public extension XCTestCase {
    func delayTest(timeout: TimeInterval = .defaultTimeout) {
        let expec = expectation(description: UUID().uuidString)
        _ = XCTWaiter.wait(for: [expec], timeout: timeout)
    }

    @discardableResult
    func waitForPublisher<T, U>(
        _ publisher: @autoclosure () -> AnyPublisher<T, U>,
        file: StaticString = #file,
        line: UInt = #line,
        timeout: TimeInterval = .longTimeout) -> T? {
        let expec = expectation(description: UUID().uuidString)
        var result: T?
        publisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail(error.localizedDescription, file: file, line: line)
                    expec.fulfill()
                }
            }) { value in
                result = value
                expec.fulfill()
            }.store(in: &disposeBag)

        let waiterResult = XCTWaiter.wait(for: [expec], timeout: timeout)
        if waiterResult != .completed {
            XCTFail("Expectation failed to complete", file: file, line: line)
            return nil
        }
        return result
    }
}
