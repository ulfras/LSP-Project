//
//  ViewController.swift
//  DependencyReuse
//
//  Created by Maulana Frasha on 01/07/22.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    
    var countryArray: [String] = ["Pilih Negara"]
    let countryAPI = CountryAPI()
    let dropDown = DropDown()
    
    @IBOutlet weak var pilihKategoriTextFieldOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryAPI.getCountryName() { result in
            switch result {
            case let .success(data):
                print(data)
                for i in data {
                    self.countryArray.append(i.name)
                }
                print("Hasil datanya \(self.countryArray)")
            case let .failure(err):
                print(err.localizedDescription)
                print(String(describing: err))
                
            }
        }
    }
    
    func dropDownKategori(){
        dropDown.anchorView = pilihKategoriTextFieldOutlet
        dropDown.dataSource = countryArray
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                print("Selected item: \(item) at index: \(index)")
                self.pilihKategoriTextFieldOutlet.text = ""
            } else {
                print("Selected item: \(item) at index: \(index)")
                self.pilihKategoriTextFieldOutlet.text = countryArray[index]
            }
          }
    }
    
    @IBAction func testButtonAction(_ sender: Any) {
        
        if pilihKategoriTextFieldOutlet.text == "" {
            CustomToast.show(
                message: "Kamu belum memilih negara",
                bgColor: .red,
                textColor: .white,
                labelFont: .systemFont(ofSize: 17),
                showIn: .bottom, controller: self
            )
        } else {
            CustomToast.show(
                message: "Kamu memilih negara \(pilihKategoriTextFieldOutlet.text!)",
                bgColor: .systemGreen,
                textColor: .white,
                labelFont: .systemFont(ofSize: 17),
                showIn: .bottom,
                controller: self
            )
        }
    }
    
    @IBAction func chooseCountryButtonAction(_ sender: Any) {
        dropDownKategori()
        dropDown.show()
    }
}

