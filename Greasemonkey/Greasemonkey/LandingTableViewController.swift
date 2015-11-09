//
//  LandingTableViewController.swift
//  Greasemonkey
//
//  Created by david on 11/7/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import UIKit

protocol UserDetailViewControllerDelegate
{
    func carWasChosen(car: Car?)
}

class LandingTableViewController: UITableViewController, UserDetailViewControllerDelegate
{
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var myCarButton: UIBarButtonItem!
    var logoHasBeenAnimated = false
    
    var car = Car?()
    
//    let services = ["Oil Change", "Car Diagnostic"]
//    let subtitles = ["Have one of our trusted mechanics come to you and change your oil and replace your oil filter.", "Check Engine Light on? Car's making a funny noise? Have one of our mechanics come out and tell you what exactly is wrong."]
    
    let services = ["Find a mechanic"]
    let subtitles = ["We'll put you in contact with a trustworthy, reviewed mechanic in your area."]
    
    override func viewDidAppear(animated: Bool)
    {
        
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier("ShowLoginSegue", sender: self)
        }
        
        if logoHasBeenAnimated == false
        {
            animateLogo()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Car", style: .Plain, target: self, action: "myCarButtonItemClicked:")
        
        view.backgroundColor = UIColor(red:0.09, green:0.70, blue:1.00, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return services.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServiceCell", forIndexPath: indexPath) as! ServiceCell
        
        let service = services[indexPath.row]
        let subtitle = subtitles[indexPath.row]
        
        cell.serviceLabel.text = service
        cell.subtitleLabel.text = subtitle

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
//        let service = services[indexPath.row]
//        switch service
//        {
//        case "Find a mechanic":
//            performSegueWithIdentifier(", sender: <#T##AnyObject?#>)
//            
//        default: break
//        }
    }
    
    func myCarButtonItemClicked(sender: AnyObject?)
    {
        performSegueWithIdentifier("showCarDetailSegue", sender: sender)
    }
    
    func carWasChosen(car: Car?)
    {
        let model = car!.model
        let make = car!.make
        let year = car!.year
        
        
        
//        carLabel.text = ("Car: \(year) \(make) \(model)")
        navigationItem.rightBarButtonItem?.title = ("Car: \(year) \(make) \(model)")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showCarDetailSegue"
        {
            let carDetailVC = segue.destinationViewController as! UserDetailViewController
            carDetailVC.delegate = self
            if navigationItem.rightBarButtonItem?.title != "My Car"
            {
                carDetailVC.car = car
            }
        }
    }
    
    func animateLogo()
    {
//        print("animate logo")
//        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations:
//            {
//                var img = self.logoImage.frame
//                img.origin.x += 600
//                
//                self.logoImage.frame = img
//            }, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func showCarButton(sender: UIBarButtonItem)
    {
        
    }
    
    @IBAction func signoutButton(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("ShowLoginSegue", sender: self)
    }
    
    @IBAction func unwindToTipsTableViewController(unwindSegue: UIStoryboardSegue)
    {
        
    }

}
