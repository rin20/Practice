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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return op.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for:indexPath) as! TableViewCell
        
        cell.label.text = op[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        number = indexPath.row
        performSegue(withIdentifier: "segue", sender: nil)
        print("できてる")
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
    
    
    @IBOutlet var TableView: UITableView!
    
    let realm = try! Realm()
    let saveNumber: UserDefaults = UserDefaults.standard
    
    var op: Results<Task>!
    var number: Int!
    var l: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        TableView.delegate = self
        TableView.dataSource = self
        
//        aaaaaaaa
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        op = realm.objects(Task.self)
        TableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let nextView = segue.destination as! EditViewController
            nextView.cellNum = number
        }
    }
    
    @IBAction func newPage(){

        number = nil
        performSegue(withIdentifier: "new", sender: nil)
        print("newPage")
    }


}

