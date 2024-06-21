import Foundation

final class CartViewModel {
    
    //MARK: - Properties
    
    var order: Order? {
        didSet {
            orderBinding?(order!)
        }
    }
    var orderBinding: Binding<Order>?
    
    init() {
        order = getOrder()
    }
    
    // MARK: - Function
    
    private func getOrder() -> Order {
        order = MockData().mockOrder
        return order!
    }
}
