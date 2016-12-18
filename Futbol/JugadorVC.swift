//
//  JugadorVC.swift
//  Futbol
//
//  Created by Pablo on 17/12/16.
//  Copyright © 2016 Pruebas. All rights reserved.
//

import UIKit

class JugadorVC: UIViewController {

    var url = ""
    var model = [String:Any]()
    var index = 0
    var imgUrl = ""
    var imgUrl2 = ""
    
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var apellidos: UILabel!
    @IBOutlet weak var posicion: UILabel!
    @IBOutlet weak var edad: UILabel!
    @IBOutlet weak var nacimiento: UILabel!
    @IBOutlet weak var pais: UILabel!
    @IBOutlet weak var bandera: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        download()

        // Do any additional setup after loading the view.
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
                    if let arr = (try? JSONSerialization.jsonObject(with: data)) as? [String:Any]{
                        if let avatar = arr["player_avatar"] as? String{
                            DispatchQueue.main.async {
                                self.imgUrl = avatar
                                self.descargaFoto(strUrl: self.imgUrl, imageView: self.foto)
                            }
                        }
                        if let name = arr["name"] as? String{
                            DispatchQueue.main.async {
                                self.nombre.text = name
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let lastname = arr["last_name"] as? String{
                            DispatchQueue.main.async {
                                self.apellidos.text = lastname
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let role = arr["role"] as? String{
                            DispatchQueue.main.async {
                                self.posicion.text = self.posicionJugador(posicion: role)
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let age = arr["age"] as? String{
                            DispatchQueue.main.async {
                                self.edad.text = age
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let birthdate = arr["birthdate"] as? String{
                            DispatchQueue.main.async {
                                self.nacimiento.text = birthdate
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let country = arr["country"] as? String{
                            DispatchQueue.main.async {
                                self.pais.text = country
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let flag = arr["country_flag"] as? String{
                            DispatchQueue.main.async {
                                self.imgUrl2 = flag
                                self.descargaFoto(strUrl: self.imgUrl2, imageView: self.bandera)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func descargaFoto(strUrl: String?, imageView: UIImageView){
        
        imageView.image = #imageLiteral(resourceName: "reloj-de-arena-10375")
        
        if let str = strUrl {
            
            // if let img = cache[str] {
            //     cell.escudo?.image = img
            // } else {
            DispatchQueue.global().async {
                if let url = URL(string: str),
                    let data = try? Data(contentsOf: url){
                    imageView.image = UIImage(data:data)
                    
                }
            }
        }
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
    
   /* private func datos() {
        jugador.text = model[index]["nick"] as? String
        view.setNeedsDisplay()
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
