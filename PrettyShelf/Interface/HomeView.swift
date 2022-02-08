//
//  HomeUIView.swift
//  PrettyShelf
//
//  Created by Seda Kunda on 18/01/2022.
//

import SwiftUI

struct HomeView: View {

    @State private var isbn = ""
    @StateObject private var viewModel = BookViewModel()
     
    var body: some View {
        VStack() {
            TextField("ISBN", text: $isbn)
                .padding()
                .background(Color.gray)
                .cornerRadius(20.0)
                .frame(width: 300, height: 50)
            Button("Search") {
                viewModel.fetchBook(self.isbn)
            }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(15.0)
            Spacer()
            if viewModel.showText {
                VStack(alignment: .leading) {
                    Text("Title: \(viewModel.title)")
                    Text("Subject: \(viewModel.category)")
                }
            }
            Spacer()
        }.padding([.leading, .bottom, .trailing], 20)
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
