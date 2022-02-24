//
//  HomeViewController.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 02/07/2021.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.footballs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let sz = viewmodel.footballs.count - 1 - indexPath.row
        let items = viewmodel.footballs[sz]
        var textGoalA: String = ""
        for item in items.eventGoal {
            if item.teamAEvents1.count > 1 {
                for (index,i) in item.teamAEvents1.enumerated() {
                    if index > 0 {
                        textGoalA = textGoalA + " \(i.person) \(item.minute)'\n"
                    }
                }
            }
            
        }
        var textGoalB: String = ""
        for item in items.eventGoal {
            if item.teamBEvents1.count > 1 {
                for (index,i) in item.teamBEvents1.enumerated() {
                    if index > 0 {
                        textGoalB = textGoalB + " \(i.person) \(item.minute)'\n"
                    }
                }
            }
        }
        
        cell.lblGoalTimeTeam1?.text = textGoalA
        cell.lblGoalTimeTeam2?.text = textGoalB
        cell.lblDate?.text = items.date_utc
        let str = items.time_utc
        let index = str.index(str.startIndex, offsetBy: 5)
        let timeSubStr = str[..<index]
        cell.lblTime?.text = String(timeSubStr)
        cell.lblGoalTeam1?.text = items.fs_A
        cell.lblGoalTeam2?.text = items.fs_B
        
        if Date() < compareDate(date: items.start_play) ?? Date() {
            cell.btn_Notification.isHidden = false
            if NcsId.isId(id: items.match_id){
                let image = UIImage(named: "notification_off") as UIImage?
                cell.btn_Notification.setBackgroundImage(image, for: .normal)
            }else{
                let image = UIImage(named: "notification_on") as UIImage?
                cell.btn_Notification.setBackgroundImage(image, for: .normal)
            }
        }else{
            cell.btn_Notification.isHidden = true
        }
        cell.btn_Notification.tag = indexPath.row
        cell.btn_Notification.addTarget(self, action: #selector(addNotification), for: .touchUpInside)
        cell.lblTeam1?.text = items.team_A_name
        cell.lblTeam2?.text = items.team_B_name
        if items.team_A_Image != nil {
            cell.imgTeam1.image = items.team_A_Image
        } else {
            cell.imgTeam1.image = nil
            
            //downloader
            LoadImage.shared().downloadImage(url: items.team_A_logo) { (image) in
                if let image = image {
                    cell.imgTeam1.image = image
                    items.team_A_Image = image
                } else {
                    cell.imgTeam1.image = nil
                }
            }
        }
        if items.team_B_Image != nil {
            cell.imgTeam2.image = items.team_B_Image
        } else {
            cell.imgTeam2.image = nil
            
            //downloader
            LoadImage.shared().downloadImage(url: items.team_B_logo) { (image) in
                if let image = image {
                    cell.imgTeam2.image = image
                    items.team_B_Image = image
                } else {
                    cell.imgTeam2.image = nil
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height)/5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sz = viewmodel.footballs.count - 1 - indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MatchsViewController") as? MatchsViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.goalTeamA = viewmodel.footballs[sz].fs_A
        vc.goalTeamB = viewmodel.footballs[sz].fs_B
        vc.idMatch = viewmodel.footballs[sz].match_id
        if let imga = viewmodel.footballs[sz].team_A_Image{
            vc.imgA = imga
        }
        if let imgb = viewmodel.footballs[sz].team_B_Image{
            vc.imgB = imgb
        }
        present(vc, animated: true)
        
    }
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBAction func scrCharts(_ sender: UIButton) {
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ChartsViewController") as? ChartsViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    @IBAction func scrFav(_ sender: UIButton) {
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
        
        let list = realm.objects(TeamId.self).toArray(ofType: TeamId.self)
        
        if list.count == 0 {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "CheckFavViewController") as? CheckFavViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }else{
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "SubcribleViewController") as? SubcribleViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
    @IBAction func btnSetting(_ sender: UIButton) {
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
    let realm = try! Realm()
    let manager = LocalNotificationManager()
    @IBOutlet weak var myTableView: UITableView!
    @IBAction func btnRefresh(_ sender: Any) {
        loadAPI()
    }
    @IBOutlet weak var viewTabBar: UIView!
    
    var viewmodel = HomeViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        loadAPI()
        
        // Do any additional setup after loading the view.
    }
    func compareDate(date:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: date)
    }
    
    func loadAPI(){
        viewmodel.loadAPI(){ (footballs,done,pro)  in
            if done {
                self.heightScrollView.constant = CGFloat(300+(Int((self.view.frame.height))/5)*self.viewmodel.footballs.count)
                self.viewmodel.footballs = footballs
                self.myTableView.reloadData()
            } else {
                print("API ERROR: \(pro)")
            }
        }
    }
    @objc func addNotification(sender:UIButton){
        
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        let sz = self.viewmodel.footballs[indexpath1.row]
        if self.viewmodel.footballs.count > indexpath1.row{
            let isid:Bool = NcsId.isId(id: sz.match_id)
            if isid {
                NcsId.saveNotification(nscId: sz.match_id)
                let notifTime: Date = compareDate(date: sz.start_play) ?? Date()
                let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour, .minute,.second], from: notifTime)
                print("dateComp\(dateComponents)")
                
                self.manager.notifications.append(Notification(id: sz.match_id, title: "\(sz.team_A_name) vs \(sz.team_B_name)", datetime: dateComponents))
                self.manager.schedule()
                self.myTableView.reloadData()
            }else{
                NcsId.deleteNotification(nscId: sz.match_id)
                self.manager.removePending(id: sz.match_id)
                self.myTableView.reloadData()
            }
        }
        
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
