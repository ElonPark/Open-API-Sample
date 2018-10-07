//
//  OpenAPI.swift
//  openAPI
//
//  Created by Nebula_MAC on 08/10/2018.
//  Copyright © 2018 park.elon. All rights reserved.
//

import Foundation
import Alamofire

extension SeoulBusAPI {
    ///정류장 정보
    enum Station: String {
        
        ///정류소 명칭 검색
        case getStationByNameList = "getStationByName"
        
        func path() -> String {
            let apiPath = "/api/rest/stationinfo/\(self.rawValue)"
            
            return apiPath
        }
        
        func absoluteURL() -> String {
            let seoulStationURL = "http://ws.bus.go.kr"
            let url = seoulStationURL + path()
            
            return url
        }
    }
}

///서울 버스 정보
struct SeoulBusAPI {
    
    static let shared = SeoulBusAPI()
    
    #warning("인증키를 입력하세요")
    static let serviceKey: String = <#Service Key#>
  
    ///정류소 명칭 검색
    static func station(byName searchKeyword: String, handler: ((SeoulBus?) -> Void)? = nil) {
        let stationByName: SeoulBusAPI.Station = .getStationByNameList
        let requestURL = stationByName.absoluteURL()
        
        ///공공데이터 key는 인코딩 되어 있기 때문에 디코딩한다.
        let deocdeKey =  serviceKey.removingPercentEncoding ?? ""
        
        ///파라미터로 넘기는 값은 Alamofire가 인코딩한다.
        let parameter: [String : String] = [
            "ServiceKey" : deocdeKey,
            "stSrch" : searchKeyword
        ]
        
        Alamofire.request(requestURL, method: .get, parameters: parameter)
            .responseData { (response) in
                var seoulBus: SeoulBus?
                
                defer {
                    handler?(seoulBus)
                }
                
                switch response.result {
                case .success(let result):
                    seoulBus = SeoulBus(data: result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
    }
}
