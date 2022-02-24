//
//  SettingViewController.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 27/07/2021.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrSetting.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.imgSetting.image = UIImage.init(named: "setting" + String(indexPath.row))
        cell.lblSetting?.text = arrSetting[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        tableView.cellForRow(at: indexPath)!.transform = CGAffineTransform.identity
                       },
                       completion: { Void in()  }
        )
        switch indexPath.row {
        case 0:
            
            // Setting description
            let firstActivityItem = "Description you want.."
            
            // Setting url
            let secondActivityItem : NSURL = NSURL(string: "http://google.com/")!
            
            // If you want to use an image
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem,image ?? #imageLiteral(resourceName: "app-logo")], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            //                activityViewController.popoverPresentationController?.sourceView = (tableView.cellForRow(at: indexPath) as! UIButton)
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
            if #available(iOS 13.0, *) {
                activityViewController.activityItemsConfiguration = [
                    UIActivity.ActivityType.message
                ] as? UIActivityItemsConfigurationReading
            } else {
                // Fallback on earlier versions
            }
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.print,
            ]
            
            if #available(iOS 13.0, *) {
                activityViewController.isModalInPresentation = true
            } else {
                // Fallback on earlier versions
            }
            self.present(activityViewController, animated: true, completion: nil)
        case 2:
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "PopupExitViewController") as? PopupExitViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        default:
            print("loi tai didSeclect")
        }
    }
    
    var arrSetting = ["Share","Feedback","Exit"]
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "SettingTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TouchDismiss(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
                       },
                       completion: { Void in()  }
        )
        dismiss(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
