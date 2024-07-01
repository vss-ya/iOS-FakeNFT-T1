
import Foundation

struct CollectionParams {
    let cellCount: Int
    let height: CGFloat
    let leftInset: CGFloat
    let rightInset: CGFloat
    let cellSpacing: CGFloat
    
    init(cellCount: Int, height: CGFloat, leftInset: CGFloat, rightInset: CGFloat, cellSpacing: CGFloat) {
        self.cellCount = cellCount
        self.height = height
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.cellSpacing = cellSpacing
    }
}
