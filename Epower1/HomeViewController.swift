//
//  HomeViewController.swift
//  Epower1
//
//  Created by Bharath Bandaru on 23/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource{
    var topass : String?
    var firstURL = "http://192.168.0.103/elec_dir/top_cat.php"
    var snos = Array<String>()
    var jobcats = Array<String>()
    @IBOutlet weak var collectionview: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let parameters: Parameters = [:]
        
        Alamofire.request(firstURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    
                    let responseJSON = JSON(resultValue)
                    for index in responseJSON["data"].array!{
                        self.snos.append(index["sno"].string!)
                        self.jobcats.append(index["job_cat"].string!)
                    }
                    DispatchQueue.main.async {
                          self.collectionview.reloadData()
                        
                    }
                    print(self.jobcats)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    DispatchQueue.main.async {
                         self.collectionview.reloadData()
                        
                    }
                    
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
                
                
        }

        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let cell : HomeCollectionViewCell = collectionview.dequeueReusableCell(withReuseIdentifier: "collect", for: indexPath) as! HomeCollectionViewCell
        topass = jobcats[indexPath.row]

        performSegue(withIdentifier: "onetotwo", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("here")
        
        if segue.identifier == "onetotwo" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.pass = topass
            
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCollectionViewCell = collectionview.dequeueReusableCell(withReuseIdentifier: "collect", for: indexPath) as! HomeCollectionViewCell
        cell.catlabel.text = jobcats[indexPath.row]
        print("heyy",jobcats[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobcats.count
    }
    
   

}
