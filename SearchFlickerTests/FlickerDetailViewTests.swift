import XCTest
import SwiftUI

@testable import SearchFlicker

class FlickerDetailViewTests: XCTestCase {

    // Test to ensure description cleaning removes HTML tags
    func testCleanDescription() {
        let htmlDescription = """
        <p><a href="https://www.flickr.com/people/schenfeld/">David Schenfeld</a> posted a photo:</p>
        <p><a href="https://www.flickr.com/photos/schenfeld/54146489112/" title="North American Porcupine">
        <img src="https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg" width="240" height="160" alt="North American Porcupine" /></a></p>
        <p>Cadillac Mountain, Acadia National Park, Maine</p>
        """
        
        let view = FlickerDetailView(item: FlickerList(
            title: "North American Porcupine",
            link: URL(string: "https://www.flickr.com/photos/schenfeld/54146489112/")!,
            media: Media(m: URL(string: "https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg")!),
            date_taken: "2023-06-07T15:37:45-08:00",
            description: htmlDescription,
            published: "2024-11-18T02:53:13Z",
            author: "nobody@flickr.com (\"David Schenfeld\")",
            author_id: "17528760@N00",
            tags: "acadia maine porcupine barharbor unitedstates cadillacmountain mammal"
        ))

        let cleanedDescription = view.cleanDescription(htmlDescription)
        XCTAssertEqual(cleanedDescription, "Cadillac Mountain, Acadia National Park, Maine", "Description cleaning failed to remove HTML tags")
    }



    // Test to ensure author name extraction works correctly
    func testExtractAuthorName() {
        let author = "nobody@flickr.com (\"David Schenfeld\")"
        
        // Create an instance of FlickerDetailView
        let flickerItem = FlickerList(
            title: "North American Porcupine",
            link: URL(string: "https://www.flickr.com/photos/schenfeld/54146489112/")!,
            media: Media(m: URL(string: "https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg")!),
            date_taken: "2023-06-07T15:37:45-08:00",
            description: "",
            published: "2024-11-18T02:53:13Z",
            author: "nobody@flickr.com (\"David Schenfeld\")",
            author_id: "17528760@N00",
            tags: ""
        )
        
        // Instantiate FlickerDetailView
        let view = FlickerDetailView(item: flickerItem)
        
        // Call the method on the instance
        let authorName = view.extractAuthorName(from: author)
        XCTAssertEqual(authorName, "David Schenfeld", "Author extraction failed")
    }

    // Test to ensure the published date is formatted correctly
    func testFormattedDate() {
        let dateString = "2024-11-18T02:53:13Z"
        
        // Create an instance of FlickerDetailView
        let flickerItem = FlickerList(
            title: "North American Porcupine",
            link: URL(string: "https://www.flickr.com/photos/schenfeld/54146489112/")!,
            media: Media(m: URL(string: "https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg")!),
            date_taken: "2023-06-07T15:37:45-08:00",
            description: "",
            published: dateString,
            author: "",
            author_id: "17528760@N00",
            tags: ""
        )
        
        // Instantiate FlickerDetailView
        let view = FlickerDetailView(item: flickerItem)
        
        // Call the method on the instance
        let formattedDate = view.formattedDate(from: dateString)
        XCTAssertEqual(formattedDate, "Nov 18, 2024 at 2:53:13 AM", "Date formatting failed")
    }

    
    // Test to ensure invalid date returns nil
    func testInvalidDateFormatting() {
        let invalidDateString = "invalid-date"
        
        // Create an instance of FlickerDetailView
        let flickerItem = FlickerList(
            title: "North American Porcupine",
            link: URL(string: "https://www.flickr.com/photos/schenfeld/54146489112/")!,
            media: Media(m: URL(string: "https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg")!),
            date_taken: "2023-06-07T15:37:45-08:00",
            description: "",
            published: invalidDateString,
            author: "",
            author_id: "17528760@N00",
            tags: ""
        )
        
        // Instantiate FlickerDetailView
        let view = FlickerDetailView(item: flickerItem)
        
        // Call the method on the instance
        let formattedDate = view.formattedDate(from: invalidDateString)
        XCTAssertNil(formattedDate, "Invalid date should return nil")
    }

    // Test to ensure `FlickerDetailView` can correctly bind to a `FlickerList` object
    func testFlickerDetailViewBindings() {
        // Sample `FlickerList` item
        let flickerItem = FlickerList(
            title: "North American Porcupine",
            link: URL(string: "https://www.flickr.com/photos/schenfeld/54146489112/")!,
            media: Media(m: URL(string: "https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg")!),
            date_taken: "2023-06-07T15:37:45-08:00",
            description: "<p><a href=\"https://www.flickr.com/people/schenfeld/\">David Schenfeld</a> posted a photo:</p><p><a href=\"https://www.flickr.com/photos/schenfeld/54146489112/\" title=\"North American Porcupine\"><img src=\"https://live.staticflickr.com/65535/54146489112_a9c92903c8_m.jpg\" width=\"240\" height=\"160\" alt=\"North American Porcupine\" /></a></p><p>Cadillac Mountain, Acadia National Park, Maine</p>",
            published: "2024-11-18T02:53:13Z",
            author: "nobody@flickr.com (\"David Schenfeld\")",
            author_id: "17528760@N00",
            tags: "acadia maine porcupine barharbor unitedstates cadillacmountain mammal"
        )

        // Create the view
        let view = FlickerDetailView(item: flickerItem)

        // Convert view to a snapshot for testing (if applicable)
        let viewController = UIHostingController(rootView: view)
        XCTAssertNotNil(viewController.view, "FlickerDetailView should load successfully")
    }
}
