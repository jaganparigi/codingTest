//
//  FickerBase.swift
//  SearchFlicker
//
//

import Foundation

struct Media: Decodable {
    let m: URL
}

struct FlickerList: Decodable, Identifiable {
    var id = UUID() // Adding an id for Identifiable protocol
    let title: String
    let link: URL
    let media: Media
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String
    let tags: String
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case date_taken
        case description
        case published
        case author
        case author_id
        case tags
    }
}

struct FlickrResponse: Decodable {
    let title: String
    let link: URL
    let description: String
    let modified: String
    let generator: URL
    let items: [FlickerList]
}
