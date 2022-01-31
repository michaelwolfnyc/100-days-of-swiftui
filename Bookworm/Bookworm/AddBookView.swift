//
//  AddBookView.swift
//  Bookworm
//
//  Created by Michael Wolf on 1/30/22.
//

import SwiftUI

struct AddBookView: View {
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var validEntry: Bool {
        title != "" && author != "" && genre != ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    HStack {
                        Spacer()
                        Button("Save") {
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.review = review
                            
                            try? moc.save()
                            dismiss()
                        }.disabled(!validEntry)
                        Spacer()
                        Button("Cancel") {
                            dismiss()
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}
