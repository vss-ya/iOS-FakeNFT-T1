import Foundation

final class CartViewModel {
    
    //MARK: - Properties
    
    private let networkClient = DefaultNetworkClient()
    private let storage = NftStorageImpl()
    private let nftService: NftServiceImpl
    private var order: Order?
    private(set) var orderedNfts: [Nft] = [] {
        didSet {
            orderedNftsBinding?(orderedNfts)
        }
    }
    var orderedNftsBinding: Binding<[Nft]>?
    
    init() {
        nftService = NftServiceImpl(networkClient: networkClient, storage: storage)
        getOrder()
    }
    
    // MARK: - Function
    
    private func getOrder() {
        let getOrderRequest = GetOrderRequest()
        networkClient.send(request: getOrderRequest, type: Order.self) { result in
            switch result {
            case .success(let order):
                self.order = order
                self.getOrderedNfts()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getOrderedNfts() {
        guard let order = order else { return }
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
            self.orderedNfts = nfts
        }
    }
}


