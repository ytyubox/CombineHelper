//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/3/27.
//

import Combine
import Foundation

extension Publisher where Output == Data  {
	func strPrint(encoding:String.Encoding = .utf8) -> Publishers.Map<Self, Data> {
		map { data -> Data in
			Swift.print(String(data: data, encoding: encoding)!)
			return data
		}
	}
}
