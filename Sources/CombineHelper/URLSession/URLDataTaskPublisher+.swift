//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/3/27.
//

import Combine
import Foundation
public
extension Publisher {
  func twoDecode<Success,Failure,Decoder>
    (twDecodable: Result<Success,Failure>.Type, decoder: Decoder)
    -> AnyPublisher<Result<Success, Failure>, Error>
    where Success: Decodable,Failure: Decodable & Error,Decoder: TopLevelDecoder, Self.Output == Decoder.Input {
      tryMap { (o)  in
        return try decoder.decode(Result<Success,Failure>.self, from:o)
      }
      .eraseToAnyPublisher()
  }
}

extension URLSession.DataTaskPublisher {
  func handleResponse(_ handler: @escaping (Output)throws -> Void) -> AnyPublisher<Data, Error> {
    tryMap { (output) -> Data in
      try handler(output)
      return output.data
    }
    .eraseToAnyPublisher()
    
  }
}

