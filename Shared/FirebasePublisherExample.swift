//import Firebase
//
//struct UserWorker: QueryPublisher {
//  var db: Firestore! = Firestore.firestore()
//
//  var userChanges -> AnyPublisher<[Users], Error> {
//    let query = db.collection("users")
//    publisher(for: query).compactMap({ snapshot in
//        return snapshot.compactMap({ Users(document: $0) })
//    }).eraseToAnyPublisher()
//  }
//}
