import Foundation

final class CartViewModel {
    
    //MARK: - Properties
    
    private var networkClient: NetworkClient
    private var nftService: NftService
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
    
    private func getOrder() {
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
            self.orderedNfts = nfts
            self.isLoadingBinding?(false)
        }
    }
}


