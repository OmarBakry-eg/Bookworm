//
//  AddBookView.swift
//  Bookworm
//
//  Created by Omar Bakry on 26/12/2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Name of book",text: $title)
                    TextField("Name of author",text: $author)
                    Picker("Genre",selection: $genre){
                        ForEach(genres,id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section{
                    TextEditor(text: $review)
//                    Picker("Rating",selection: $rating){
//                        ForEach(0..<6){
//                            Text(String($0))
//                        }
//                    }
                    RatingView(rating: $rating)
                    
                }header: {
                    Text("Write a review")
                }
                Section{
                    Button("Save"){
                        let newBook : Book = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
//                        do {
//                        try moc.save()
//                        } catch{
//                            print("Cannot save the book")
//                        }
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
            .preferredColorScheme(.dark)
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
