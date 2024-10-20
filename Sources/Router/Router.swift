import Combine
import SwiftUI

@Observable public final class Router<D: RoutableDestination> {
    var path = NavigationPath()
    var presentedDestination: D?
    private let subject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
}

public extension Router {
    var publisher: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }

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

    func observe(publisher: AnyPublisher<Void, Never>) {
        publisher.sink { [weak self] in
            self?.presentedDestination = nil
        }
        .store(in: &cancellables)
    }

    func pop() {
        path.removeLast()
    }

    func finish() {
        subject.send()
    }
}
