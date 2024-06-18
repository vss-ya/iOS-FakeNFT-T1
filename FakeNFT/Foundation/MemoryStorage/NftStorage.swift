import Foundation

protocol NftStorage: AnyObject {
    func saveNft(_ nft: Nft_default)
    func getNft(with id: String) -> Nft_default?
}

// Пример простого класса, который сохраняет данные из сети
final class NftStorageImpl: NftStorage {
    private var storage: [String: Nft_default] = [:]

    private let syncQueue = DispatchQueue(label: "sync-nft-queue")

    func saveNft(_ nft: Nft_default) {
        syncQueue.async { [weak self] in
            self?.storage[nft.id] = nft
        }
    }

    func getNft(with id: String) -> Nft_default? {
        syncQueue.sync {
            storage[id]
        }
    }
}
