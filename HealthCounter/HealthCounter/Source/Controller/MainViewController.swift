//
//  MainViewController.swift
//  HealthCounter
//
//  Created by Wi on 31/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var healthcells: [HealthCellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    // MARK: configure
    
    func configure(){
        // MARK: google banner
        //testUnitId
        self.bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        
        let healthcellData = HealthCellData.init(isCustomCell: true, isTimerCellOpen: nil, indexPath: nil, exerciseName: nil, count: nil, setCount: nil)
        healthcells.append(healthcellData)
        tableView.separatorColor = .clear //셀의 경계선 투명으로
        tableView.reloadData()
        
        // MARK: Noti
        NotificationCenter.default.addObserver(self, selector: #selector(startButtonDidTap), name: NSNotification.Name(rawValue: "startButtonDidTap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("reloadTableView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadRoutine), name: NSNotification.Name("loadRoutine"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editBtnDidTap), name: NSNotification.Name("editBtnDidTap"), object: nil)
    }
    
    // MARK: objc func
    
    @objc private func startButtonDidTap(_ noti: Notification){
        guard let userInfo = noti.userInfo as? [String: HealthCellData], let healthData = userInfo["healthCellData"] else { print("healthCellData Noti err"); return }
        
        healthcells.remove(at: healthData.indexPath!.section)
        healthcells.insert(healthData, at: healthData.indexPath!.section)
        tableView.reloadData()
    }
    @objc private func reloadTableView(_ noti: Notification){
        guard let userInfo = noti.userInfo as? [String: HealthCellData],
              let healthData = userInfo["model"]
        else { print("model Noti err"); return }
        // 현재 셀 데이터를 바꿔주기 
        healthcells.remove(at: (healthData.indexPath?.section)!)
        healthcells.insert(healthData, at: (healthData.indexPath?.section)!)
        
        tableView.reloadData()
    }
    @objc private func loadRoutine(noti: Notification){
        guard let userInfo = noti.userInfo as? [String: Data], let data = userInfo["healthData"] else {return}
        do {
            let routineData = try JSONDecoder().decode(RoutineData.self, from: data)
            self.healthcells = routineData.HealthCellDatas
            tableView.reloadData()
        }catch{
            print(error.localizedDescription)
        }
    }
    @objc private func editBtnDidTap(_ noti: Notification){
        guard let userInfo = noti.userInfo as? [String: HealthCellData],
              var healthData = userInfo["model"] else {return}
        healthData.isCustomCell = true
        self.healthcells.remove(at: healthData.indexPath?.section ?? 0)
        self.healthcells.insert( healthData, at: healthData.indexPath?.section ?? 0)
        tableView.reloadData()
    }
    
    
    // MARK: IBAction func
    
    @IBAction func addCustomHealthCellBtnDidTap(_ sender: Any) {
        let healthcellData = HealthCellData.init(isCustomCell: true, isTimerCellOpen: nil, indexPath: nil, exerciseName: nil, count: nil, setCount: nil)
        healthcells.append(healthcellData)
        tableView.reloadData()
    }
    @IBAction func routineSaveButtonDidTap(_ sender: Any) {
        saveRoutine()
    }
    
    @IBAction func resetBtnDIdTap(_ sender: Any) {
        self.healthcells = []
        tableView.reloadData()
    }
    
    
    // MARK: private func
    
    private func saveRoutine(){
        let alertController = UIAlertController(title: "루틴 저장", message: "루틴의 이름을 정해주세요", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // ok 눌렀을때 이름과 현재 창에 있는 셀 데이터 배열 저장하기
            guard let routineName = alertController.textFields?.first?.text else {return}
            let routineData = RoutineData.init(routineName: alertController.textFields![0].text ?? "임의 루틴 이름", HealthCellDatas: self.healthcells)
            let data = try! JSONEncoder().encode(routineData)
            if self.save(routineName: routineName, exercises: data){
                let completeAlert = UIAlertController(title: "저장되었습니다", message: nil, preferredStyle: .alert)
                completeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                NotificationCenter.default.post(name: NSNotification.Name("reloadRoutineTableView"), object: nil)
                self.tableView.reloadData()
                self.present(completeAlert, animated: true)
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: CoreData Func
    
    // 데이터를 저장할 메소드
    func save(routineName: String, exercises: Data) -> Bool {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 관리 객체 생성 & 값을 설정
        let object = NSEntityDescription.insertNewObject(forEntityName: "Routine", into: context)
        object.setValue(routineName, forKey: "routineName")
        object.setValue(exercises, forKey: "exercises")
        
        // 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가한다.
        do{
            try context.save()
            return true
        }catch{
            context.rollback()
            return false
        }
    }
    
}
extension MainViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return healthcells.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let isTimerCellOpen = healthcells[section].isTimerCellOpen else { return 1 }
        if isTimerCellOpen == true{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if healthcells[indexPath.section].isCustomCell{
                guard let customHealthCell = Bundle.main.loadNibNamed("CustomHealthCell", owner: self, options: nil)?.first as? CustomHealthCell else {print("Cell Nib load err"); return UITableViewCell()}
                customHealthCell.model = healthcells[indexPath.section]
                customHealthCell.selectionStyle = .none
                return customHealthCell
            }else{
                guard let healthCell = Bundle.main.loadNibNamed("HealthCell", owner: self, options: nil)?.first as? HealthCell else {print("Cell Nib load err"); return UITableViewCell()}
                healthCell.selectionStyle = .none
                healthCell.model = healthcells[indexPath.section]
                return healthCell
            }
            
        }else{
            print("TimerCell")
            guard let timerCell = Bundle.main.loadNibNamed("TimerTableViewCell", owner: self, options: nil)?.first as? TimerTableViewCell else {print("Cell Nib load err"); return UITableViewCell()}
            timerCell.selectionStyle = .none
            return timerCell
        }
        
    }
    
    
}
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            healthcells.remove(at: indexPath.section)
            tableView.reloadData()
        default:
            break
        }
    }
}
