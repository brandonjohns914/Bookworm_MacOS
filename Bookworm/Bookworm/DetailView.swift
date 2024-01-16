//
//  DetailView.swift
//  Bookworm
//
//  Created by Brandon Johns on 1/15/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var review: Review
    @EnvironmentObject var dataController: DataController
    @State private var showingRendered = false
    var body: some View {
        Form {
            TextField("Title", text: $review.reviewText)
            TextField("Author", text: $review.reviewAuthor)
            
            Picker("Rating", selection: $review.rating){
                ForEach(1..<6){
                    Text(String($0))
                        .tag(Int32($0))
                }
            }
            .pickerStyle(.segmented)
            TextEditor(text: $review.reviewText)
        }
        .padding()
        .onChange(of: review.reviewTitle, perform: dataController.enqueueSave)
        .onChange(of: review.reviewAuthor, perform: dataController.enqueueSave)
        .onChange(of: review.reviewText, perform: dataController.enqueueSave)
        .onChange(of: review.rating, perform: dataController.enqueueSave)
        .disabled(review.managedObjectContext == nil)
        .toolbar {
            Button {
                showingRendered.toggle()
            } label: {
                Label("Show Rendered", systemImage: "book")
            }
        }
        .sheet(isPresented: $showingRendered){
            RenderView(review: review)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController()
        let review = Review(context: dataController.container.viewContext)
        
        DetailView(review: review)
            .environmentObject(dataController)
    }
}


