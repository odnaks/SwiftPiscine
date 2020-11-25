//
//  NotesListTableViewController.swift
//  day02
//
//  Created by Dremora Restless on 11/25/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    var people: [Note] = [Note(withName: "Vladimir Putin", andDate: Date(), andDescription: "He will die"),
                          Note(withName: "Vladimir Putin clone 1", andDate: Date(), andDescription: "He will die too"),
                          Note(withName: "Vladimir Pution clone 2", andDate: Date(), andDescription: "and he will die too")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.separatorStyle = .none
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        tableView.reloadData()
        let indexPath = IndexPath(item: people.count - 1, section: 0)
        tableView.reloadRows(at: [indexPath], with: .top)
    }

    @IBAction func addButtonClick(_ sender: Any) {
        performSegue(withIdentifier: "segueToNewNote", sender: self)
    }
    
    private func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
        
        cell.nameLabel.text = people[indexPath.row].name
        cell.descriptionLabel.text = people[indexPath.row].desc
        let formatingDate = getFormattedDate(date: people[indexPath.row].date, format: "dd.MM.yyyy")
        cell.dateLabel.text = formatingDate
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: cell.frame.width - 20, height: cell.frame.height - 10))
        let image = UIImage(named: "paperBackground")
        imageView.image = image
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
//        imageView.layer.opacity = 0.8
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
        cell.isUserInteractionEnabled = false

        return cell
    }

}

