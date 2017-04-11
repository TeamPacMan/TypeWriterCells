//
//  ViewController.swift
//  TableCellTypeWriter
//
//  Created by André Vellori on 07/04/2017.
//  Copyright © 2017 André Vellori. All rights reserved.
//

import UIKit

class TableController: UITableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParagraphTableViewCell", for: indexPath) as! ParagraphTableViewCell
        
        cell.tableView = self.tableView
        self.configureCell(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    
    func configureCell(cell: ParagraphTableViewCell, atIndexPath indexPath: IndexPath) {
        
//        let paragraph = paragraphArray[indexPath.row] as! Paragraph
        
        let pauseCharactersArray:[Int:Double] = [1:0, 6:0]
        cell.dialogueLabel.setTextWithTypeAnimation(id:"intro", typedText: "lorem ipsum\nlorem ipsum\nlorem ipsum\n", pauseCharacterArray: pauseCharactersArray)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension UILabel {
    
    func setTextWithTypeAnimation(id:String, typedText: String, pauseCharacterArray: [Int:Double], characterInterval: TimeInterval = 0.06 ) {
        
        text = ""
    
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            for (index, character) in typedText.characters.enumerated() {
                
                DispatchQueue.main.async {
                    if let delegate = (self.superview?.superview as? ParagraphTableViewCell)?.tableView {
                        delegate.beginUpdates()
                        self.text = self.text! + String(character)
                        delegate.endUpdates()
                    }
                }
                
                Thread.sleep(forTimeInterval: characterInterval)
            }
            
        }
    
    }
}

class ParagraphTableViewCell: UITableViewCell {
    @IBOutlet weak var dialogueLabel: UILabel!
    weak var tableView: UITableView?
}
