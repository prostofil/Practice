
//


import Foundation
import RxSwift
import RxFeedback
import RxCocoa

    /// Базовый протокол состояния.
    public protocol State {
        /// События ассоциированные с данным состоянием.
        associatedtype Event
        /// Reducer данного состояния.
        static func reduce(state: Self, event: Event) -> Self
    }

    /// Сайд эффект.
    public typealias SideEffect<State, Event> = (ObservableSchedulerContext<State>) -> Observable<Event>

     final class StateStore<S: State> {
         let eventBus: PublishRelay<S.Event>
         let stateBus: Driver<S>

         private let bag = DisposeBag()

         init(initial: S, sideEffects: [SideEffect<S, S.Event>], scheduler: SchedulerType = MainScheduler.instance) {
             let _eventBus = PublishRelay<S.Event>()
             eventBus = _eventBus

             let eventBusFeedback: SideEffect<S, S.Event> = { observableContext -> Observable<S.Event> in
                 _eventBus.observeOn(observableContext.scheduler)
             }

             var feedBacks = sideEffects
             feedBacks.append(eventBusFeedback)

             stateBus = Observable.system(initialState: initial,
                                          reduce: S.reduce,
                                          scheduler: scheduler,
                                          scheduledFeedback: feedBacks)
                 .asDriver(onErrorDriveWith: .never())
         }

         @discardableResult
         func run() -> Self {
             stateBus.drive()
                 .disposed(by: bag)

             return self
         }
     }

