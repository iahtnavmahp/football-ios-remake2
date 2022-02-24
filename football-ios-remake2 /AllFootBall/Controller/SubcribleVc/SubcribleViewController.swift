//
//  SubcribleViewController.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 21/07/2021.
//

import UIKit
import RealmSwift
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
class SubcribleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch isCollectionView {
        case 0:
            return subcribleView.searchsamples.count + 2
        case 1 :
            return subcribleView.searchsuggests.count
        case 2 :
            
            return subcribleView.searchnormals.count
        case 3 :
            
            return subcribleView.searchsamples.count
        default:
            return subcribleView.searchsamples.count + 2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isCollectionView == 1{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchStrCollectionViewCell", for: indexPath) as! SearchStrCollectionViewCell
            
            cell.lblSearchStr?.text = self.subcribleView.searchsuggests[indexPath.row].query
            
            return cell
            
        }else{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "SubcribleCollectionViewCell", for: indexPath) as! SubcribleCollectionViewCell
            
            switch isCollectionView {
            case 0:
                cell.imgCheck.image = nil
                cell.btnDelete.isHidden = true
                if indexPath.row == 0 {
                    cell.imgTeam.image = UIImage.init(named: "bx_bxs-calendar-edit")
                    cell.lblTeamName?.text = "Edit"
                    
                }else if indexPath.row == 1{
                    cell.imgTeam.image = UIImage.init(named: "akar-icons_circle-plus-fill")
                    cell.lblTeamName?.text = "Add"
                }else{
                    
                    let b = self.subcribleView.searchsamples[indexPath.row - 2]
                    cell.lblTeamName?.text = b.team_en_name
                    
                    //downloader
                    LoadImage.shared().downloadImage(url: b.team_img) { (image) in
                        if let image = image {
                            cell.imgTeam.image = image
                            
                        }
                    }
                    
                }
                
            case 2 :
                cell.btnDelete.isHidden = true
                let item = self.subcribleView.searchnormals[indexPath.row]
                cell.imgTeam.isHidden = false
                if item.hot == -1 {
                    cell.imgCheck.image = UIImage.init(named: "bi_check-lg")
                }else{
                    cell.imgCheck.image = nil
                }
                
                let str1 = item.name.replacingOccurrences(of:"<font color=#16b13a>", with: "")
                let str2 = str1.replacingOccurrences(of: "</font>", with: "")
                cell.lblTeamName?.text = str2
                
                LoadImage.shared().downloadImage(url: item.logo) { (image) in
                    if let image = image {
                        
                        cell.imgTeam.image = image
                        
                    }
                }
            case 3 :
                cell.btnDelete.isHidden = false
                cell.imgCheck.image = nil
                
                if self.subcribleView.searchsamples.count  > indexPath.row{
                    
                    
                    let b = self.subcribleView.searchsamples[indexPath.row]
                    
                    cell.lblTeamName?.text = b.team_en_name
                    
                    cell.imgTeam.image = nil
                    
                    //downloader
                    LoadImage.shared().downloadImage(url: b.team_img) { (image) in
                        if let image = image {
                            cell.imgTeam.image = image
                            
                        } else {
                            cell.imgTeam.image = nil
                        }
                    }
                    cell.btnDelete.tag = indexPath.row
                    cell.btnDelete.addTarget(self, action: #selector(deletetoFavotire), for: .touchUpInside)
                }
                
            default:
                print("loi tai cell")
            }
            
            return cell
        }
        
    }
    @objc func deletetoFavotire(sender:UIButton){
        
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        if self.subcribleView.searchsamples.count > indexpath1.row{
            let del = self.subcribleView.searchsamples[indexpath1.row].team_id
            deleteData(id: del)
            self.subcribleView.searchsamples.remove(at: indexpath1.row)
            
            myCollectionView.deleteItems(at: [indexpath1])
            myCollectionView.reloadData()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch isCollectionView {
        case 0:
            let a =  indexPath.row
            if a == 0 {
                print("ban vua click edit")
                isCollectionView = 3
                self.btnCheck.isHidden = false
                self.btnCheck.setTitle("Back", for: .normal)
                self.myCollectionView.reloadData()
            }else if a == 1{
                print("ban vua click add")
                self.isCollectionView = 1
                self.myCollectionView.reloadData()
                
            }else{
                
                guard let vc = storyboard?.instantiateViewController(withIdentifier: "TeamInfoViewController") as? TeamInfoViewController else { return }
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                vc.idTeam = self.subcribleView.searchsamples[a - 2].team_id
                present(vc, animated: true)
                
            }
        case 1 :
            self.mySearchBar.text = nil
            let a = self.subcribleView.searchsuggests[indexPath.row].query
            loadSearchNormal(str: a)
            
            isCollectionView = 2
            self.btnCheck.isHidden = false
            self.btnCheck.setTitle("Continue", for: .normal)
            self.myCollectionView.reloadData()
            AligningCollectionViewCells(a: 10, b: 4,c: 120)
            
        case 2 :
            
            if  self.subcribleView.searchnormals[indexPath.row].hot == -1 {
                self.subcribleView.searchnormals[indexPath.row].hot = -2
                
            }else{
                self.subcribleView.searchnormals[indexPath.row].hot = -1
                print("fav")
            }
            
            self.myCollectionView.reloadData()
        case 3 :
            print("input 3")
        default:
            print("iscl = default")
        }
        
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
    @IBAction func scrHomeVc(_ sender: UIButton) {
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
    @IBAction func isBtnCheck(_ sender: Any) {
        switch isCollectionView {
        case 0:
            self.btnCheck.isHidden = true
            self.myCollectionView.reloadData()
        case 1:
            print("1")
        case 2:
            for item in self.subcribleView.searchnormals {
                if item.hot == -1 {
                    saveData(id: String(item.encode_sd_id))
                    loadSearchSample(id: String(item.encode_sd_id))
                }
            }
            
            isCollectionView = 0
            self.btnCheck.isHidden = true
            self.myCollectionView.reloadData()
        case 3 :
            isCollectionView = 0
            self.btnCheck.isHidden = true
            self.myCollectionView.reloadData()
        default:
            print("loi tai add fav")
        }
    }
    
    let realm = try! Realm()
    
    var isCollectionView :Int = 0
    
    @IBOutlet weak var topSearchBar: NSLayoutConstraint!
    @IBOutlet weak var topBtnOption: NSLayoutConstraint!
    @IBOutlet weak var topBtnReturn: NSLayoutConstraint!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    var subcribleView = SubcribleViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib1 = UINib(nibName: "SubcribleCollectionViewCell", bundle: nil)
        myCollectionView.register(nib1, forCellWithReuseIdentifier: "SubcribleCollectionViewCell")
        let nib2 = UINib(nibName: "SearchStrCollectionViewCell", bundle: nil)
        myCollectionView.register(nib2, forCellWithReuseIdentifier: "SearchStrCollectionViewCell")
        
        AligningCollectionViewCells(a: 10, b: 4,c: 120)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        topBtnReturn.constant = CGFloat((view.frame.height - 10)/12)
        topBtnOption.constant = CGFloat((view.frame.height - 10)/12)
        topSearchBar.constant = CGFloat((view.frame.height)/9)
        // Do any additional setup after loading the view.
        // searchbar
        mySearchBar.delegate = self
        mySearchBar.endEditing(true)
        searchBarSearchButtonClicked(mySearchBar)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        //
        
        let list = realm.objects(TeamId.self).toArray(ofType: TeamId.self)
        print(list)
        loadArrSearchSample(arrId: list)
        
    }
    func AligningCollectionViewCells(a:Int,b:Int,c:Int){
        let layout = UICollectionViewFlowLayout()
        self.myCollectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: (Int(view.frame.width) + (a)) / b, height: c)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 7
    }
    
    private func saveData(id: String) {
        
        let data = TeamId()
        
        data.id = id
        
        try! realm.write {
            realm.add(data, update: .modified)
        }
    }
    private func deleteData(id: String) {
        let dataFilters = realm.objects(TeamId.self).filter("id = %@", id)
        try! realm.write {
            realm.delete(dataFilters)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadSearchSuggest(str: searchText)
        if searchBar.text != nil {
            isCollectionView = 1
            
            self.btnCheck.isHidden = true
            self.myCollectionView.reloadData()
            AligningCollectionViewCells(a: -10, b: 1,c:50)
        }
    }
    
    func loadSearchSuggest(str:String){
        subcribleView.loadAPISearchSuggest(str:str){ (done,msg)  in
            if done {
                print("sugget \(self.subcribleView.searchsuggests)")
                
                self.myCollectionView.reloadData()
            } else {
                print("API ERROR: \(msg)")
            }
        }
    }
    func loadSearchNormal(str:String){
        subcribleView.loadAPISearchNormal(str:str){ (done,msg)  in
            if done {
                
                self.myCollectionView.reloadData()
            } else {
                print("API ERROR: \(msg)")
            }
        }
    }
    func loadArrSearchSample(arrId:[TeamId]){
        for item in arrId {
            subcribleView.loadAPISearchSample(id:item.id){ (done,msg)  in
                if done {
                    print(self.subcribleView.searchsamples)
                    self.myCollectionView.reloadData()
                } else {
                    print("API ERROR: \(msg)")
                }
                
            }
        }
    }
    func loadSearchSample(id:String){
        
        subcribleView.loadAPISearchSample(id:id){ (done,msg)  in
            if done {
                print(self.subcribleView.searchsamples)
                self.myCollectionView.reloadData()
            } else {
                print("API ERROR: \(msg)")
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
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("end searching --> Close Keyboard")
        self.mySearchBar.endEditing(true)
    }
    
}
