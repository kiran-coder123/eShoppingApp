//
//  FirebaseCollectionReference.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 22/09/22.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func firebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
