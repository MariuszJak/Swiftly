//
//  UIImageView+Spinner.swift
//  ImageLoader
//
//  Created by Mariusz Jakowienko on 14/09/2020.
//  Copyright © 2020 Mariusz Jakowienko. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
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
