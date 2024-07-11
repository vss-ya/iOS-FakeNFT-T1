// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// По названию
    internal static let byName = L10n.tr("Localizable", "byName", fallback: "По названию")
    /// По цене
    internal static let byPrice = L10n.tr("Localizable", "byPrice", fallback: "По цене")
    /// По рейтингу
    internal static let byRating = L10n.tr("Localizable", "byRating", fallback: "По рейтингу")
    internal enum Cart {
        /// Закрыть
        internal static let close = L10n.tr("Localizable", "Cart.close", fallback: "Закрыть")
        /// Корзина пуста
        internal static let emptyCart = L10n.tr("Localizable", "Cart.emptyCart", fallback: "Корзина пуста")
        /// Не удалось загрузить корзину
        internal static let errorMessage = L10n.tr("Localizable", "Cart.errorMessage", fallback: "Не удалось загрузить корзину")
        /// К оплате
        internal static let paymentButtonTitle = L10n.tr("Localizable", "Cart.paymentButtonTitle", fallback: "К оплате")
        /// Сортировка
        internal static let sortTitle = L10n.tr("Localizable", "Cart.sortTitle", fallback: "Сортировка")
    }
    internal enum CartCell {
        /// Цена
        internal static let price = L10n.tr("Localizable", "CartCell.price", fallback: "Цена")
    }
    internal enum Catalog {
        /// Автор коллекции:
        internal static let collectionAuthor = L10n.tr("Localizable", "Catalog.collectionAuthor", fallback: "Автор коллекции: ")
        /// Открыть Nft
        internal static let openNft = L10n.tr("Localizable", "Catalog.openNft", fallback: "Открыть Nft")
        /// По названию
        internal static let sortByName = L10n.tr("Localizable", "Catalog.sortByName", fallback: "По названию")
        /// По количеству NFT
        internal static let sortByNftCount = L10n.tr("Localizable", "Catalog.sortByNftCount", fallback: "По количеству NFT")
        /// Закрыть
        internal static let sortCancel = L10n.tr("Localizable", "Catalog.sortCancel", fallback: "Закрыть")
        /// Сортировка
        internal static let sortMessage = L10n.tr("Localizable", "Catalog.sortMessage", fallback: "Сортировка")
    }
    internal enum Currency {
        /// Повторить
        internal static let actionText = L10n.tr("Localizable", "Currency.actionText", fallback: "Повторить")
        /// Совершая покупку, вы соглашаетесь с условиями
        internal static let agreementLabel = L10n.tr("Localizable", "Currency.agreementLabel", fallback: "Совершая покупку, вы соглашаетесь с условиями")
        /// Не удалось произвести оплату
        internal static let errorMessage = L10n.tr("Localizable", "Currency.errorMessage", fallback: "Не удалось произвести оплату")
        /// Выберите способ оплаты
        internal static let navItemTitle = L10n.tr("Localizable", "Currency.navItemTitle", fallback: "Выберите способ оплаты")
        /// Оплатить
        internal static let paymentButton = L10n.tr("Localizable", "Currency.paymentButton", fallback: "Оплатить")
        /// Пользовательского соглашения
        internal static let termsLabel = L10n.tr("Localizable", "Currency.termsLabel", fallback: "Пользовательского соглашения")
    }
    internal enum Error {
        /// Произошла ошибка сети
        internal static let network = L10n.tr("Localizable", "Error.network", fallback: "Произошла ошибка сети")
        /// Повторить
        internal static let `repeat` = L10n.tr("Localizable", "Error.repeat", fallback: "Повторить")
        /// Ошибка
        internal static let title = L10n.tr("Localizable", "Error.title", fallback: "Ошибка")
        /// Произошла неизвестная ошибка
        internal static let unknown = L10n.tr("Localizable", "Error.unknown", fallback: "Произошла неизвестная ошибка")
    }
    internal enum NftRemoval {
        /// Вернуться
        internal static let cancelButton = L10n.tr("Localizable", "NftRemoval.cancelButton", fallback: "Вернуться")
        /// Удалить
        internal static let deleteButton = L10n.tr("Localizable", "NftRemoval.deleteButton", fallback: "Удалить")
        /// Вы уверены, что хотите удалить объект из корзины?
        internal static let messageLabel = L10n.tr("Localizable", "NftRemoval.messageLabel", fallback: "Вы уверены, что хотите удалить объект из корзины?")
    }
    internal enum Profile {
        /// О разработчике
        internal static let aboutDeveloper = L10n.tr("Localizable", "Profile.aboutDeveloper", fallback: "О разработчике")
        /// По названию
        internal static let byName = L10n.tr("Localizable", "Profile.byName", fallback: "По названию")
        /// По цене
        internal static let byPrice = L10n.tr("Localizable", "Profile.byPrice", fallback: "По цене")
        /// По рейтингу
        internal static let byRating = L10n.tr("Localizable", "Profile.byRating", fallback: "По рейтингу")
        /// Сменить
        /// фото
        internal static let changePhoto = L10n.tr("Localizable", "Profile.changePhoto", fallback: "Сменить\nфото")
        /// Закрыть
        internal static let close = L10n.tr("Localizable", "Profile.close", fallback: "Закрыть")
        /// Описание
        internal static let description = L10n.tr("Localizable", "Profile.description", fallback: "Описание")
        /// Избранные NFT
        internal static let favoritesNft = L10n.tr("Localizable", "Profile.favoritesNft", fallback: "Избранные NFT")
        /// от
        internal static let from = L10n.tr("Localizable", "Profile.from", fallback: "от")
        /// Сайт
        internal static let link = L10n.tr("Localizable", "Profile.link", fallback: "Сайт")
        /// Загрузить изображение
        internal static let loadImage = L10n.tr("Localizable", "Profile.loadImage", fallback: "Загрузить изображение")
        /// Мои NFT
        internal static let myNft = L10n.tr("Localizable", "Profile.myNft", fallback: "Мои NFT")
        /// Имя
        internal static let name = L10n.tr("Localizable", "Profile.name", fallback: "Имя")
        /// У Вас ещё нет избранных NFT
        internal static let noFavoritesNft = L10n.tr("Localizable", "Profile.noFavoritesNft", fallback: "У Вас ещё нет избранных NFT")
        /// У Вас ещё нет NFT
        internal static let noMyNft = L10n.tr("Localizable", "Profile.noMyNft", fallback: "У Вас ещё нет NFT")
        /// Вставьте ссылку на изображение
        internal static let pasteLinkToImage = L10n.tr("Localizable", "Profile.pasteLinkToImage", fallback: "Вставьте ссылку на изображение")
        /// Цена
        internal static let price = L10n.tr("Localizable", "Profile.price", fallback: "Цена")
        /// Сортировка
        internal static let sort = L10n.tr("Localizable", "Profile.sort", fallback: "Сортировка")
    }
    internal enum Statistics {
        internal enum LoadDataError {
            /// Отмена
            internal static let cancel = L10n.tr("Localizable", "Statistics.loadDataError.cancel", fallback: "Отмена")
            /// Повторить
            internal static let `repeat` = L10n.tr("Localizable", "Statistics.loadDataError.repeat", fallback: "Повторить")
            /// Не удалось получить данные
            internal static let title = L10n.tr("Localizable", "Statistics.loadDataError.title", fallback: "Не удалось получить данные")
        }
        internal enum StatisticsProfile {
            /// Коллекция NFT
            internal static let nftsCollectionButton = L10n.tr("Localizable", "Statistics.statisticsProfile.nftsCollectionButton", fallback: "Коллекция NFT")
            /// Перейти на сайт пользователя
            internal static let userWebsiteButton = L10n.tr("Localizable", "Statistics.statisticsProfile.userWebsiteButton", fallback: "Перейти на сайт пользователя")
        }
        internal enum StatisticsSort {
            /// По имени
            internal static let byName = L10n.tr("Localizable", "Statistics.statisticsSort.byName", fallback: "По имени")
            /// По рейтингу
            internal static let byRating = L10n.tr("Localizable", "Statistics.statisticsSort.byRating", fallback: "По рейтингу")
            /// Закрыть
            internal static let close = L10n.tr("Localizable", "Statistics.statisticsSort.close", fallback: "Закрыть")
            /// Сортировка
            internal static let title = L10n.tr("Localizable", "Statistics.statisticsSort.title", fallback: "Сортировка")
        }
        internal enum StatisticsUserCollection {
            /// Коллекция NFT
            internal static let title = L10n.tr("Localizable", "Statistics.statisticsUserCollection.title", fallback: "Коллекция NFT")
        }
    }
    internal enum SuccessPay {
        /// Вернуться в каталог
        internal static let goToCatalogButton = L10n.tr("Localizable", "SuccessPay.goToCatalogButton", fallback: "Вернуться в каталог")
        /// Успех! Оплата прошла, поздравляем с покупкой!
        internal static let successLabel = L10n.tr("Localizable", "SuccessPay.successLabel", fallback: "Успех! Оплата прошла, поздравляем с покупкой!")
    }
    internal enum Tab {
        /// Корзина
        internal static let cart = L10n.tr("Localizable", "Tab.cart", fallback: "Корзина")
        /// Каталог
        internal static let catalog = L10n.tr("Localizable", "Tab.catalog", fallback: "Каталог")
        /// Профиль
        internal static let profile = L10n.tr("Localizable", "Tab.profile", fallback: "Профиль")
        /// Статистика
        internal static let statistics = L10n.tr("Localizable", "Tab.statistics", fallback: "Статистика")
    }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: BundleToken.self)
#endif
    }()
}
// swiftlint:enable convenience_type

