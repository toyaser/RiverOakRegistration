//
//  PopupViewController.swift
//  RiverOakRegistration
//
//  Created by Yaser Abou Elenein on 18/2/18.
//  Copyright © 2018 Yaser Abouelenein. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popupView.layer.cornerRadius = 5;
        self.popupView.layer.shadowOpacity = 0.8;
        self.popupView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
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

    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
