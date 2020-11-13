import Foundation
import UIKit

extension UIImageView {
    func addSpinner() {
        let loadingIndicator = UIActivityIndicatorView()
        self.addSubview(loadingIndicator)

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 16.0),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 16.0)
        ])
        loadingIndicator.startAnimating()
    }

    func removeSpinner() {
        for view in subviews {
            if let spinner = view as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }
}
