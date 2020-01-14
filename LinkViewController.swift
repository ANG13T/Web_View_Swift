//
//  LinkViewController.swift
//  WebView
//
//  Created by Angelina Tsuboi on 1/13/20.
//  Copyright © 2020 Angelina Tsuboi. All rights reserved.
//

import UIKit

class LinkViewController: UITableViewController {
    var websites = ["google.com", "facebook.com"]
    
    override func viewDidLoad() {
        title = "Links"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linkCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let wvc = storyboard?.instantiateViewController(identifier: "webView") as? ViewController {
            wvc.initialIndex = indexPath.row
            for website in websites {
                wvc.websites.append(website)
            }
            
            navigationController?.pushViewController(wvc, animated: true)
        }
    }
    
    
    @IBAction func addLinkPressed(_ sender: Any) {
        var textField = UITextField()
               let ac = UIAlertController(title: "Add a Link", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Add Link", style: .default) { (action) in
            if(textField.text != nil){
                print("Created Link!")
                self.websites.append(textField.text!)
                self.tableView.reloadData()
            }
            })
               ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               ac.addTextField { (alertTextField) in
                    alertTextField.placeholder = "Create new link"
                    textField = alertTextField
                }
               present(ac, animated: true)
    }
    
 
}
