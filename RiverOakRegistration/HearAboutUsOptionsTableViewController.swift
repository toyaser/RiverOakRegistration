//
//  HearAboutUsOptionsTableViewController.swift
//  RiverOakRegistration
//
//  Created by Yaser Abou Elenein on 21/2/18.
//  Copyright © 2018 Yaser Abouelenein. All rights reserved.
//

import UIKit

class HearAboutUsOptionsTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var FacebookTableViewCell: UITableViewCell!
    @IBOutlet weak var RadioTableViewCell: UITableViewCell!
    @IBOutlet weak var TVTableViewCell: UITableViewCell!
    @IBOutlet weak var NewspaperTableViewCell: UITableViewCell!
    @IBOutlet weak var SignsTableViewCell: UITableViewCell!
    @IBOutlet weak var WordOfMouthTableViewCell: UITableViewCell!
    @IBOutlet weak var OtherTableViewCell: UITableViewCell!
    @IBOutlet weak var OtherSpecifyTextField: UITextField!
    var selectedOptionsFromHearAboutUsOptions = Array(repeating: false, count: 7)
    var selectedOptionOtherText = ""
    var numberOfSelectedRows = 0
    var textToDisplayOnBack = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHearAboutUsOptions()
        navigationController?.delegate = self

//        FacebookTableViewCell.accessoryType = .checkmark
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setupHearAboutUsOptions() {
        if selectedOptionsFromHearAboutUsOptions[0] {
            FacebookTableViewCell.accessoryType = .checkmark
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
        if selectedOptionsFromHearAboutUsOptions[1] {
            RadioTableViewCell.accessoryType = .checkmark
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
        if selectedOptionsFromHearAboutUsOptions[2] {
            TVTableViewCell.accessoryType = .checkmark
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
        if selectedOptionsFromHearAboutUsOptions[3] {
            NewspaperTableViewCell.accessoryType = .checkmark
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
        if selectedOptionsFromHearAboutUsOptions[4] {
            SignsTableViewCell.accessoryType = .checkmark
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
        if selectedOptionsFromHearAboutUsOptions[5] {
            WordOfMouthTableViewCell.accessoryType = .checkmark
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
        if selectedOptionsFromHearAboutUsOptions[6] {
            OtherTableViewCell.accessoryType = .checkmark
            OtherSpecifyTextField.isHidden = false
            OtherSpecifyTextField.text = selectedOptionOtherText
            numberOfSelectedRows = numberOfSelectedRows + 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cell.isSelected = false
                numberOfSelectedRows = numberOfSelectedRows - 1
                selectedOptionsFromHearAboutUsOptions[indexPath.row] = false
//                checked[indexPath.row] = false
            } else {
                cell.accessoryType = .checkmark
                cell.isSelected = true
                numberOfSelectedRows = numberOfSelectedRows + 1
                 selectedOptionsFromHearAboutUsOptions[indexPath.row] = true
//                checked[indexPath.row] = true

            }
            
            
            if cell.reuseIdentifier == "HearAbouUsOtherCell" {
                if cell.accessoryType == .checkmark {
                    OtherSpecifyTextField.isHidden = false
                    OtherSpecifyTextField.isEnabled = true
                    self.OtherSpecifyTextField.becomeFirstResponder()
                } else {
                    OtherSpecifyTextField.isHidden = true
                    OtherSpecifyTextField.text = ""
                    OtherSpecifyTextField.isEnabled = false
                }
            }
            
            print(numberOfSelectedRows)
           
        }
    }
    
//    https://stackoverflow.com/questions/34955987/pass-data-through-navigation-back-button
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let vc = (viewController as? FormTableViewController) {
            vc.selectedOptionsFromHearAboutUsOptions = self.selectedOptionsFromHearAboutUsOptions
            vc.selectedOptionOtherText = self.OtherSpecifyTextField.text!
            setupTextToReturn()
            vc.howDidYouHearAboutUsCell.detailTextLabel?.text = textToDisplayOnBack
            vc.enableIAgree()
        }
    }
    
    func setupTextToReturn() {
        if numberOfSelectedRows == 0 {
            textToDisplayOnBack = "Please Specify"
        } else if numberOfSelectedRows == 1 {
            if let i = selectedOptionsFromHearAboutUsOptions.index(of: true) {
                let index = selectedOptionsFromHearAboutUsOptions.startIndex.distance(to: i)
                let indexPath =  IndexPath(row: index, section: 0)
                if let cell = tableView.cellForRow(at: indexPath) {
                    if index != 6 {
                        textToDisplayOnBack = (cell.textLabel?.text)!
                        
                    } else {
                        textToDisplayOnBack = "Other"
                    }
                }
                
            }
        } else if numberOfSelectedRows > 1 {
            textToDisplayOnBack = "Multiple"
        } else {
            textToDisplayOnBack = "Please Specify"
        }
    }

//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "backFromHearAboutUsOptions" {
//            let destinationVC = segue.destination as! FormTableViewController
//
//            destinationVC.selectedOptionFromHearAboutUsOptions = "testy"
//        }
//    }

}
