//import Combine
//import Firebase
//
//final class FirebaseListeningSubscription<S: Subscriber>: Subscription where S.Input == [QueryDocumentSnapshot], S.Failure == Error {
//        
//        let query: Query
//        var subscriber: S?
//        var listener: ListenerRegistration?
//        
//        init(query: Query, subscriber: S) {
//            self.query = query
//            self.subscriber = subscriber
//            listenToQuery()
//        }
//        
//        func request(_ demand: Subscribers.Demand) {
//            // leave this blanks
//            // means we subscribe to an infinite amount of values
//        }
//        
//        func cancel() {
//            listener?.remove()
//            listener = nil
//            subscriber = nil
//        }
//        
//        func listenToQuery() {
//            guard let subscription = subscriber else { return }
//            var isLoaded = false
//            listener = query.addSnapshotListener { (snapshot, error) in
//                guard let snapshot = snapshot else {
//                    _ = error.flatMap { subscription.receive(completion: .failure($0)) }
//                    return
//                }
//                if !isLoaded {
//                    isLoaded = true
//                    _ = subscription.receive(snapshot.documents)
//                } else {
//                    let changes = snapshot.documentChanges.compactMap({ $0.document })
//                    _ = subscription.receive(changes)
//                }
//            }
//        }
//    }
