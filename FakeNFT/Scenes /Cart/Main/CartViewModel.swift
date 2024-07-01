import Foundation

final class CartViewModel {
    
    //MARK: - Properties
    
    private let networkClient: NetworkClient
    private let nftService: NftService
    private var order: Order?
    private(set) var orderedNfts: [Nft] = [] {
        didSet {
            orderedNftsBinding?(orderedNfts)
        }
    }
    var orderedNftsBinding: Binding<[Nft]>?
    var isLoadingBinding: Binding<Bool>?
    
    init(networkClient: NetworkClient, nftService: NftService) {
        self.networkClient = networkClient
        self.nftService = nftService
        getOrder()
    }
    
    // MARK: - Function
    
    func getOrder() {
        let getOrderRequest = GetOrderRequest()
        isLoadingBinding?(true)
        networkClient.send(request: getOrderRequest, type: Order.self) { result in
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
            self.orderedNfts = nfts
        }
    }
    
    private func updateOrder(newNfts: [String]) {
        isLoadingBinding?(true)
        let putOrderRequest = PutOrderRequest(nfts: newNfts)
        networkClient.send(request: putOrderRequest, type: Order.self) { result in
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
    
    func sortNfts(by predicat: Predicate) -> [Nft] {
        switch predicat {
        case .byPrice:
            return orderedNfts.sorted { $0.price > $1.price }
        case .byRating:
            return orderedNfts.sorted { $0.rating > $1.rating }
        case .byName:
            return orderedNfts.sorted { $0.name < $1.name }
        }
    }
    
    func deleteNftFromOrder(id: String) {
        guard let order = order else { return }
        let newOder = order.nfts.filter { $0 != id }
        updateOrder(newNfts: newOder)
    }
}


