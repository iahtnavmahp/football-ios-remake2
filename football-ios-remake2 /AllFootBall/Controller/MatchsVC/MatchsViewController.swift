//
//  MatchsViewController.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 08/08/2021.
//

import UIKit
import WebKit

class MatchsViewController: UIViewController, WKNavigationDelegate{
    
    var goalTeamA : String = ""
    var goalTeamB : String = ""
    var idMatch : String = ""
    var imgA : UIImage?
    var imgB : UIImage?
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var imgTA: UIImageView!
    @IBOutlet weak var imgTB: UIImageView!
    @IBOutlet weak var goalTA: UILabel!
    @IBOutlet weak var goalTB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: APIManager.Path.matchsk_domain + idMatch )!
        myWebView.load(URLRequest(url: url))
        if let imga = imgA {
            imgTA.image = imga
        }
        if let imgb = imgB {
            imgTB.image = imgb
        }
        
        goalTA.text = goalTeamA
        goalTB.text = goalTeamB
        
    }
    
    @IBAction func disMiss(_ sender: UIButton) {
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
    
    @IBAction func scrSetting(_ sender: UIButton) {
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
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
