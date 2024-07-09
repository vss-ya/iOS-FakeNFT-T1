import Foundation

final class CurrencyViewModel {

    // MARK: - Properties

    private let networkClient: NetworkClient
    private(set) var currencies: [Currency] = [] {
        didSet {
            currenciesBinding?(currencies)
        }
    }
    var currenciesBinding: Binding<[Currency]>?
    var isLoadingBinding: Binding<Bool>?
    var showPaymentResult: Binding<Bool>?

    // MARK: - Initialization

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        getCurrencies()
    }

    // MARK: - Private Function

    private func getCurrencies() {
        let request = GetCurrenciesRequest()
        isLoadingBinding?(true)
        networkClient.send(request: request, type: [Currency].self) { result in
            self.isLoadingBinding?(false)
            switch result {
            case .success(let currencies):
                self.currencies = currencies
            case .failure(let error):
                print(error)
            }
        }
    }

    private func sendOrderPaymentRequest(id: String) {
        let request = OrderPaymentRequest(currencyId: id)
        isLoadingBinding?(true)
        networkClient.send(request: request, type: PaymentResult.self) { result in
            self.isLoadingBinding?(false)
            switch result {
            case .success(let paymentResult):
                if paymentResult.success {
                    self.emptyCart()
                    self.showPaymentResult?(true)
                } else {
                    self.showPaymentResult?(false)
                }
            case .failure(let error):
                print(error)
                self.showPaymentResult?(false)
            }
        }
    }

    private func emptyCart() {
        let nftService = NftServiceImpl(networkClient: self.networkClient, storage: NftStorageImpl())
        let cartViewModel = CartViewModel(networkClient: self.networkClient, nftService: nftService)
        cartViewModel.updateOrder(newNfts: [])
    }

    // MARK: - Internal Function

    func paymentButtonTapped(with currencyIndex: Int) {
        let currencyId = currencies[currencyIndex].id
        sendOrderPaymentRequest(id: currencyId)
    }
}
