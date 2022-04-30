//
//  EditViewController.swift
//  Practice
//
//  Created by Mitsu Kumagai on 2022/04/01.
//

import UIKit
import RealmSwift

class EditViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int){
        number = row
    }
    
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var textField: UITextField!
    
    var array = ["","宿題","娯楽","その他"]
    var number: Int!
    var cellNum: Int!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        number  = nil
        
        let tasks = realm.objects(Task.self)
        if cellNum != nil{
            textField.text = tasks[cellNum].title
            self.pickerView.selectRow(tasks[cellNum].num, inComponent: 0, animated: false)
            number = tasks[cellNum].num
        }
        //        pickerView.numberOfRows(inComponent: tasks.count)
        
    }
    
    @IBAction func save(){
        if cellNum == nil{
            if number == nil || number == 0{
                let alertS: UIAlertController = UIAlertController(title: "不可", message: "タスクの種類を選択してください", preferredStyle: .alert)
                alertS.addAction(UIAlertAction(title: "OK", style: .default ))
                present(alertS, animated: true, completion: nil)
            }else{
                let task = Task()
                task.title = textField.text
                task.num = number
                try! realm.write{
                    realm.add(task)
                }
                let alertF: UIAlertController = UIAlertController(title: "保存", message: "タスクの追加が完了しました", preferredStyle: .alert)
                alertF.addAction(UIAlertAction(title: "OK", style: .default,  handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                present(alertF, animated: true, completion: nil)
                
            }
        }
        else{
            if number == 0{
                let alertK: UIAlertController = UIAlertController(title: "不可", message: "タスクの種類を選択してください", preferredStyle: .alert)
                alertK.addAction(UIAlertAction(title: "OK", style: .default ))
                present(alertK, animated: true, completion: nil)
            }else{
                var ank = realm.objects(Task.self)[cellNum]
                let alertC: UIAlertController = UIAlertController(title: "変更", message: "タスクの変更が完了しました", preferredStyle: .alert)
                alertC.addAction(UIAlertAction(title: "OK", style: .default,  handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                if textField.text == ank.title && number == ank.num{
                    present(alertC, animated: true, completion: nil)
                }else{
                    print("ねこだいすき",number)
                    try! realm.write({
                        ank.title = textField.text
                        ank.num = number
                    })

                    present(alertC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func delete(){
        let filter = realm.objects(Task.self)[cellNum]
        print(filter)
        try! realm.write{
            realm.delete(filter)
        }
        let alertD: UIAlertController = UIAlertController(title: "破棄", message: "タスクの削除が完了しました", preferredStyle: .alert)
        alertD.addAction(UIAlertAction(title: "OK", style: .default,  handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alertD, animated: true, completion: nil)
        
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
