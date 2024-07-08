import Foundation

final class CartViewModel {
    
    // MARK: - Properties
    
    private let networkClient: NetworkClient
    private let nftService: NftService
    private let userDefaults = UserDefaults.standard
    private let savedSortingKey = "savedSorting"
    private var order: Order?
    private(set) var orderedNfts: [Nft] = [] {
        didSet {
            orderedNftsBinding?(orderedNfts)
        }
    }
    var orderedNftsBinding: Binding<[Nft]>?
    var isLoadingBinding: Binding<Bool>?
    
    // MARK: - Initialization
    
    init(networkClient: NetworkClient, nftService: NftService) {
        self.networkClient = networkClient
        self.nftService = nftService
        getOrder()
    }
    
    // MARK: - Private Function
    
    private func sendRequestAndFetchResult(request: NetworkRequest) {
        isLoadingBinding?(true)
        networkClient.send(request: request, type: Order.self) { result in
            switch result {
            case .success(let order):
                self.order = order
                self.getOrderedNfts()
            case .failure(let error):
                print(error)
                self.isLoadingBinding?(false)
            }
        }
    }
    
    private func getOrderedNfts() {
        guard let order = order else {
            isLoadingBinding?(false)
            return
        }
        var nfts: [Nft] = []
        let dispatchGroup = DispatchGroup()
        
        for nftID in order.nfts {
            dispatchGroup.enter()
            nftService.loadNft(id: nftID) { result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let receivedNft):
                    nfts.append(receivedNft)
                case .failure(let error):
                    print(error)
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.isLoadingBinding?(false)
            let sortPredicate = self.getSortPredicate()
            self.orderedNfts = self.sortNfts(nfts: nfts, by: sortPredicate)
        }
    }
    
    // MARK: - Internal Function
    
    func getSortPredicate() -> SortOption {
        if let savedSortingString = userDefaults.string(forKey: savedSortingKey),
           let savedSorting = SortOption(rawValue: savedSortingString) {
            return savedSorting
        }
        return .byName
    }
    
    func saveSorting(sortPredicate: SortOption) {
        userDefaults.set(sortPredicate.rawValue, forKey: self.savedSortingKey)
        orderedNfts = sortNfts(nfts: orderedNfts, by: sortPredicate)
    }
    
    func sortNfts(nfts: [Nft], by predicat: SortOption) -> [Nft] {
        switch predicat {
        case .byPrice:
            return nfts.sorted { $0.price > $1.price }
        case .byRating:
            return nfts.sorted { $0.rating > $1.rating }
        case .byName:
            return nfts.sorted { $0.name < $1.name }
        }
    }
    
    func getOrder() {
        let getOrderRequest = GetOrderRequest()
        sendRequestAndFetchResult(request: getOrderRequest)
    }
    
    func deleteNftFromOrder(id: String) {
        guard let order = order else { return }
        let newOder = order.nfts.filter { $0 != id }
        updateOrder(newNfts: newOder)
    }
    
    func updateOrder(newNfts: [String]) {
        let putOrderRequest = PutOrderRequest(nfts: newNfts)
        sendRequestAndFetchResult(request: putOrderRequest)
    }
    
}
