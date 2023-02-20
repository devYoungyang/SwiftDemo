//
//  Dictionary+Extension.swift
//  SwiftDemo
//
//  Created by Yang on 2022/11/24.
//

import Foundation

extension Dictionary {
    func has(_ key: Key) -> Bool{
        return index(forKey: key) != nil
    }
    
    static func jsonToDictionary(json: String) -> Dictionary<String, Any>? {
        if let data = (try? JSONSerialization.jsonObject(with: json.data(using: String.Encoding.utf8,allowLossyConversion: true)!,options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String,Any>{
            return data
        }else{
           return nil
        }
    }
    
//    func toJSON() -> String? {
//        if let jsonData = try? JSONSerialization.data(withJSONObject: self,options: JSONSerialization.WritingOptions()){
//            let jsonStr = String(data: jsonData, encoding: String.Encoding.utf8.rawValue)
//            return String(jsonStr ?? "")
//        }
//        return nil
//    }
    
    func allKeys() -> [Key] {
        return self.keys.shuffled()
    }
    func allValue() -> [Value] {
        return self.values.shuffled()
    }
    
    
}
