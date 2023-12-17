import SwiftUI

protocol ViewsBaseFactoryProtocol {
    
    associatedtype Content: View
    
    @ViewBuilder
    static func makeContent(type: BaseContentLink) -> Content
    
    associatedtype Sheet: View
    
    @ViewBuilder
    static func makeSheet(type: BaseSheetLink) -> Sheet
    
    associatedtype FullCover: View
    
    @ViewBuilder
    static func makeFullCover(type: BaseFullCoverLink) -> FullCover
}

enum ViewsBaseFactory: ViewsBaseFactoryProtocol {}
