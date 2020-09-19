//
//  APITests.swift
//  SwiftlyTests
//
//  Created by Mariusz Jakowienko on 19/09/2020.
//

import XCTest
import Combine
@testable import Swiftly

class APITests: XCTestCase {
    private var cancellableSet: Set<AnyCancellable>!

    override func setUp() {
        cancellableSet = Set()

    }

    override func tearDown() {
        cancellableSet = nil
    }

    func testImageRequest() {
        let expectedImage = UIColor.red.image(CGSize(width: 1024,
                                             height: 1024))
        let url = URL(string: "http://test/image.jpg")!
        let cache = ImageCache(config: .defaultConfig)
        cache.insertImage(expectedImage, for: url)

        Current.api.loadImage(from: url).sink { (error) in
            switch error {
            case .failure, .finished:
                break
            }
        } receiveValue: { image in
            XCTAssertEqual(expectedImage, image)
        }.store(in: &cancellableSet)
    }

    func testImageRequestWithBadURL() {
        Current.api.loadImage(from: nil).sink { (error) in
            switch error {
            case .failure(let error):
                XCTAssertEqual((error as? AppError)?.localizedDescription, AppError.urlError.localizedDescription)
            case .finished:
                XCTFail()
            }
        } receiveValue: { _ in }
        .store(in: &cancellableSet)
    }
}
