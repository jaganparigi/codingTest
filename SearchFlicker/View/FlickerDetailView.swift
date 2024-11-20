//
//  FlickerDetailView.swift
//  SearchFlicker
//
//

import SwiftUI

struct FlickerDetailView: View {
    let item: FlickerList
    
    var body: some View {
        VStack {
            ImageLoadView(url: item.media.m)
                .frame(maxWidth: .infinity, maxHeight: 250)
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(item.title)")
                    .font(.title)
                    .padding(.top, 10)
                
                Text("Author: \(item.author)")
                    .font(.subheadline)
                
                if let publishedDate = dateFormatter.date(from: item.published) {
                    Text("Published: \(formattedDate(from: publishedDate))")
                        .font(.subheadline)
                } else {
                    Text("Published: \(item.published)")
                        .font(.subheadline)
                }
                Text("Description:")
                    .font(.subheadline)
               let attributedString = attributedString(from: item.description)
                AttributedLabel(attributedText: attributedString,width: 350,height: 50).font(.subheadline)
            }
            .padding()
        }.padding(.top,20)
           
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    private func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    private func attributedString(from html: String) -> NSAttributedString {
            guard let data = html.data(using: .utf8) else { return NSAttributedString() }
            do {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                return try NSAttributedString(data: data, options: options, documentAttributes: nil)
            } catch {
                print("Error creating attributed string: \(error)")
                return NSAttributedString()
            }
        }
}
struct AttributedLabel: UIViewRepresentable {
    var attributedText: NSAttributedString
       var width: CGFloat
       var height: CGFloat
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attributedText
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedText
    }
}
