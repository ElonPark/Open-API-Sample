//
//  ViewController.swift
//  openAPI
//
//  Created by Nebula_MAC on 08/10/2018.
//  Copyright © 2018 park.elon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var busStationTextView: UITextView!
    
    ///이름으로 버스 정류장 검색
    func searchBusStation(byName keyword: String) {
        SeoulBusAPI.station(byName: keyword) { (busStation) in
            guard let result = busStation else { return }

            //UI업데이트는 메인 쓰레드에서
            DispatchQueue.main.async { [weak self] () in
                self?.busStationTextView.text = result.message + "\n\n"
                
                result.itemList.forEach {
                    self?.busStationTextView.text.append("정류소: \($0.name), uid: \($0.uid)\n")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBusStation(byName: "강남역")
    }
}

