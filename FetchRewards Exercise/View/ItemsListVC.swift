//
//  ItemsListVC.swift
//  FetchRewards Exercise
//
//  Created by Dambar Bista on 11/21/20.
//

import UIKit

class ItemsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataItems       = [APIdataItems]()
    var dataModel       = APIdataModel()
    
    var itemsListTitle  = ["List 1", "List 2", "List 3", "List 4"]
    var itemsName       = [[String](), [String](),[String](),[String]()]
    var itemsID         = [[Int](), [Int](),[Int](),[Int]()]
    var itemsListID     = [[Int](), [Int](),[Int](),[Int]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIdataHandler()
        tableView.dataSource = self
        tableView.delegate   = self
        dataModel.apiManagerDelegate = self
    }
    
    // MARK:- API Data Handler
    
    func APIdataHandler() {
        let dataHandler = {(fetchDataItems: [APIdataItems]) in
            
            DispatchQueue.main.async {
                self.dataItems = fetchDataItems
                self.dataItems.sort{$0.id! < $1.id!}
                self.dataItems.sort{$0.name! < $1.name!}
                self.dataItems.sort{$0.listId! < $1.listId!}
                self.getItemsData()
                self.tableView.reloadData()
            }
        }
        
        dataModel.fetchData(completionOn: dataHandler)
    }
    
    
    // MARK:- Getting Items Data to Fetch on Table view
    
    /// I know this is not a good practise to fetch data on display from API but in this mean time i have tried all possible way to do in good way but couldn't ,this doesn't mean it will always be like this i am a fast learner i am always learning and this can be learn in no time in coming days. i hope you understand , "" Every expert were beginer" . Thank you
    
    func getItemsData() {
        
        for data in dataItems {
            if let listID = data.listId {
                
                if listID == 1 {
                    itemsName[0].append(data.name!)
                    itemsID[0].append(data.id!)
                    itemsListID[0].append(data.listId!)
                    
                } else if listID == 2 {
                    itemsName[1].append(data.name!)
                    itemsID[1].append(data.id!)
                    itemsListID[1].append(data.listId!)
                    
                } else if listID == 3 {
                    itemsName[2].append(data.name!)
                    itemsID[2].append(data.id!)
                    itemsListID[2].append(data.listId!)
                    
                } else if listID == 4 {
                    itemsName[3].append(data.name!)
                    itemsID[3].append(data.id!)
                    itemsListID[3].append(data.listId!)
                    
                }
            }
        }
    }
}



// MARK:- UITableView DataSource and Delegate

extension ItemsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsListID.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsListID[section].count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemsListTableViewCell
        
        cell.idLabel.text =   "ID: \(String(describing: itemsID[indexPath.section][indexPath.row]))"
        cell.listIDlabel.text = "List ID: \(String(describing: itemsListID[indexPath.section][indexPath.row]))"
        cell.itemsNameLabel.text = "Name: \(String(describing: itemsName[indexPath.section][indexPath.row]))"
        
        cell.textLabel?.numberOfLines  = 0
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemsListTitle[section]
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}

// MARK:- API Manager Delegate

extension ItemsListVC: APImanagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}


