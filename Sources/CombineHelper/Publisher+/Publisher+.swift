//
//  File.swift
//  
//
//  Created by 游宗諭 on 2019/10/9.
//

import Combine

public extension Publisher {
    func applyWhenFailure(receiveError: @escaping (Failure) -> Void) ->  Publishers.Catch<Self, Empty<Self.Output, Never>> {
        self.catch { error -> Empty<Output, Never> in
            receiveError(error)
            return Empty<Output, Never>()
        }
    }
}
