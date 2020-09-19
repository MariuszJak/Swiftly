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
    private let backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    func clearCache() {
        Current.cache.removeAllImages()
    }

    func requestImage<T: UIImage>(_ url: URL?) -> AnyPublisher<T?, Error> {
        guard let url = url else {
            return Fail(error: AppError.urlError).eraseToAnyPublisher()
        }
        if let image = Current.cache[url] {
            Log.info("Image from cache for: \(url)")
            return Just(image as? T)
                .mapError { _ in AppError.unknown }
                .eraseToAnyPublisher()
        }
        Log.info("Fetching image for url: \(url)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response -> T? in return T(data: data) }
            .handleEvents(receiveOutput: { image in
                guard let image = image else { return }
                Log.info("Cached image for: \(url)")
                Current.cache[url] = image
            })
            .catch { error in return Fail(error: error) }
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
