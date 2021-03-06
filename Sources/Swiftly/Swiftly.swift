import UIKit
import Combine
import Foundation

public class Switlfy {
    public static func setLog(with logLevel: LogLevel) {
        Log.logLevel = logLevel
    }

    public static func loadImage(from url: URL?) -> AnyPublisher<UIImage?, Error> {
        Current.imageProvider.loadImage(url)
    }
}
