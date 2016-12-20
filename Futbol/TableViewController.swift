//
//  TableViewController.swift
//  Futbol
//
//  Created by Pruebas on 13/12/16.
//  Copyright © 2016 Pruebas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let url = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=5677e7b48996414c8d26d688eda421be&tz=Europe/Madrid&format=json&req=tables&league=1&group=1"
    var model = [[String:Any]]()
    var cache = [String:UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        download()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func download () {
        if let url = URL(string: url) {
            let q = DispatchQueue.global()
            q.async {
                do{
                    let data = try Data(contentsOf: url)
                    if data.description == "10 bytes" {
                        self.alert()
                        return
                    }
                    if let arr = (try? JSONSerialization.jsonObject(with: data)) as? [String:[[String:Any]]]{
                        if let nestedArr = arr["table"] {
                            DispatchQueue.main.async {
                                   self.model = nestedArr
                                   self.tableView.reloadData()
                            }
                        }
                    }
                }
                catch{
                    self.alert()
                    return
                }
            }
        }
        else {
            alert()
        }
    }
            
    
    func alert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error",
                message: "No se ha podido establecer conexión con el servidor",
                preferredStyle: .alert)
            
            self.present(alert, animated: true)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        }

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dc", for: indexPath) as! ClasificationCell
        
        let equipo = model[indexPath.row]["team"] as! String
        let escudo = model[indexPath.row]["shield"] as! String
        let puntos = model[indexPath.row]["points"] as! String
        
        let num = indexPath.row + 1
        
        cell.numero?.text = num.description
        cell.equipo?.text = equipo
        cell.puntos?.text = puntos
        
        foto(strUrl: escudo, cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func foto(strUrl: String?, cell: ClasificationCell, indexPath: IndexPath){
        
        cell.escudo?.image = #imageLiteral(resourceName: "reloj-de-arena-10375")
        
        if let str = strUrl {
            
            if let img = cache[str] {
                cell.escudo?.image = img
            } else {
                DispatchQueue.global().async {
                    if let url = URL(string: str),
                        let data = try? Data(contentsOf: url),
                        let img = UIImage(data:data){
                        
                        DispatchQueue.main.async {
                            self.cache[str] = img
                            self.tableView.reloadRows(at: [indexPath], with: .fade)
                        }
                        
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "plantilla" {
            if let ptvc = segue.destination as? PlantillaTableVC,
                let ip = tableView.indexPathForSelectedRow {
                let id = model[ip.row]["id"] as! String
                ptvc.url = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=5677e7b48996414c8d26d688eda421be&tz=Europe/Madrid&format=json&req=team&id="+id
            }
        }
    }
    
   

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
