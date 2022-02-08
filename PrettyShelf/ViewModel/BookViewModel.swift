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
        let session: URLSession
        
        init(urlSession: URLSession = .shared) {
            self.session = urlSession
        }
        
        func getBook(_ isbn: String) {
            guard let url = Endpoint().getUrl(isbn) else {
                print("Invalid url...")
                return
            }

            cancellable = session.dataTaskPublisher(for: url)
                .map({
                    $0.data
                })
                .decode(type: Book.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { (completion) in
                        self.onBookSet(completion)
                    },
                    receiveValue: { (book) in
                        self.setBook(book)
                    })
        }

        func setBook(_ book: Book) {
            self.book.append(book)
            self.title = self.book[0].title
            if let subjectValue = self.book[0].subjects {
                self.category = subjectValue.joined(separator: ", ")
            }
        }
        
        func onBookSet(_ completion: Subscribers.Completion<Error>) {
            switch completion {
            case .finished:
                self.showText = true
                break
            case .failure(let error):
                print("Error with fetching books: \(error)")
            }
        }
    }
}
