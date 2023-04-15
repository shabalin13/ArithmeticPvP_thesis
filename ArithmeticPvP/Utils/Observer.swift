//
//  Observer.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 14.03.2023.
//

import Foundation

class Observable<T> {

    typealias Listener = (T) -> Void
    private var listener: Listener?

    var value: T {
        didSet {
            self.listener?(self.value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
