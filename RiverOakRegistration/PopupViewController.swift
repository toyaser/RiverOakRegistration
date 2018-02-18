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
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popupView.layer.cornerRadius = 5;
        self.popupView.layer.shadowOpacity = 0.8;
        self.popupView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        setupAddTargetIsNotEmptyTextFields()
        // Do any additional setup after loading the view.
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        doneBarButton.isEnabled = false
        
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 5
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        nameUserTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        postalCodeTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
//        emailUserTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                     for: .editingChanged)
//        passwordUserTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                        for: .editingChanged)
//        confimPasswordUserTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
//                                              for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if (nameUserTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            (postalCodeTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            // string contains non-whitespace characters
            return
        }
        guard
            let name = nameUserTextField.text, !name.isEmpty,
            let postalCode = postalCodeTextField.text, !postalCode.isEmpty
        else {
                doneBarButton.isEnabled = false
                return
        }
        doneBarButton.isEnabled = true
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
