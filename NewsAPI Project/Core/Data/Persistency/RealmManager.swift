//
//  RealmManager.swift
//  NewsAPI Project
//
//  Created by Álvaro Ferrández Gómez on 3/2/22.
//

import Foundation
import RealmSwift

final class RealmManager {
    public static func addNew(model: NewModelRealm) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model)
            }
        } catch {
            debugPrint("ERROR creating realm database.")
        }
    }

    public static func retrieveNews(_ completion: @escaping Response<[NewModelRealm]>) {
        do {
            let realm = try Realm()
            let news = realm.objects(NewModelRealm.self)

            var response: [NewModelRealm] = []
            for new in news {
                response.append(new)
            }

            completion(.success(response))
        } catch {
            debugPrint("ERROR creating realm database.")
            let err = NSError(domain: "Error decoding data.", code: 401, userInfo: [:])
            completion(.error(err))
        }
    }
}
