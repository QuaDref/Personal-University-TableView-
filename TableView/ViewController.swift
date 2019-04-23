//
//  ViewController.swift
//  TableView
//
//  Created by Quadref on 11.04.2019.
//  Copyright © 2019 Quadref. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    
    private var students = [Student]()
    private var teachers = [Teacher]()
    
    
    private var searchStudent = [Student]()
    private var searchTeacher = [Teacher]()
    
//    let manager = DataManager.shared
    
    private let searchController  = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Search Conroller
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //student
        for index in 0...9 {
            
            let student = Student.init(index: index)
            self.students.append(student)
        }
        
        //teacher
        for index in 0...4 {
            
            let teacher = Teacher.init(index: index)
            self.teachers.append(teacher)
        }
        
        self.TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.font = UIFont.init(name: "System", size: 19)
        label.backgroundColor = UIColor.yellow
        label.text = section == 1 ? "Учителя": "Студенты"
    
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0{
                if isFiltering {
                    return searchStudent.count
                }else{
                    return students.count
                }
            }else{
                if isFiltering {
                    return searchTeacher.count
                }else{
                    return teachers.count
                }
        }
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellTableViewCell
        cell.selectionStyle = .none
        
        var searchS: Student
        var searchT: Teacher
        
        if indexPath.section == 0{
            if isFiltering {
                searchS = searchStudent[indexPath.row]
            }else{
                searchS = students[indexPath.row]
            }
            cell.setupWith(searchS)
        }else{
            if isFiltering {
                searchT = searchTeacher[indexPath.row]
            }else{
                searchT = teachers[indexPath.row]
            }
            cell.setupWithTeacher(searchT)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if indexPath.section == 0{
            if let student = self.students[indexPath.row] as? Student {
                vc.student = student
            }
        }else{
            if let teacher = self.teachers[indexPath.row] as? Teacher {
                vc.teacher = teacher
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        searchStudent = students.filter({ (students: Student) -> Bool in
            return (students.name!.lowercased().range(of: searchText.lowercased()) != nil)
        })
        searchTeacher = teachers.filter({ (teachers: Teacher) -> Bool in
            return (teachers.name!.lowercased().range(of: searchText.lowercased()) != nil)
        })
        
        TableView.reloadData()
    }
}
