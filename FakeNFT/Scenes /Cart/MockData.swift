import Foundation

final class MockData {
    var mockOrder = Order(
        id: "1",
        nfts: ["1", "2", "3", "4"]
        )
      
    var nfts: [Nft] = [Nft(
                id: "1",
                name: "Luna",
                images: [URL(string: "https://img.freepik.com/free-photo/beautiful-kitten-with-colorful-clouds_23-2150752964.jpg?size=626&ext=jpg&ga=GA1.1.1788614524.1718668800&semt=ais_user")!],
                rating: 0,
                price: 14.53),
            Nft(
                id: "2",
                name: "Sun",
                images: [URL(string: "https://masterpiecer-images.s3.yandex.net/8343a271809911eebb893a7ca4cc1bdc:upscaled")!],
                rating: 1,
                price: 14.5),
            Nft(
                id: "3",
                name: "Mars",
                images: [URL(string: "https://cs11.pikabu.ru/post_img/2019/02/04/12/1549312329147951618.jpg")!],
                rating: 3,
                price: 14.5),
            Nft(
                id: "4",
                name: "Yran",
                images: [URL(string: "https://st2.depositphotos.com/1886175/8316/i/450/depositphotos_83169300-stock-photo-gray-striped-cat-playful-cute.jpg")!],
                rating: 5,
                price: 14.5)]
}
            
            
            
           
