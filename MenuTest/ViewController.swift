//
//  ViewController.swift
//  MenuTest
//
//  Created by fred on 01/04/2021.
//

import UIKit

class CellClass: UITableViewCell {
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var paysButton: UIButton!
    @IBOutlet weak var villeButton: UIButton!
    
    let darkenView = UIView()  
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func addDarkenView(frames: CGRect) {
        
        //let window = UIApplication.shared.windows
              //  let currentWindow = window[window.count - 1]
               // darkenView.frame = currentWindow.frame
        darkenView.frame = view.frame
        darkenView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addSubview(darkenView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeDarkenView))
        darkenView.addGestureRecognizer(tapgesture)
        self.darkenView.alpha = 0.6
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
    }
    
    @objc func removeDarkenView() {
        
        self.darkenView.alpha = 0
        tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    @IBAction func paysButtonPressed(_ sender: Any) {
        dataSource = ["France", "Portugual", "Allemagne"]
        selectedButton = paysButton
        addDarkenView(frames: paysButton.frame)
    }
    
    @IBAction func villeButtonPressed(_ sender: Any) {
        dataSource = ["Paris", "Bordeaux", "Lyon", "Marseille", "Lille", "Nantes"]
        selectedButton = villeButton
        addDarkenView(frames: villeButton.frame)
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeDarkenView()
    }
}
