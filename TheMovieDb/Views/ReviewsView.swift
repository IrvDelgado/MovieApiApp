//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 06/02/22.
//

import SwiftUI

struct ReviewsView: View {
    
    public init(reviewsArray: [Review]) {
        self.reviewsArray = reviewsArray
        
        print("Got it")
        print(reviewsArray)
    }
    
    private var reviewsArray: [Review]
    @State private var fullText: String = "..."
    
    var body: some View {
        
        List(reviewsArray, id: \.id) { review in
            
            VStack(alignment: .leading, spacing: 10) {
                Text("A review by \(review.author)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                
                Text("Written by \(review.authorDetails?.username ?? "") on \(review.createdDate.components(separatedBy: "T")[0])")
                                .font(.custom("HelveticaNeue", size: 12))
                                .fontWeight(.light)
                
                GeometryReader { _ in
                            ScrollView {
                                Text("\(review.content)")
                                    .font(.custom("HelveticaNeue", size: 12.5))
                                    .fontWeight(.regular)
                                                
                            }
                        }.frame(width: nil, height: 120, alignment: .leading)
//
//                TextEditor(text: Binding<String>("hola") )
//                        .foregroundColor(Color.gray)
//                               .font(.custom("HelveticaNeue", size: 13))
//                               .lineSpacing(5)
//                               .frame(width: nil, height: 70, alignment: .leading)
                               
            }.padding()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(reviewsArray: [])
    }
}
