import SwiftUI

public protocol RoutableDestination: Identifiable, Hashable {
    var transition: RoutingTransition { get }

    associatedtype C: View
    func content(router: Router<Self>) -> C
}

public extension RoutableDestination {
    var id: Self {
        self
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
