//
//  ListingView.swift
//  Bookworm
//
//  Created by Brandon Johns on 1/15/24.
//

import SwiftUI

struct ListingView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var reviews: FetchedResults<Review>
    
    @AppStorage("id") var id = 1
    
    var body: some View {
        List(reviews, selection: $dataController.selectedReview) { review in
            Text(review.reviewTitle)
                .contextMenu {
                    Button("Delete", role: .destructive, action: deleteSelected)
                }
                .tag(review)
        }
        .onDeleteCommand(perform: deleteSelected)
        .toolbar {
            Button(action: addReview) {
                Label("Add Review",systemImage: "plus")
            }
            
            Button(action: deleteSelected) {
                Label("Delete", systemImage: "trash")
            }
            .disabled(dataController.selectedReview == nil)
        }
    }
    
    func addReview() {
        let review = Review(context: managedObjectContext)
        review.id = Int16(Int32(id))
        review.title = "Enter the title"
        review.author = "Enter the author"
        review.rating = 3
        
        id += 1
        dataController.save()
    }
    
    func deleteSelected() {
        guard let selectedReview = dataController.selectedReview else { return}
        
        guard let selectedIndex = reviews.firstIndex(of: selectedReview) else { return}
        
        managedObjectContext.delete(selectedReview)
        dataController.save()
        
        if selectedIndex < reviews.count {
            dataController.selectedReview = reviews[selectedIndex]
        } else {
            let previousIndex = selectedIndex - 1
            
            if previousIndex >= 0 {
                dataController.selectedReview = reviews[previousIndex]
            }
        }
    }
}

#Preview {
    ListingView()
}


