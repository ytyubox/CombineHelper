//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/3/27.
//

import Foundation

extension Result:Decodable where Success: Decodable, Failure: Decodable {
	public init(from decoder: Decoder) throws {
		do {
			let s = try Success(from: decoder)
			self = .success(s)
			return
		} catch let sError {
			if let f = try? Failure(from: decoder) {
				self = .failure(f)
				return
			}
			throw sError
		}
	}
}
