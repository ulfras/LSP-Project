//
//  ViewController.swift
//  DependencyReuse
//
//  Created by Maulana Frasha on 01/07/22.
//

import UIKit
import DropDown

class ViewController: UIViewController {
    
    var countryArray: [String] = []
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
            print("Selected item: \(item) at index: \(index)")
            self.pilihKategoriTextFieldOutlet.text = countryArray[index]
          }
    }
    
    @IBAction func testButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func chooseCountryButtonAction(_ sender: Any) {
        dropDownKategori()
        dropDown.show()
    }
}

