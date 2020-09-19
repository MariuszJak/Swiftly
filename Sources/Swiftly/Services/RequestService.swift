//
//  RequestService.swift
//  
//
//  Created by Mariusz Jakowienko on 19/09/2020.
//

import Foundation
import Combine
import UIKit

class RequestService {
    private let cache = ImageCache()
    private let backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    func requestImage<T: UIImage>(_ url: URL?) -> AnyPublisher<T?, Error> {
        guard let url = url else {
            return Fail(error: AppError.urlError).eraseToAnyPublisher()
        }
        if let image = cache[url] {
            return Just(image as? T)
                .mapError { _ in AppError.unknown }
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response -> T? in return T(data: data) }
            .handleEvents(receiveOutput: { image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .catch { error in return Fail(error: error) }
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
