//
//  NewNoteController.swift
//  day02
//
//  Created by Dremora Restless on 11/25/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class NewNoteController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var personDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    private var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        descriptionTextView.layer.cornerRadius = 8
        
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = 4
    }
    
//    @IBAction func backToMainTapped(_ sender: Any) {
//        performSegue(withIdentifier: "unwindToMain", sender: self)
//    }
    
    @IBAction func doneTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {return}
        note = Note(withName: name, andDate: personDatePicker.date, andDescription: descriptionTextView.text)
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is NotesListTableViewController
        {
            let vc = segue.destination as? NotesListTableViewController
            guard let note = self.note else {return}
            vc?.people.append(note)
        }
    }
}
