//
//  Endpoint.swift
//  PrettyShelf
//
//  Created by Seda Kunda on 08/02/2022.
//

import Foundation

struct Endpoint {
    func getUrl(_ isbn: String) -> URL? {
        var components = URLComponents()
            components.scheme = "https"
            components.host = "openlibrary.org"
            components.path = "/isbn/\(isbn).json"
        
        return components.url
    }
}
