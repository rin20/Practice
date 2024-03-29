//
//  ViewController.swift
//  Practice
//
//  Created by Mitsu Kumagai on 2022/04/01.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var TableView: UITableView!
    @IBOutlet var Item: UIBarButtonItem!
    
    var op: Results<Task>!
//    var number: Int!
    var Title: String!
    var l: Int!
    var kazu: Int!
    
    let realm = try! Realm()
    let saveNumber: UserDefaults = UserDefaults.standard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return op.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for:indexPath) as! TableViewCell
        
        cell.task = op[indexPath.row]
        cell.label.text = op[indexPath.row].title
        cell.num = indexPath.row
        if op[indexPath.row].isDone == true{
            cell.button.backgroundColor = UIColor(named: "isDoneColor")
        }else{
            cell.button.backgroundColor = UIColor.white
        }
        
        if op[indexPath.row].num == 1{
            cell.backgroundColor = UIColor(named: "taskColor1")
            cell.label.textColor = UIColor(named: "textColor1")
        }else if op[indexPath.row].num == 2{
            cell.backgroundColor = UIColor (named: "taskColor2")
            cell.label.textColor = UIColor(named: "textColor2")
        }else if op[indexPath.row].num == 3{
            cell.backgroundColor = UIColor(named: "taskColor3")
            cell.label.textColor = UIColor(named: "textColor3")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        number = indexPath.row
        Title = op[indexPath.row].title
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            try! realm.write{
                realm.delete(op[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
           
        }
    }
    
    private func tableView(_ tableView: UITableView, willDisplay cell: TableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
   func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           return true
       }

   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       try! realm.write{
           realm.delete(op[sourceIndexPath.row])
           realm.add(op[destinationIndexPath.row])
       }
        }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        TableView.delegate = self
        TableView.dataSource = self
        
        isEditing = true
        
        TableView.separatorColor = UIColor(named: "separator")
        
//        aaaaaaaa
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let items = UIMenu(options: .displayInline, children: [
            UIAction(title: "追加順", handler: { [self]_ in
                kazu = 0
                sort()
            }),
            UIAction(title: "種類順", handler: { [self]_ in
                kazu = 1
                sort()
            })])
        
        Item.menu = UIMenu(title: "", children: [items])

        sort()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let nextView = segue.destination as! EditViewController
            nextView.cellNum = Title
        }
    }
    
    
    
    func sort(){
        let sortProperties = [
            SortDescriptor(keyPath: "isDone", ascending: true),
            SortDescriptor(keyPath: "num", ascending: true)
        ]
        let sortPropertiesS = [
            SortDescriptor(keyPath: "isDone", ascending: true),
            ]
        if kazu == 1 {
            op = realm.objects(Task.self).sorted(by: sortProperties)
        }else {
            op = realm.objects(Task.self).sorted(by: sortPropertiesS)
        }
        TableView.reloadData()
    }
    
    @IBAction func newPage(){

//        number = nil
        performSegue(withIdentifier: "new", sender: nil)
    }

}

