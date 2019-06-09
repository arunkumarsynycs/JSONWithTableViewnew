//
//  ThirdViewController.swift
//  JSONWithTableView
//
//  Created by Arun Reddy on 09/06/19.
//  Copyright © 2019 brn. All rights reserved.
//

import UIKit

var some1=[Response]()
var some2=[ListOfEventImagesDto]()
class ThirdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var arrayCount:Int?

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
Json()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return some1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TbleCell
        cell.textLabel?.text=some1[indexPath.row].eventname
        print(some1[indexPath.row].eventname)
        return cell
    }
    func Json(){
        
        let jsonUrlString = "http://app.apll.info/student/event/filterWithDate"
        let url = URL(string: jsonUrlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                guard  let data = data else{return}
                do
                {
                    let result = try JSONDecoder().decode(Results.self, from: data)
                    // bannerData = result
                    // print(result)
                    self.arrayCount = result.response.count
                    
                    for resultes in result.response{
                        
                        print(resultes)
                        some1 += [resultes]
                        
                        
                    }
                    print(some1.count)
                    for resultes in result.response
                    {
                        //arrayData +=resultes.
                        some2 += resultes.listOfEventImagesDto
                        //  arrayData +=

                    }
//                    print(genricsdata)
                    
                    
                    self.tblView.reloadData()
                }catch
                {
                    print(error)
                    let alert = UIAlertController(title: "Data Not Found", message:"Incorrect Data", preferredStyle: UIAlertControllerStyle.alert)
                    self.present(alert, animated: true, completion: nil)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(ok)
                }
            }
            }.resume()
        
    }
    
   

}
class TbleCell:UITableViewCell{
    
}
