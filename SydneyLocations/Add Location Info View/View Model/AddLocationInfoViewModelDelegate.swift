import Foundation

protocol AddLocationInfoDelegate: AnyObject {
    func onSaveTap(name: String, description: String)
}
