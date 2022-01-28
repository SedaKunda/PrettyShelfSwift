//
//  HomeUIView.swift
//  PrettyShelf
//
//  Created by Seda Kunda on 18/01/2022.
//

import SwiftUI

struct HomeUIView: View {

    @State private var isbn = ""
    @State private var value = ""
    @State private var category = ""
    @State private var showText = false
    
    var body: some View {
        VStack() {
            TextField("ISBN", text: $isbn)
                .padding()
                .background(Color.gray)
                .cornerRadius(20.0)
                .frame(width: 300, height: 50)
            Button("Search") { getTitle(self.isbn) }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
            Spacer()
            if showText {
                VStack(alignment: .leading) {
                    Text("Title: \(value)")
                    Text("Subject: \(category)")
                }
            }
            Spacer()
        }.padding([.leading, .bottom, .trailing], 20)
    }
    
    private func getTitle(_ isbn: String) -> () {
        return OpenLibraryAPI().fetchBook(isbn) { (book) in
            self.value = book.title
            if let subjectValue = book.subjects {
                self.category = subjectValue.joined(separator: ", ")
            }
            showText = true
        }
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}
