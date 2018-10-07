//
//  BusStation.swift
//  openAPI
//
//  Created by Nebula_MAC on 08/10/2018.
//  Copyright © 2018 park.elon. All rights reserved.
//

import Foundation
import SwiftyXMLParser

extension SeoulBus {
    struct Station {
        
        ///정류소 ID
        let id: String
        
        ///정류쇼 고유 ID
        let uid: String
        
        ///정류소 명
        let name: String
        
        ///정류소 X 좌표 (WGS84)
        let wgsX: String
        ///정류소 Y 좌표 (WGS84)
        let wgsY: String
        
        ///정류소 X 좌표 (GRS80)
        let grsX: String
        ///정류소 Y 좌표 (GRS80)
        let grsY: String
        
        init(xml: XML.Accessor) {
            id = xml["stId"].text ?? ""
            uid = xml["arsId"].text ?? ""
            name = xml["stNm"].text ?? ""
            wgsX = xml["tmX"].text ?? ""
            wgsY = xml["tmY"].text ?? ""
            grsX = xml["posX"].text ?? ""
            grsY = xml["posY"].text ?? ""
        }
    }
}

struct SeoulBus {
    
    let code: String
    let message: String
    
    let itemCount: Int
    
    let itemList: [SeoulBus.Station]
    
    init(data: Data) {
        let xml = XML.parse(data)
        
        let serviceResult = xml["ServiceResult"]
        let header = serviceResult["msgHeader"]
        let body = serviceResult["msgBody"]
        
        code = header["headerCd"].text ?? ""
        message = header["headerMsg"].text ?? ""
        itemCount = header["itemCount"].int ?? 0
        
        itemList = body["itemList"].compactMap {
            return Station(xml: $0)
        }
    }
}
