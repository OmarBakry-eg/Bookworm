//
//  ContentView.swift
//  Bookworm
//
//  Created by Omar Bakry on 24/12/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
//        SortDescriptor(\.title, order: .reverse)
//        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    var body: some View {
        NavigationView{
            List {
                ForEach(books){
                    b in
                NavigationLink {
                    DetailView(book: b)
                } label: {
                    HStack{
                        EmojiRatingView(rating: b.rating)
                            .font(.largeTitle)
                        VStack(alignment:.leading){
                            Text(b.title ?? "Unknown Title")
                                .font(.headline)
                            Text(b.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .preferredColorScheme(.dark)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        EditButton()
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book",systemImage: "plus")
                        }
                    })
                    
                }).sheet(isPresented: $showingAddScreen, content: {
                    AddBookView()
                })
            
               
        }
    }
    func deleteBooks(at Offsets : IndexSet){
        for offset in Offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save() // it will delete and save new update
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
