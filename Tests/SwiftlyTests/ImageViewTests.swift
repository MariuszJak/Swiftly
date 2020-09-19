//
//  ImageViewTests.swift
//  SwiftlyTests
//
//  Created by Mariusz Jakowienko on 17/09/2020.
//

import XCTest
import Combine
@testable import Swiftly

class ImageViewTests: XCTestCase {
    private var cancellableSet: Set<AnyCancellable>!

    override func setUp() {
        cancellableSet = Set()

    }

    override func tearDown() {
        cancellableSet = nil
    }

    func testGetImageForUIImageView() {
        let url = URL(string: "http://test/image.jpg")!
        let expectedImage = UIColor.red.image(CGSize(width: 1024, height: 1024))
        let expectedImageView = UIImageView()

        Current.imageProvider.loadImage = { _ in Just(expectedImage)
            .mapError { _ in AppError.unknown }
            .eraseToAnyPublisher() }

        expectedImageView.loadImage(with: url).store(in: &cancellableSet)
        XCTAssertEqual(expectedImageView.image, expectedImage)
    }

    func testImageViewPlaceholderImage() {
        let url = URL(string: "http://test/image.jpg")!
        let expectedImageView = UIImageView()
        let expectedPlaceholderImage = UIColor.yellow.image(CGSize(width: 2048, height: 2048))

        Current.imageProvider.loadImage = { _ in Just(nil)
            .mapError { _ in AppError.unknown }
            .eraseToAnyPublisher() }

        expectedImageView.loadImage(with: url, placeholderImage: expectedPlaceholderImage).store(in: &cancellableSet)
        XCTAssertEqual(expectedImageView.image, expectedPlaceholderImage)
    }

    func testImageViewPlaceholderImageWithoutSpinner() {
        let url = URL(string: "http://test/image.jpg")!
        let expectedImageView = UIImageView()
        let expectedPlaceholderImage = UIColor.yellow.image(CGSize(width: 2048, height: 2048))

        Current.imageProvider.loadImage = { _ in Just(nil)
            .mapError { _ in AppError.unknown }
            .eraseToAnyPublisher() }

        expectedImageView.loadImage(with: url, placeholderImage: expectedPlaceholderImage).store(in: &cancellableSet)
        XCTAssertFalse(expectedImageView.subviews.contains { $0 is UIActivityIndicatorView })
    }

}
