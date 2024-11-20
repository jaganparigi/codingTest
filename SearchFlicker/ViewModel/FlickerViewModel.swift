import Foundation

class FlickrViewModel: ObservableObject {
    @Published var items: [FlickerList] = []
    @Published var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }
            Task {
                await fetchItems()
            }
        }
    }

    var apiClient = APIClient()
    private var debounceTask: Task<Void, Never>?

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
        Task {
            await fetchItems()
        }
    }

    func fetchItems() async {
        do {
            guard let fetchedItems = try await apiClient.fetchItems(searchText: searchText) else {
                return
            }
            DispatchQueue.main.async {
                self.items = fetchedItems.items
            }
        } catch {
            print("Failed to get flicker list: \(error)")
        }
    }
    
    var filteredItems: [FlickerList] {
        return items
    }
}
