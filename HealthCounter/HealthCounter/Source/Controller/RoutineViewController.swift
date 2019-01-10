//
//  RoutineViewController.swift
//  HealthCounter
//
//  Created by Wi on 07/01/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit
import CoreData

class RoutineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    // 데이터 소스 역할을 할 배열 변수
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("reloadRoutineTableView"), object: nil)
    }
    
    // MARK: objc func
    
    @objc private func reloadTableView(){
        print("reloadRoutineTableView")
        tableView.reloadData()
    }
    
    // MARK: CoreData func
    
    // 데이터를 가져올 메소드
    func fetch() -> [NSManagedObject] {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 요청 객체생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Routine")
        // 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        return result
    }
    // 데이터 삭제 메소드
    func delete(object: NSManagedObject) -> Bool{
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        do {
            try context.save()
            return true
        }catch{
            context.rollback()
            return false
        }
        
    }
    
}
extension RoutineViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let routineTableVIewCell = Bundle.main.loadNibNamed("RoutineTableViewCell", owner: self, options: nil)?.first as? RoutineTableViewCell else {return UITableViewCell()}
        routineTableVIewCell.routineNameLabel.text = list[indexPath.section].value(forKey: "routineName") as? String ?? "기본이름"
        routineTableVIewCell.healthData = list[indexPath.section].value(forKey: "exercises") as? Data ?? Data()
        return routineTableVIewCell
    }
    
    
}
extension RoutineViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.section] // 삭제할 대상 객체
        if self.delete(object: object){
            //코어데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
            self.list.remove(at: indexPath.row)
            self.tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
        }
    }
}
