//
//  ViewController.swift
//  Practice
//
//  Created by Mitsu Kumagai on 2022/04/01.
//

import UIKit
import RealmSwift
import SwiftUI

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
//        cell.buttonC = op[indexPath.row].isDone
        if op[indexPath.row].isDone == true{
            cell.button.backgroundColor = UIColor.red
        }else{
            cell.button.backgroundColor = UIColor.white
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if realm.objects(Task.self)[indexPath.row].num == 1{
            cell.backgroundColor = UIColor(red: 0.79, green: 0.78, blue: 0.89, alpha: 1.0)
        }else if realm.objects(Task.self)[indexPath.row].num == 2{
            cell.backgroundColor = UIColor(red: 0.85, green: 0.90, blue: 0.97, alpha: 1.0)
        }else if realm.objects(Task.self)[indexPath.row].num == 3{
            cell.backgroundColor = UIColor(red: 0.78, green: 0.89, blue: 0.92, alpha: 1.0)
        }
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
        print("newPage")
    }

}

