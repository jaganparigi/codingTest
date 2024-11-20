//
//  FlickerListView.swift
//  SearchFlicker
//
//

import SwiftUI

struct FlickerListView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchText: String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            VStack {
                SearchView(text: $viewModel.searchText)
                    .padding(.horizontal)
                    
                
                GeometryReader { geometry in
                    ScrollView {
                        let columns = [GridItem(.adaptive(minimum: geometry.size.width / 2 - 10))]
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.filteredItems) { item in
                                NavigationLink(destination: FlickerDetailView(item: item)) {
                                    VStack {
                                        ImageLoadView(url: item.media.m)
                                            .frame(width: geometry.size.width / 2 - 10, height: geometry.size.width / 2 - 10)
                                        Text(item.title)
                                            .font(.caption)
                                            .lineLimit(1).foregroundColor(.white)
                                    }
                                    .frame(width: geometry.size.width / 2 - 10)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                }
            }
            .navigationBarTitle("Search Flicker")
        }
    }
}

#Preview {
    FlickerListView()
}
