//
//  API.swift
//  
//
//  Created by Mariusz Jakowienko on 17/09/2020.
//

import Foundation
import Combine
import UIKit

class API {
    private let cache = ImageCache()
    private let backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
}

extension API {
    public func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: { image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
