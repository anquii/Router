import SwiftUI

@Observable public final class Router<D: RoutableDestination> {
    var path = NavigationPath()
    var presentedDestination: D?
}

public extension Router {
    @ViewBuilder func content(destination: D) -> some View {
        destination.content(router: self)
    }

    func showDestination(_ destination: D) {
        switch destination.transition {
        case .push:
            path.append(destination)
        case .sheet:
            presentedDestination = destination
        }
    }

    func finish() {
        presentedDestination = nil
    }
}
