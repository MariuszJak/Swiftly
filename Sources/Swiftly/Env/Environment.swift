//
//  Environment.swift
//  
//
//  Created by Mariusz Jakowienko on 17/09/2020.
//

import Foundation

struct Environment {
    var cache = ImageCache(config: .defaultConfig)
    var api = API()
    var imageProvider = ImageProvider()
}

#if DEBUG
var Current = Environment()
#else
let Current = Environment()
#endif
