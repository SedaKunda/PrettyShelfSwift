//
//  OpenLibraryAPI.swift
//  PrettyShelf
//
//  Created by Seda Kunda on 19/01/2022.
//

import Foundation

class OpenLibraryAPI : ObservableObject{

    func fetchBook(
        isbn: String,
        decoder: JSONDecoder = JSONDecoder(),
        completion:@escaping (Book) -> ()) {
            
        var components = URLComponents()
            components.scheme = "https"
            components.host = "openlibrary.org"
            components.path = "/isbn/\(isbn).json"
        
        guard let url = components.url else {
            print("Invalid url...")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error with fetching books: \(error)")
                return
            }
            if let data = data {
                do {
                    let json: Book = try decoder.decode(Book.self, from: data)
                    completion(json)
                } catch let error {
                    print(error)
                }
            }
        }

        task.resume()
    }
}
