import Foundation
import UIKit
import Combine

public extension UIImageView {
    func loadImage(with url: URL?, placeholderImage: UIImage? = nil) -> AnyCancellable {
        image = placeholderImage
        addSpinner()

        return Switlfy.loadImage(from: url).sink { error in
            switch error {
            case .failure(let error):
                self.removeSpinner()
                Log.error(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { image in
            self.removeSpinner()
            guard let image = image else { return }
            self.image = image
        }
    }
}
