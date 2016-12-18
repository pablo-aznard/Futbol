//
//  PlantillaTableVC.swift
//  Futbol
//
//  Created by Pruebas on 15/12/16.
//  Copyright © 2016 Pruebas. All rights reserved.
//

import UIKit

class PlantillaTableVC: UITableViewController {
    
    var url = ""
    var model = [[String:Any]]()
    var cache = [String:UIImage]()
    var index = 0

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
                if let data = try? Data(contentsOf: url){
                    if let arr = (try? JSONSerialization.jsonObject(with: data)) as? [String:[String:Any]]{
                        let nestedArr = arr["team"]
                        if let squad = nestedArr?["squad"] as? [[String:Any]]{
                            DispatchQueue.main.async {
                                self.model = squad
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "pc", for: indexPath) as! PlantillaCell
        
        let nombre = model[indexPath.row]["nick"] as? String
        var dorsal = model[indexPath.row]["squadNumber"] as? String
        let foto = model[indexPath.row]["image"] as? String
        let posicion = model[indexPath.row]["role"] as? String
        
        if(dorsal == nil){
            dorsal = "-"
        }
        
        cell.nombre.text = nombre
        cell.dorsal.text = dorsal
        cell.posicion.text = posicionJugador(posicion: posicion!)
        
        descargaFoto(strUrl: foto, cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func posicionJugador(posicion: String) -> String{
        switch posicion {
        case "1":
            return "Portero"
        case "2":
            return "Defensa"
        case "3":
            return "Centrocampista"
        case "4":
            return "Delantero"
        default:
            return ""
        }
    }
    
    func descargaFoto(strUrl: String?, cell: PlantillaCell, indexPath: IndexPath){
        
        cell.foto?.image = #imageLiteral(resourceName: "reloj-de-arena-10375")
        
        if let str = strUrl {
            
            if let img = cache[str] {
                cell.foto?.image = img
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
        
        if segue.identifier == "Info" {
            if let ivc = segue.destination as? InfoVC{
                ivc.url = url
            }
        }
        if segue.identifier == "jugador" {
            if let jvc = segue.destination as? JugadorVC, let index = tableView.indexPathForSelectedRow {
                let id = model[index.row]["id"] as? String
                jvc.url = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=5677e7b48996414c8d26d688eda421be&tz=Europe/Madrid&format=json&req=player&id=" + id!
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
