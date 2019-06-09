//
//  ViewController.swift
//  JSONWithTableView
//
//  Created by Chintalapudi Vinod on 6/6/18.
//  Copyright © 2018 brn. All rights reserved.
//

import UIKit
var arrayData = [Result]()
var copyrights = [String]()
var appImages = [String]()
var artistName=[String]()
var genricsdata=[Genre]()
var genricsId=[String]()
var some=[Link]()
var linkData=[String]()
//var bannerData:Welcome?
extension UITableView {
    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 2
        }
    }
}
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
@IBOutlet weak var tableView: UITableView!
    var sc = SecondViewController()
    var arrayCount:Int?
    
override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
    Json()
    }
    func Json(){
        
        let jsonUrlString = "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/100/explicit.json"
        let url = URL(string: jsonUrlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                guard  let data = data else{return}
                do
                {
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                   // bannerData = result
                    // print(result)
                    self.arrayCount = result.feed.results.count
                    
                    
                    for resultes in result.feed.links{
                        
                    print(resultes)
                        some += [resultes]
                        
                        
                    }
                    for resultes in result.feed.results
                    {
                      //arrayData +=resultes.
                        appImages += [resultes.artworkUrl100]
                        artistName += [resultes.artistName]
                       genricsdata += resultes.genres
                      //  arrayData +=
                        
                    }
                print(genricsdata)
                  
                   
                    self.tableView.reloadWithAnimation()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genricsdata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorColor = UIColor.clear
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for:indexPath)
        print(indexPath.row)
        cell.backgroundColor = UIColor.lightText
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 8.0
        cell.layer.borderColor = UIColor.green.cgColor
        let data = genricsdata[indexPath.row].url
        cell.textLabel?.text = data
        let myUrlImage = URL(string:appImages[indexPath.row])
        let image = try? Data(contentsOf: myUrlImage!)
        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width)!/2
        cell.imageView?.image = UIImage(data: image!)
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        sc = self.storyboard?.instantiateViewController(withIdentifier:"goToVC2") as! SecondViewController
        self.navigationController?.pushViewController(sc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func viewWillDisappear(_ animated: Bool) {
        let number = tableView.indexPathForSelectedRow
        print(arrayData[number!.row])
       // sc.labels.text = genricsdata[number!.row]
        let myUrlImage = URL(string:appImages[number!.row])
        let image = try? Data(contentsOf: myUrlImage!)
        sc.images.image = UIImage(data: image!)
    }
}

