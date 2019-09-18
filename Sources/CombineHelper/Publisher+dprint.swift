//
//  File.swift
//  
//
//  Created by 游宗諭 on 2019/9/18.
//

import Combine
@available(iOS 13.0, *)
extension Publisher {
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public
    func dprint(_ prefix: String = "", to stream: TextOutputStream? = nil,line:Int = #line,file:String = #file) -> Publishers.Print<Self> {
        return print("🙋🏼‍♂️" + file.split(separator:"/").last!.description + " " + line.description + prefix)
    }
}
