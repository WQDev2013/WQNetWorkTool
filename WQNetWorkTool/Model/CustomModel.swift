//
//  CustomModel.swift
//  WQNetWorkTool
//
//  Created by chenweiqiang on 2020/5/29.
//  Copyright © 2020 chenweiqiang. All rights reserved.
//

import UIKit

import HandyJSON
class Chanel: HandyJSON{
    var name_en:  String?
    var seq_id: Int?
    var abbr_en: String?
    var name: String?
    var channel_id: Int?
    
    //用HandyJSON必须要实现这个方法
    required init() {}
}
