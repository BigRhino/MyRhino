//
//  main.swift
//  DynamicMember
//
//  Created by Rhino on 2020/5/23.
//  Copyright © 2020 Rhino. All rights reserved.
//

import Foundation


class Texture{
    var isSparkly:Bool = false
    
    init() {
        
    }
    init(copying:Texture) {
        isSparkly = copying.isSparkly
    }
    
}

@dynamicMemberLookup
struct Material {
    public  var  color:String
    private var _texture:Texture
    
    public subscript<T>(dynamicMember keyPath:ReferenceWritableKeyPath<Texture,T> ) -> T{
        get{
            _texture[keyPath:keyPath]
        }
        set{
            if !isKnownUniquelyReferenced(&_texture){
                _texture = Texture(copying: _texture)
            }
            _texture[keyPath:keyPath] = newValue
        }
    }
    init(color:String,texture:Texture) {
        self.color = color
        self._texture = texture
    }

}


let x = Texture()
var m1 = Material(color: "123", texture: x)
print(m1.isSparkly)
