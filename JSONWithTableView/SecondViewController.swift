//
//  SecondViewController.swift
//  JSONWithTableView
//
//  Created by Chintalapudi Vinod on 6/6/18.
//  Copyright © 2018 brn. All rights reserved.
//

import UIKit
class SecondViewController: UIViewController {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var labels: UILabel!
    @IBOutlet weak var getBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        images.layer.cornerRadius = 30
        images.clipsToBounds = true
        getBut.layer.cornerRadius = 15
        print(appImages)
        print(arrayData)
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
