//
//  ContentView.swift
//  Bookworm
//
//  Created by Brandon Johns on 1/15/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationSplitView {
            ListingView()
                .frame(minWidth: 250)
        } detail: {
            if let selectedReview = dataController.selectedReview{
                DetailView(review: selectedReview)
            } else {
                Text("Please select a review")
            }
        }
    }
}

#Preview {
    ContentView()
}
