//
//  SecondViewController.swift
//  Epower1
//
//  Created by Bharath Bandaru on 22/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var jobch: UITextField!
    @IBOutlet weak var statech: UITextField!
    @IBOutlet weak var citych: UITextField!
    var stateURL = "http://192.168.0.103/elec_dir/state.php"
    var cityURL = "http://192.168.0.103/elec_dir/state.php"
    var jonURL = "http://192.168.0.103/elec_dir/job.php"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
