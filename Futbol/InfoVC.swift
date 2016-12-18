//
//  InfoVC.swift
//  Futbol
//
//  Created by Pablo on 17/12/16.
//  Copyright © 2016 Pruebas. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    var url = ""
    var imgUrl : String = ""
    var imgUrl2 : String = ""
    var nombreCampo2: String = ""
    
    @IBOutlet weak var campo: UIImageView!
    @IBOutlet weak var escudo: UIImageView!
    @IBOutlet weak var entrenador: UILabel!
    @IBOutlet weak var presidente: UILabel!
    @IBOutlet weak var nombreCampo: UILabel!
    @IBOutlet weak var nombreEquipo: UILabel!
    @IBOutlet weak var ano: UILabel!
    
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
                    if let arr = (try? JSONSerialization.jsonObject(with: data)) as? [String:[String:Any]]{
                        let nestedArr = arr["team"]
                        if let manager = nestedArr?["managerNow"] as? String{
                            DispatchQueue.main.async {
                                self.entrenador.text = manager
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let chairman = nestedArr?["chairman"] as? String{
                            DispatchQueue.main.async {
                                self.presidente.text = chairman
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let nameshow = nestedArr?["nameShow"] as? String{
                            DispatchQueue.main.async {
                                self.nombreEquipo.text = nameshow
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let stadium = nestedArr?["stadium"] as? String{
                            DispatchQueue.main.async {
                            self.nombreCampo.text = stadium
                            self.view.setNeedsDisplay()
                            }
                        }
                        if let year = nestedArr?["yearFoundation"] as? String{
                            DispatchQueue.main.async {
                                self.ano.text = year
                                self.view.setNeedsDisplay()
                            }
                        }
                        if let img = nestedArr?["img_stadium"] as? String{
                            DispatchQueue.main.async {
                                self.imgUrl = img
                                self.foto(strUrl: self.imgUrl, imageView: self.campo)
                            }
                        }
                        if let shield = nestedArr?["shield"] as? String{
                            DispatchQueue.main.async {
                                self.imgUrl2 = shield
                                self.foto(strUrl: self.imgUrl2, imageView: self.escudo)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func foto(strUrl: String?, imageView: UIImageView){
        
       imageView.image = #imageLiteral(resourceName: "reloj-de-arena-10375")
        
        if let str = strUrl {
            DispatchQueue.global().async {
                    if let url = URL(string: str),
                        let data = try? Data(contentsOf: url){
                            imageView.image = UIImage(data:data)
                    
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
