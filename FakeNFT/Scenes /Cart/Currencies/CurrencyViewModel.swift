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
    }
}
