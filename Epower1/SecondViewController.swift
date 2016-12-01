//
//  SecondViewController.swift
//  Epower1
//
//  Created by Bharath Bandaru on 22/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration

class SecondViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate , UITableViewDelegate , UITableViewDataSource,UISearchBarDelegate{
    var pass : String?
    var statevalue: String?
    var  valuename: String?
    var  valueemail: String?
    var  valueaddr: String?
    var  valuephno: String?
    var valuesearch: String?
    var cityvalue: String?
    var jobvalue: String?
    var flag : Int = 0
    @IBOutlet weak var headlabel: UILabel!
    @IBOutlet weak var searchbutton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var searchActive : Bool = false
    var filtered:[String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var serachButton: UIButton!
    var snos = Array<String>()
    var state_arr = Array<String>()
    var city_arr = Array<String>()
    var job_arr = Array<String>()
    var name_arr = Array<String>()
    var email_arr = Array<String>()
    var phn_arr = Array<String>()
    var add_arr = Array<String>()
    var all = Array<String>()

    @IBOutlet weak var jobch: UITextField!
    @IBOutlet weak var statech: UITextField!
    @IBOutlet weak var citych: UITextField!
    var stateURL = "http://192.168.0.102/elec_dir/state.php"
    var cityURL = "http://192.168.0.102/elec_dir/city.php"
    var jobURL = "http://192.168.0.102/elec_dir/job.php"
    var testURL = "http://192.168.0.102/elec_dir/test.php"
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    var toolBar = UIToolbar()
    var toolBar2 = UIToolbar()
    var toolBar3 = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        if(pass == "APPDCL" || pass == "APTRANCO" || pass == "APGENCO"){
            statech.text = "AP"
            statevalue = "ap"
            statech.isEnabled = false
            citych.isEnabled = true
            searchbutton.isEnabled = true
            callCityAlmo(url: cityURL)

        }
        else if(pass == "TSPDCL" || pass == "TSTRANCO" || pass == "TSGENCO"){
            statech.text = "Telangana"
            statevalue = "Telangana"
            statech.isEnabled = false
            citych.isEnabled = true
            searchbutton.isEnabled = true
            callCityAlmo(url: cityURL)

        }
        else{
            citych.isEnabled = false
            searchbutton.isEnabled = false

        }
       //   self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "detailID")
        callStateAlmo(url: stateURL)
        callJobAlmo(url: jobURL)
        searchbutton.clipsToBounds=true
        searchbutton.layer.cornerRadius=searchbutton.frame.size.height/2
        //callCityAlmo(url: cityURL)
        headlabel.text = pass
        //searchBar.delegate = self

        pickerView1.tag = 1
        pickerView2.tag = 2
        pickerView3.tag = 3
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.delegate = self
        pickerView3.delegate = self
        pickerView3.delegate = self
        statech.inputView = pickerView1
        citych.inputView = pickerView2
        jobch.inputView = pickerView3
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar2.sizeToFit()
        toolBar3.barStyle = UIBarStyle.default
        toolBar3.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar3.sizeToFit()
        let doneButtons = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.donePickerS))
        let spaceButtons = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButtons = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.canclePickerS))
        
        
        
        
        let doneButtonc = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.donePickerC))
        let spaceButtonc = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButtonc = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.canclePickerC))
        
        
        
        let doneButtonj = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.donePickerJ))
        let spaceButtonj = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action: nil)
        let cancelButtonj = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SecondViewController.canclePickerJ))
        toolBar.setItems([cancelButtons, spaceButtons, doneButtons], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar2.setItems([cancelButtonc, spaceButtonc, doneButtonc], animated: false)
        toolBar2.isUserInteractionEnabled = true
        toolBar3.setItems([cancelButtonj, spaceButtonj, doneButtonj], animated: false)
        toolBar3.isUserInteractionEnabled = true
        statech.inputView = pickerView1
        citych.inputView = pickerView2
        jobch.inputView = pickerView3
        statech.inputAccessoryView = toolBar
        citych.inputAccessoryView = toolBar2
        jobch.inputAccessoryView = toolBar3
        //statevalue = "ALL"

        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if(isConnectedToNetwork()){valuesearch = self.searchBar.text
        callTestAlmo(url: testURL)
        self.tableView.reloadData()
        self.searchBar.endEditing(true) }else{
    
    let alertController = UIAlertController(title: "No Internet!", message: "Please enable your connection.", preferredStyle: .alert)
    self.present(alertController, animated: true, completion:nil)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
    print("You've pressed OK button");
    }
    alertController.addAction(OKAction)
    }
    
    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        filtered = self.name_arr.filter({ (text) -> Bool in
//            print("search\(filtered)")
//            let tmp: NSString = text as NSString
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        })
//        filtered = self.name_arr.filter({ (text) -> Bool in
//            print("search\(filtered)")
//            let tmp: NSString = text as NSString
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        })
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.tableView.reloadData()
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    

    @IBAction func citybfunc(_ sender: Any) {
    }
    
    
    func callStateAlmo( url : String){
        let parameters: Parameters = [:]
        flag = 1
        print("1111111")

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                        self.state_arr.append(index["state"].string!)
                    }
                    DispatchQueue.main.async {
                        //  self.firstTableView.reloadData()
                        
                    }
                    print(self.state_arr)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    DispatchQueue.main.async {
                        //   self.firstTableView.reloadData()
                        
                    }
                    
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
                
                
        }
    }
    func callTestAlmo( url : String){
        flag = 1
        print("1111111")
        name_arr.removeAll()
        email_arr.removeAll()
        phn_arr.removeAll()
        add_arr.removeAll()
        state_arr.append("ALL")
        let parameters: Parameters = ["state": statevalue ?? "ALL","city": cityvalue ?? "ALL","job_cat": pass ?? "other","job": jobvalue ?? "ALL","search_key": valuesearch ?? "NONE"]
        Alamofire.request(url, method: .post, parameters: parameters)
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
                    if(!responseJSON["error"].boolValue){
                        for index in responseJSON["data"].array!{
                            self.name_arr.append(index["name"].string!)
                            self.email_arr.append(index["email"].string!)
                            
                            self.phn_arr.append(index["mobile"].string!)
                            
                            self.add_arr.append(index["addr"].string!)
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        print(self.state_arr)
                        
                        break
                    }else{
                        self.name_arr.removeAll()
                        self.phn_arr.removeAll()
                        self.email_arr.removeAll()
                        self.add_arr.removeAll()
                        self.tableView.reloadData()
                        let alertController = UIAlertController(title: "Result", message: "No Results found", preferredStyle: .alert)
                        self.present(alertController, animated: true, completion:nil)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                            print("You've pressed OK button");
                        }
                        alertController.addAction(OKAction)
                    }
                   
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    DispatchQueue.main.async {
                        //   self.firstTableView.reloadData()
                        
                    }
                    
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
                
                
        }
    }
    
    @IBAction func searchbutfun(_ sender: Any) {
        if(isConnectedToNetwork()){
        name_arr.removeAll()
        phn_arr.removeAll()
        email_arr.removeAll()
        add_arr.removeAll()
        valuesearch = "NONE"
        callTestAlmo(url: testURL)
        }else{
            
            let alertController = UIAlertController(title: "No Internet!", message: "Please enable your connection.", preferredStyle: .alert)
            self.present(alertController, animated: true, completion:nil)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)
        }
    }
    
    func callCityAlmo( url : String){
        flag = 2
        city_arr.removeAll()
        city_arr.append("ALL")

        print("2222222")
        let para: Parameters = ["state": statevalue ?? "ap"]
        
        Alamofire.request(url, method: .post, parameters: para)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    let responseJSON = JSON(resultValue)
                    print("response\(responseJSON["data"])")
                    
                    for index in responseJSON["data"].array!{
                        self.city_arr.append(index["city"].string!)
                    }
                    DispatchQueue.main.async {
                        //  self.firstTableView.reloadData()
                        
                    }
                    print(self.city_arr)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    DispatchQueue.main.async {
                        //   self.firstTableView.reloadData()
                        
                    }
                    
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
                
                
        }
        
    }
    
    
    func callJobAlmo( url : String){
        flag = 2
        job_arr.removeAll()
        job_arr.append("ALL")
        print("2222222")
        let para: Parameters = ["job_cat": "APPDCL"]
        
        Alamofire.request(url, method: .post, parameters: para)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    let responseJSON = JSON(resultValue)
                    print("response\(responseJSON["data"])")
                    
                    for index in responseJSON["data"].array!{
                        self.job_arr.append(index["job"].string!)
                    }
                    DispatchQueue.main.async {
                        //  self.firstTableView.reloadData()
                    }
                    print(self.job_arr)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    DispatchQueue.main.async {
                        //   self.firstTableView.reloadData()
                        
                    }
                    
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
                
                
        }
        
        
    }

    
    
    

    

    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == pickerView1  {
            return state_arr.count
        } else if pickerView == pickerView2{
            return city_arr.count
        }
        else if pickerView == pickerView3{
            return job_arr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("")
        if pickerView == pickerView1  {
           statevalue = state_arr[row]
        } else if pickerView == pickerView2{
           cityvalue = city_arr[row]
        } else if pickerView == pickerView3{
            jobvalue = job_arr[row]
        }
        
   
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1  {
            return state_arr[row]
        } else if pickerView == pickerView2{
            return city_arr[row]
        }
        else if pickerView == pickerView3{
            return job_arr[row]
        }
        return "kk"

  
        
    }

    
    func donePickerS() -> Void {
        searchbutton.isEnabled = true
        citych.isEnabled = true
        citych.text = "select.."
            statech.text = statevalue
            self.view.endEditing(true)
            callCityAlmo(url: cityURL)
    }
    func canclePickerS() -> Void {
        self.view.endEditing(true)
    }
    
    func donePickerC() -> Void {
        citych.text = cityvalue
        self.view.endEditing(true)
    }
    func canclePickerC() -> Void {
        self.view.endEditing(true)
    }
    func donePickerJ() -> Void {
        jobch.text = jobvalue
        self.view.endEditing(true)
    }
    func canclePickerJ() -> Void {
        self.view.endEditing(true)
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }else{
            return name_arr.count

        }
    }
        // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell:DetailTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "detailID") as! DetailTableViewCell!
        if(searchActive){
            //cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.name.text = name_arr[indexPath.row]
            cell.address.text = add_arr[indexPath.row]
            cell.email.text =  email_arr[indexPath.row]
            cell.phone.text = phn_arr[indexPath.row]        }
        
        
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DetailTableViewCell
        valuename = cell.name.text
        valueemail = cell.email.text
        valueaddr = cell.address.text
        valuephno = cell.phone.text
        self.tableView.reloadData()
        performSegue(withIdentifier: "lastID", sender: cell)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lastID" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            let destinationVC = segue.destination as! DetailViewController
            
            destinationVC.name = valuename!
            destinationVC.emai = valueemail!
            destinationVC.addrr = valueaddr!
            destinationVC.phno = valuephno!
            
            
        }

            
        }
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

    
    }


