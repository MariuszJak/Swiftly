import XCTest
@testable import Swiftly

final class SwiftlyTests: XCTestCase {

    override class func tearDown() {

    }
    
    func testGetImage() {
        
    }

    func testDecodedImage() {
        let expectedImage = UIColor.red.image(CGSize(width: 1024,
                                             height: 1024))
        let url = URL(string: "http://test/image.jpg")!
        let cache = ImageCache(config: .defaultConfig)
        cache.insertImage(expectedImage, for: url)

        let decodedImageFromCache = cache.decodedImageCache.object(forKey: url as AnyObject) as? UIImage
        XCTAssertEqual(expectedImage, decodedImageFromCache)
    }

    func testEncodedImage() {
        let expectedImage = UIColor.red.image(CGSize(width: 1024,
                                             height: 1024))
        let url = URL(string: "http://test/image.jpg")!
        let cache = ImageCache(config: .defaultConfig)
        cache.insertImage(expectedImage, for: url)

        let decodedImage = cache.imageCache.object(forKey: url as AnyObject) as? UIImage
        XCTAssertEqual(expectedImage.decodedImage().size, decodedImage?.size)
    }

    func testRemoveImage() {

    }

    func testRemoveAllImages() {
        
    }

    func testCacheImage() {

    }

    func testMemoryLimit() {

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
