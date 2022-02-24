//
//  ChartsViewController.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import UIKit
import RealmSwift

class ChartsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTourname.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "TournamentsCollectionViewCell", for: indexPath) as! TournamentsCollectionViewCell
        if(isColor == indexPath.row){
            cell.tourView.backgroundColor = UIColor.gray
        }else{
            cell.tourView.backgroundColor = UIColor.white
        }
        cell.lblNameTour?.text = arrTourname[indexPath.row].TournamentsName
        cell.configure()
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sz = arrTourname[indexPath.row]
        if(indexPath.row != 0){
            if(sz.isCall == false){
                loadTabRankTeam(param: sz.paramId,index: indexPath.row)
                sz.isCall = true
            }else{
                isTypes = sz.isTypes
                myTableView.reloadData()
            }
        }else{
            isTypes = 0
            
            myTableView.reloadData()
            
            
        }
        isColor = indexPath.row
        myCollectionView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrTabRankTeams.count > isTypes{
            return arrTabRankTeams[isTypes][isTable].teamRank.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Top3TableViewCell", for: indexPath) as! Top3TableViewCell
            if arrTabRankTeams.count > isTypes{
                let sz = arrTabRankTeams[isTypes][isTable].teamRank[indexPath.row]
                cell.teamName?.text = sz.team_name
                LoadImage.shared().downloadImage(url: sz.team_logo) { (image) in
                    if let image = image {
                        
                        cell.teamImage.image = image
                        
                    }
                }
                switch indexPath.row {
                case 0:
                    cell.bgrImage.image = UIImage.init(named: "Group 44")
                case 1:
                    cell.bgrImage.image = UIImage.init(named: "Group 45")
                case 2:
                    cell.bgrImage.image = UIImage.init(named: "Group 43")
                default:
                    print("loi tai cell")
                }
                
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutTop3TableViewCell", for: indexPath) as! OutTop3TableViewCell
            if arrTabRankTeams.count > isTypes{
                let sz = arrTabRankTeams[isTypes][isTable].teamRank[indexPath.row]
                cell.teamName?.text = sz.team_name
                cell.lblTop?.text = sz.rank
                LoadImage.shared().downloadImage(url: sz.team_logo) { (image) in
                    if let image = image {
                        
                        cell.teamImage.image = image
                        
                    }
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
            return 200
        }else{
            return 100
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("nhan tai \(arrTabRankTeams[isTypes][isTable].teamRank[indexPath.row].team_name)")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TeamInfoViewController") as? TeamInfoViewController else { return }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.idTeam = arrTabRankTeams[isTypes][isTable].teamRank[indexPath.row].team_id
        present(vc, animated: true)
        
    }
    let realm = try! Realm()
    var isColor:Int = 0
    var chartsModel = ChartsModel()
    var arrTabRankTeams : [[TabRankTeam]] = [[]]
    var isTypes = 0
    var isLeft = true
    var isRight = true
    var isTable = 0
    var arrTourname :[Tournaments] = [Tournaments(paramId: "4", TournamentsName: "Epl", isTypes: 0, isCall: true),Tournaments(paramId: "9", TournamentsName: "Seria", isTypes: 1, isCall: false),Tournaments(paramId: "5", TournamentsName: "Bundesliga", isTypes: 2, isCall: false ),Tournaments(paramId: "3", TournamentsName: "Laliga", isTypes: 3, isCall: false ),Tournaments(paramId: "12", TournamentsName: "League 1", isTypes: 4, isCall: false),]
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var textFieldSeason: UITextField!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    let pikerview = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: "Top3TableViewCell", bundle: nil)
        myTableView.register(nib1, forCellReuseIdentifier: "Top3TableViewCell")
        let nib2 = UINib(nibName: "OutTop3TableViewCell", bundle: nil)
        myTableView.register(nib2, forCellReuseIdentifier: "OutTop3TableViewCell")
        let nib3 = UINib(nibName: "TournamentsCollectionViewCell", bundle: nil)
        myCollectionView.register(nib3, forCellWithReuseIdentifier: "TournamentsCollectionViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        arrTabRankTeams.removeAll()
        // Do any additional setup after loading the view.
        loadTabRankTeam(param: "4",index: 0)
        heightScrollView.constant = CGFloat(140*20)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 30)
        
        self.myCollectionView.collectionViewLayout = layout
        pikerview.delegate = self
        pikerview.dataSource = self
        self.textFieldSeason.inputView = pikerview
        self.dismissAndClosePickerView()
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
    @IBAction func btnDismiss(_ sender: UIButton) {
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
    @IBAction func scrHome(_ sender: UIButton) {
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func loadTabRankTeam(param:String,index:Int){
        
        chartsModel.loadAPITabRankTeams(param:param){ (done,msg)  in
            if done {
                print("count: \(self.chartsModel.tabrankteams.count)")
                self.arrTabRankTeams.append(self.chartsModel.tabrankteams)
                print("arr \(self.arrTabRankTeams.count)")
                self.arrTourname[index].isTypes = self.arrTabRankTeams.count - 1
                self.isTypes = self.arrTabRankTeams.count - 1
               
                self.myTableView.reloadData()
                self.pikerview.reloadAllComponents()
            } else {
                print("API ERROR: \(msg)")
            }
            
        }
        
        
    }
    
    
    //---------------pickerview
    
    
    
    func dismissAndClosePickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.textFieldSeason.inputAccessoryView = toolBar
    }
    
    @objc func dismissAction(){
        self.view.endEditing(true)
        self.myTableView.reloadData()
    }
}
extension ChartsViewController: UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if arrTabRankTeams.count > isTypes{
            return arrTabRankTeams[isTypes].count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if arrTabRankTeams.count > isTypes{
            return arrTabRankTeams[isTypes][row].season_name
        }else{
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if arrTabRankTeams.count > isTypes{
            self.textFieldSeason?.text = self.arrTabRankTeams[isTypes][row].season_name
            self.isTable = row
        }
    }
    
}
