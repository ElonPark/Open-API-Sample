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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SeoulBusAPI.station(byName: "강남역") { (busStation) in
            guard let result = busStation else { return }
            
            DispatchQueue.main.async { [weak self] () in
                self?.busStationTextView.text = result.message + "\n\n"
                
                result.itemList.forEach {
                    self?.busStationTextView.text.append("정류소: \($0.name), uid: \($0.uid)\n")
                }
            }
        }
    }
}

