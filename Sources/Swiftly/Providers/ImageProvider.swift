//
//  ImageProvider.swift
//  
//
//  Created by Mariusz Jakowienko on 17/09/2020.
//

import Foundation
import Combine
import UIKit

class ImageProvider {
    var loadImage: (_ url: URL) -> AnyPublisher<UIImage?, Never> = { url in
        Current.api.loadImage(from: url)
    }
}
