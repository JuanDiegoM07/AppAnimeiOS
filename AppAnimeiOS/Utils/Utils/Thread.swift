//
//  Thread.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import Foundation

enum Thread {
    static func main(_ block: @escaping () -> Void?) {
        DispatchQueue.main.async {
            block()
        }
    }
}
