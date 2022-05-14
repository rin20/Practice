//
//  TableViewCell.swift
//  Practice
//
//  Created by Mitsu Kumagai on 2022/04/04.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var labelB: UILabel!
    
    let realm = try! Realm()
    
    var num: Int!
    var task: Task?
    var buttonC: Bool!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        print(task?.title, task?.isDone)
        
        if task?.isDone == true{
            button.backgroundColor = UIColor.red
        }else{
            button.backgroundColor = UIColor.white
            }
        
        self.button.layer.borderWidth  = 2
        self.button.layer.borderColor = UIColor.white.cgColor
        self.button.layer.cornerRadius = 13.5
        self.labelB.layer.cornerRadius = 14.5
        self.labelB.layer.borderWidth  = 1
        
        self.contentView.sendSubviewToBack(labelB)
        
       
        
        //        labelB.isHidden = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func Button(){
        let tasks = realm.objects(Task.self)[num]
        if tasks.isDone == false{
            button.backgroundColor = UIColor.red
            try! realm.write{
                tasks.isDone = true
            }
        }else{
            button.backgroundColor = UIColor.white
            try! realm.write{
                tasks.isDone = false
            }
        }
        
        print(tasks.title,tasks.isDone)
    }
}


