import XCTest
import Combine
@testable import Swiftly

final class SwiftlyTests: XCTestCase {
    private var cancellableSet: Set<AnyCancellable>!

    override func setUp() {
        cancellableSet = Set()

    }

    override func tearDown() {
        cancellableSet = nil
    }
    
    func testGetImage() {
        let url = URL(string: "http://test/image.jpg")!
        let expectedImage = UIColor.red.image(CGSize(width: 1024, height: 1024))

        Current.imageProvider.loadImage = { _ in Just(expectedImage).eraseToAnyPublisher() }
        Switlfy.loadImage(from: url).sink { image in
            XCTAssertEqual(expectedImage, image)
        }.store(in: &cancellableSet)
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
