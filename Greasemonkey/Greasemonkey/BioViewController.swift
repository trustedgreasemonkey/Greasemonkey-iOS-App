//
//  BioViewController.swift
//  Greasemonkey
//
//  Created by david on 11/8/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import UIKit

class BioViewController: UIViewController, UITextViewDelegate
{

    var delegate: BioViewControllerDelegate?
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
        
        self.navigationController?.navigationBar.translucent = false
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
