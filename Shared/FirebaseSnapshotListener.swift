//import Firebase
//
//struct User { }
//
//func addListenerToUsers(completion: @escaping (Result<[User],Error>) -> Void) {
//  let db = Firestore.firestore()
//  db.collection("users").addSnapshotListener { (snapshot, error) in
//    guard let snapshot = snapshot else {
//      completion(.failure(error!))
//      return
//    }
//
//    let users: [User] = snapshot.documents.compactMap({ User(document: $0) })
//    completion(.success(users))
//  }
//}
