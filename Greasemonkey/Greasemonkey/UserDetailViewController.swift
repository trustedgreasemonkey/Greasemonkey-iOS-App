//
//  UserDetailViewController.swift
//  Greasemonkey
//
//  Created by david on 11/7/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import UIKit


protocol MakeModelYearTableViewControllerDelegate
{
    func didSelectRow(rowText: String, cc: String)
}

class UserDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate, MakeModelYearTableViewControllerDelegate
{
    @IBOutlet weak var makeLabel: UITextField!
    @IBOutlet weak var modelLabel: UITextField!
    @IBOutlet weak var yearLabel: UITextField!
    
    let make = [
        "Acura",
        "Audi",
        "BMW",
        "Buick",
        "Infiniti"
    ]
    let year = [
        "1990 - 1996",
        "1998-2001",
        "2002 - 2005",
        "2006 - 2015",        
    ]
    let model = [
        "G35",
        "G37",
        "Q50",
        "Q60"
    ]
    
    var user = User?()
    var car = Car?()
    
    var chosenMake = ""
    var chosenYear = ""
    var chosenModel = ""
    
    var delegate: UserDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if car != nil
        {
            makeLabel.text = car?.make
            modelLabel.text = car?.model
            yearLabel.text = car?.year
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let popVC = segue.destinationViewController as! MakeModelYearTableViewController
        popVC.popoverPresentationController?.delegate = self
        popVC.delegate = self

        if segue.identifier == "makeDetailSegue"
        {
            popVC.lists = self.make
            popVC.cc = "make"
        }
        if segue.identifier == "yearDetailSegue"
        {
            popVC.lists = self.year
            popVC.cc = "year"
        }
        if segue.identifier == "modelDetailSegue"
        {
            popVC.lists = self.model
            popVC.cc = "model"
        }
        
        let contentHeight = CGFloat(popVC.lists.count * 44)
        popVC.preferredContentSize = CGSizeMake(80, contentHeight)
        if popVC.cc == "year"
        {
            popVC.preferredContentSize = CGSizeMake(160, contentHeight)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
    
    func didSelectRow(rowText: String, cc: String)
    {
        switch cc
        {
        case "make":
            makeLabel.text = rowText
        case "year":
            yearLabel.text = rowText
        case "model":
            modelLabel.text = rowText
        default: break
        }
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        if makeLabel.text != "" && modelLabel.text != "" && yearLabel.text != ""
        {
            car = Car(make: makeLabel.text!, model: modelLabel.text!, year: yearLabel.text!)
            print(car)
            delegate?.carWasChosen(car)
        }
    }
}
