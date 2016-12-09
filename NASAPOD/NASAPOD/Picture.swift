//
//  Picture.swift
//  NASAPOD
//
//  Created by Jermaine Kelly on 11/5/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class Picture{
    let date: String
    let description: String
    let title: String
    let url: String
    
    init(date:String,description:String,title:String,url:String){
        self.date = date
        self.description = description
        self.title = title
        self.url = url
    }
    
    convenience init?(from dicitonary: [String:String]){
        if let date = dicitonary["date"],
            let description = dicitonary["explanation"],
            let title = dicitonary["title"],
            let url = dicitonary["url"]{
            
            self.init(date:date,description:description,title:title,url:url)
        }else{
            return nil
        }
        
    }
    
    static func buildPicObject(from data:Data )-> Picture?{
        var pictureObj: Picture?
        
        do {
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
            guard let picInfo = jsonDict as? [String:String] else{ return nil }
            pictureObj = Picture(from: picInfo)
            
        }catch{
            
        }
        return pictureObj
    }
}
