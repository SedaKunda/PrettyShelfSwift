//
//  OpenLibraryAPI.swift
//  PrettyShelf
//
//  Created by Seda Kunda on 19/01/2022.
//

import Foundation
import SwiftUI
import Combine

extension HomeView {
    @MainActor class BookViewModel : ObservableObject {
        @Published var book = [Book]()
        @Published var category = ""
        @Published var title = ""
        @Published var showText = false
        private var cancellable: AnyCancellable?

        func fetchBook(_ isbn: String) {
                
            var components = URLComponents()
                components.scheme = "https"
                components.host = "openlibrary.org"
                components.path = "/isbn/\(isbn).json"
            
            guard let url = components.url else {
                print("Invalid url...")
                return
            }

            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map({
                    $0.data
                })
                .decode(type: Book.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { (completion) in
                        switch completion {
                            case .finished:
                                self.showText = true
                                break
                            case .failure(let error):
                                print("Error with fetching books: \(error)")
                        }
                    },
                    receiveValue: { (book) in
                        self.book.append(book)
                        self.title = self.book[0].title
                        if let subjectValue = self.book[0].subjects {
                            self.category = subjectValue.joined(separator: ", ")
                        }
                    })
        }
    }
}
