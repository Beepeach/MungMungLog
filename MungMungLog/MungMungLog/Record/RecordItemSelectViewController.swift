//
//  RecordItemSelectViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/10.
//

import UIKit

struct RecordItem {
    let imageName: String
    let title: String
}


class RecordItemSelectViewController: UIViewController {

    let recordItemList: [RecordItem] = [
        RecordItem(imageName: "rice", title: "밥"),
        RecordItem(imageName: "snack", title: "간식"),
        RecordItem(imageName: "pill", title: "약"),
        RecordItem(imageName: "hospital", title: "병원"),
        RecordItem(imageName: "walk", title: "산책")
    ]
    
    @IBOutlet weak var recordItemListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension RecordItemSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordItemCell", for: indexPath) as? RecordItemTableViewCell else {
            return UITableViewCell()
            
        }
        
        cell.recordItemImageView.image = UIImage(named: recordItemList[indexPath.row].imageName)
        cell.recordItemTitleLabel.text = recordItemList[indexPath.row].title
        
        
        return cell
    }
    
    
}


extension RecordItemSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let safeAreaHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        return safeAreaHeight / 5
        
    }
}
