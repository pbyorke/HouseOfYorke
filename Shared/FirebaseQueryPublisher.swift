//import Combine
//import Firebase
//
//struct FirebaseQueryPublisher: Publisher {
//        typealias Output = [QueryDocumentSnapshot]
//        typealias Failure = Error
//        
//        let query: Query
//        
//        init(query: Query) {
//            self.query = query
//        }
//        
//        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
//            let subscription =
//                FirebaseListeningSubscription(query: query, subscriber: subscriber)
//            subscriber.receive(subscription: subscription)
//        }
//    }
