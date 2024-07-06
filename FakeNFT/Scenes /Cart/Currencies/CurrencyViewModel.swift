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

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        getCurrencies()
    }

    private func getCurrencies() {
        let getCurrenciesRequest = GetCurrenciesRequest()
        sendRequestAndFetchResult(request: getCurrenciesRequest)
    }

    private func sendRequestAndFetchResult(request: NetworkRequest) {
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
}
