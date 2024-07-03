import Foundation

enum MockCurrencies {
    static let currencies: [Currency] = [
        .init(
            id: "0",
            title: "Shiba Inu",
            name: "SHIB",
            image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png"
        ),

            .init(
                id: "1",
                title: "Cardano",
                name: "ADA",
                image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png"
            ),

            .init(
                id: "2",
                title: "Tether",
                name: "USDT", image:
                    "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png"
            ),

            .init(
                id: "3",
                title: "ApeCoin",
                name: "APE",
                image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/ApeCoin_(APE).png"),

            .init(
                id: "4",
                title: "Solana",
                name: "SOL",
                image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png"
            ),

            .init(
                id: "5",
                title: "Bitcoin",
                name: "BTC",
                image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png"
            ),

            .init(
                id: "6",
                title: "Dogecoin",
                name: "DOGE",
                image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png"
            ),

            .init(
                id: "7",
                title: "Ethereum",
                name: "ETH",
                image: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png"
            )
    ]
}
