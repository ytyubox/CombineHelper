//
//  File.swift
//  
//
//  Created by 游宗諭 on 2019/10/9.
//

import Combine

public extension Publisher where Failure == Never {
    func optionalAssign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Optional<Output>>, on: Root) -> AnyCancellable {
        map {let q: Output? = $0;return q}
            .assign(to: keyPath, on: on)
    }
    func perform<Root: AnyObject, F>(function: KeyPath<Root, F>, on object: Root) -> AnyCancellable {
        sink {[weak object] output in
            guard let ob = object else {return}
            let f = getF(keyPath: function, o: ob, type: output.self)
            f(output)
        }
    }
}

func getF<Root, F, Output>(keyPath: KeyPath<Root, F>, o: Root, type: Output) -> (Output) -> Void {
    return o[keyPath:keyPath] as! (Output) -> Void
}
