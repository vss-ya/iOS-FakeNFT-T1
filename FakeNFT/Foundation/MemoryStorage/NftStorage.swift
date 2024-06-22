import Foundation

protocol NftStorage: AnyObject {
    func saveNft(_ nft: NftDefault)
    func getNft(with id: String) -> NftDefault?
}

// Пример простого класса, который сохраняет данные из сети
final class NftStorageImpl: NftStorage {
    private var storage: [String: NftDefault] = [:]

    private let syncQueue = DispatchQueue(label: "sync-nft-queue")

    func saveNft(_ nft: NftDefault) {
        syncQueue.async { [weak self] in
            self?.storage[nft.id] = nft
        }
    }

    func getNft(with id: String) -> NftDefault? {
        syncQueue.sync {
            storage[id]
        }
    }
}
