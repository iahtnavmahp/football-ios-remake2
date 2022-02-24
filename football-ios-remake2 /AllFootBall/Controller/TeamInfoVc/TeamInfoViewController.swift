//
//  TeamInfoViewController.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 24/07/2021.
//

import UIKit
import RealmSwift
class TeamInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch isTypes {
        case 1:
            return arrSectionInfo.count
        case 2:
            return teamInfoModel.teamplayers.count
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isTypes {
        case 0:
            return teamInfoModel.teammatchs.count
        case 1 :
            switch section {
            case 0:
                return 2
            case 1:
                return 2
            case 2:
                if teamInfoModel.searchinfos.count > 0{
                    return teamInfoModel.searchinfos[0].trophy_info.count
                }else{
                    return 0
                }
                
            default:
                return 1
            }
        case 2 :
            let section = teamInfoModel.teamplayers[section]
            if section.isOpened {
                return section.data.count
            }else{
                return 1
            }
        default:
            return teamInfoModel.teammatchs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch isTypes {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMatchTableViewCell", for: indexPath) as! TeamMatchTableViewCell
            
            let sz = teamInfoModel.teammatchs[indexPath.row]
            
            if Date() < compareDate(date: sz.start_play) ?? Date() {
                cell.btn_Notification.isHidden = false
                let puppies = realm.objects(NcsId.self).filter("nscId == '\(String(sz.match_id))'")
                if puppies.count == 0 {
                    let image = UIImage(named: "notification_off") as UIImage?
                    cell.btn_Notification.setBackgroundImage(image, for: .normal)
                }else{
                    let image = UIImage(named: "notification_on") as UIImage?
                    cell.btn_Notification.setBackgroundImage(image, for: .normal)
                }
            }else{
                cell.btn_Notification.isHidden = true
            }
            let result = sz.start_play.split(separator: " ")
            cell.lblDate?.text = String(result[0])
            cell.btn_Notification.tag = indexPath.row
            cell.btn_Notification.addTarget(self, action: #selector(addNotification), for: .touchUpInside)
            cell.lblTime?.text = String(result[1])
            cell.lblNameTeam1?.text = sz.team_A_name
            cell.lblNameTeam2?.text = sz.team_B_name
            cell.lblGoalTeam1?.text = sz.fs_A
            cell.lblGoalTeam2?.text = sz.fs_B
            LoadImage.shared().downloadImage(url: sz.team_A_logo) { (image) in
                if let image = image {
                    
                    cell.imgTeam1.image = image
                    sz.team_A_logo_img = image
                    
                }
            }
            LoadImage.shared().downloadImage(url: sz.team_B_logo) { (image) in
                if let image = image {
                    
                    cell.imgTeam2.image = image
                    sz.team_B_logo_img = image
                }
            }
            return cell
        case 1 :
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SectionInfoTableViewCell", for: indexPath) as! SectionInfoTableViewCell
                
                cell.lblSectionName?.text = arrSectionInfo[indexPath.section]
                return cell
            }else if indexPath.row == 1 && (indexPath.section == 0 || indexPath.section == 1){
                let cell = tableView.dequeueReusableCell(withIdentifier: "BaseInfoTableViewCell", for: indexPath) as! BaseInfoTableViewCell
                if indexPath.section == 0 {
                    cell.lblFirst?.text = "Founded in: " + teamInfoModel.searchinfos[0].base_info.founded
                    cell.lblMid?.text = "Location: " + teamInfoModel.searchinfos[0].base_info.venue_name
                    cell.lblLast?.text = "Country: " + teamInfoModel.searchinfos[0].base_info.country
                }else{
                    cell.lblFirst?.text = "Tel: " + teamInfoModel.searchinfos[0].base_info.telephone
                    cell.lblMid?.text = "Email: " + teamInfoModel.searchinfos[0].base_info.email
                    cell.lblLast?.text = "Address: " + teamInfoModel.searchinfos[0].base_info.address
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrophieTableViewCell", for: indexPath) as! TrophieTableViewCell
                let sz = teamInfoModel.searchinfos[0].trophy_info[indexPath.row]
                cell.lblCompetition?.text = sz.competition_name + " x" + String(sz.lists.count - 1)
                
                
                cell.configure(with: sz.lists)
                return cell
            }
            
        case 2 :
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SectionPlayerTableViewCell", for: indexPath) as! SectionPlayerTableViewCell
                let sz = self.teamInfoModel.teamplayers[indexPath.section]
                if sz.isOpened{
                    cell.imgType.image = UIImage.init(named: "Group 31")
                }else{
                    cell.imgType.image = UIImage.init(named: "Group 36")
                }
                cell.lblNameSection?.text = sz.title
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TeamPlayerTableViewCell", for: indexPath) as! TeamPlayerTableViewCell
                
                let sz = self.teamInfoModel.teamplayers[indexPath.section].data[indexPath.row]
                cell.lblNamePlayer?.text = sz.person_name
                LoadImage.shared().downloadImage(url: sz.person_logo) { (image) in
                    if let image = image {
                        
                        cell.imgPlayer.image = image
                        
                    }
                }
                
                
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMatchTableViewCell", for: indexPath) as! TeamMatchTableViewCell
            
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch isTypes {
        case 0:
            return (view.frame.height)/5
        case 1:
            if indexPath.row == 0 {
                return 40
            }else if indexPath.row == 1 && (indexPath.section == 0 || indexPath.section == 1) {
                return 100
            }else{
                return (view.frame.height)/5
            }
        case 2:
            if indexPath.row == 0 {
                return 70
            }else{
                return 120
            }
        default:
            return (view.frame.height)/5
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch isTypes {
        case 0:
            let sz = teamInfoModel.teammatchs[indexPath.row]
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MatchsViewController") as? MatchsViewController else { return }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            vc.goalTeamA = sz.fs_A
            vc.goalTeamB = sz.fs_B
            vc.idMatch = sz.match_id
            if let imga = sz.team_A_logo_img{
                vc.imgA = imga
            }
            if let imgb = sz.team_B_logo_img{
                vc.imgB = imgb
            }
            present(vc, animated: true)
        case 1:
            print("is 1")
        case 2:
            tableView.deselectRow(at: indexPath, animated: true)
            teamInfoModel.teamplayers[indexPath.section].isOpened = !teamInfoModel.teamplayers[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
            print(indexPath)
        default:
            print("loi tai did selectRowat")
        }
    }
    var countPlayer:Int = 0
    let realm = try! Realm()
    let manager = LocalNotificationManager()
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnMid: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var imgTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!
    var teamInfoModel = TeamInfoViewModel()
    var arrSectionInfo = ["Trophies","Info","Contact Information"]
    var isTypes = 0
    var isPlayer : Bool = false
    var isInfo : Bool = false
    var isMatch : Bool = false
    var idTeam:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: "TeamMatchTableViewCell", bundle: nil)
        myTableView.register(nib1, forCellReuseIdentifier: "TeamMatchTableViewCell")
        let nib2 = UINib(nibName: "TeamPlayerTableViewCell", bundle: nil)
        myTableView.register(nib2, forCellReuseIdentifier: "TeamPlayerTableViewCell")
        let nib3 = UINib(nibName: "SectionPlayerTableViewCell", bundle: nil)
        myTableView.register(nib3, forCellReuseIdentifier: "SectionPlayerTableViewCell")
        let nib4 = UINib(nibName: "SectionInfoTableViewCell", bundle: nil)
        myTableView.register(nib4, forCellReuseIdentifier: "SectionInfoTableViewCell")
        let nib5 = UINib(nibName: "BaseInfoTableViewCell", bundle: nil)
        myTableView.register(nib5, forCellReuseIdentifier: "BaseInfoTableViewCell")
        let nib6 = UINib(nibName: "TrophieTableViewCell", bundle: nil)
        myTableView.register(nib6, forCellReuseIdentifier: "TrophieTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        loadTeamMatchs(id: idTeam)
        loadTeamPlayer(id: idTeam)
        loadSearchInfo(id: idTeam)
        
    }
    private func saveNotification(nscId: String) {
        
        let data = NcsId()
        
        data.nscId = nscId
        
        try! realm.write {
            realm.add(data, update: .modified)
            print("them match id thanh cong")
        }
        
    }
    private func deleteNotification(nscId: String) {
        let dataFilters = realm.objects(NcsId.self).filter("nscId = %@", nscId)
        try! realm.write {
            realm.delete(dataFilters)
            print("xoa match id thanh cong")
        }
    }
    
    @IBAction func clickBtnMid(_ sender: UIButton) {
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
    }
    
    @IBAction func clickBtnRight(_ sender: UIButton) {
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
        switch isTypes  {
        case 0:
            self.btnMid.setTitle("Player", for: .normal)
            self.btnRight.setTitle("Match", for: .normal)
            isTypes = 2
            if isPlayer {
                self.heightScrollView.constant = CGFloat(300+110*countPlayer)
            }
            self.myTableView.reloadData()
            
        case 1 :
            self.btnMid.setTitle("Player", for: .normal)
            self.btnLeft.setTitle("Info", for: .normal)
            self.btnRight.setTitle("Match", for: .normal)
            isTypes = 2
            if isPlayer {
                self.heightScrollView.constant = CGFloat(300+110*countPlayer)
            }
            self.myTableView.reloadData()
            
        case 2 :
            self.btnMid.setTitle("Match", for: .normal)
            self.btnRight.setTitle("Player", for: .normal)
            isTypes = 0
            if isMatch {
                self.heightScrollView.constant = CGFloat(500+(Int((self.view.frame.height))/5)*self.teamInfoModel.teammatchs.count)
            }
            self.myTableView.reloadData()
            
        default:
            print("loi Click btnRight")
        }
    }
    @IBAction func clickBtnLeft(_ sender: UIButton) {
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
        switch isTypes {
        case 0:
            self.btnMid.setTitle("Info", for: .normal)
            self.btnLeft.setTitle("Match", for: .normal)
            isTypes = 1
            if isInfo {
                self.heightScrollView.constant = CGFloat(900+(Int((self.view.frame.height))/5)*self.teamInfoModel.searchinfos[0].trophy_info.count)
            }
            self.myTableView.reloadData()
            
        case 1:
            self.btnMid.setTitle("Match", for: .normal)
            self.btnLeft.setTitle("Info", for: .normal)
            if isMatch {
                self.heightScrollView.constant = CGFloat(500+(Int((self.view.frame.height))/5)*self.teamInfoModel.teammatchs.count)
            }
            isTypes = 0
            self.myTableView.reloadData()
            
        case 2:
            self.btnMid.setTitle("Info", for: .normal)
            self.btnLeft.setTitle("Match", for: .normal)
            self.btnRight.setTitle("Player", for: .normal)
            if isInfo {
                self.heightScrollView.constant = CGFloat(900+(Int((self.view.frame.height))/5)*self.teamInfoModel.searchinfos[0].trophy_info.count)
            }
            isTypes = 1
            self.myTableView.reloadData()
            
        default:
            print("loi tai Click btnLeft")
        }
        
    }
    @IBAction func scrHomeVC(_ sender: UIButton) {
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
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
    @IBAction func ActionDismiss(_ sender: UIButton) {
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func addNotification(sender:UIButton){
        
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        if self.teamInfoModel.teammatchs.count > indexpath1.row{
            let sz = self.teamInfoModel.teammatchs[indexpath1.row]
            let puppies = realm.objects(NcsId.self).filter("nscId == '\(String(sz.match_id))'")
            if puppies.count == 0 {
                saveNotification(nscId: String(sz.match_id))
                let notifTime: Date = compareDate(date: sz.start_play) ?? Date()
                let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour, .minute,.second], from: notifTime)
                print("dateComp\(dateComponents)")
                
                self.manager.notifications.append(Notification(id: sz.match_id, title: "\(sz.team_A_name) vs \(sz.team_B_name)", datetime: dateComponents))
                self.manager.schedule()
                self.myTableView.reloadData()
            }else{
                deleteNotification(nscId: String(sz.match_id))
                self.manager.removePending(id: sz.match_id)
                self.myTableView.reloadData()
            }
            
        }
    }
    func compareDate(date:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: date)
    }
    func loadTeamMatchs(id:String){
        teamInfoModel.loadAPITeamMatchs(id:id){ (done,msg)  in
            if done {
                self.isMatch = true
                self.heightScrollView.constant = CGFloat(500+(Int((self.view.frame.height))/5)*self.teamInfoModel.teammatchs.count)
                self.myTableView.reloadData()
            } else {
                print("API ERROR: \(msg)")
            }
            
        }
    }
    func loadTeamPlayer(id:String){
        teamInfoModel.loadAPITeamPlayer(id:id){ (done,msg)  in
            if done {
                self.isPlayer = true
                print("teamplayer \(self.teamInfoModel.teamplayers)")
                self.countPlayer  = self.teamInfoModel.teamplayers.count
                for ss in self.teamInfoModel.teamplayers {
                    for _ in ss.data{
                        self.countPlayer += 1
                    }
                }
                self.myTableView.reloadData()
            } else {
                print("API ERROR: \(msg)")
            }
            
        }
    }
    func loadSearchInfo(id:String){
        teamInfoModel.loadAPISearchInfo(id:id){ (done,msg)  in
            if done {
                self.isInfo = true
                print("info \(self.teamInfoModel.searchinfos)")
                for item in self.teamInfoModel.searchinfos {
                    LoadImage.shared().downloadImage(url: item.base_info.team_img) { (image) in
                        if let image = image {
                            
                            self.imgTeam.image =  image
                            
                        }
                    }
                    self.nameTeam?.text = item.base_info.team_en_name
                }
                self.myTableView.reloadData()
            } else {
                print("API ERROR: \(msg)")
            }
            
        }
    }
    
    
}
