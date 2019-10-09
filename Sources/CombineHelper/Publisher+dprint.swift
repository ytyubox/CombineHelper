//
//  File.swift
//  
//
//  Created by 游宗諭 on 2019/9/18.
//

import Combine
public extension Publisher {
    func dprint(_ prefix: String = "", to stream: TextOutputStream? = nil,line:Int = #line,file:String = #file) -> Publishers.Print<Self> {
        return print("🙋🏼‍♂️" + file.split(separator:"/").last!.description + " " + line.description + prefix)
    }
}
