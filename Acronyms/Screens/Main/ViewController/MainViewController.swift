//
//  ViewController.swift
//  Acronyms
//
//  Created by Pattrick Do on 8/10/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel = MainViewModel(acronymService: AcronymService())
    
    @IBOutlet weak var initialismTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                if let error = error {
                    self.showErrorMessage(message: error.errorMessage)
                }
            }
            .store(in: &cancellables)
        viewModel.$acronyms
            .receive(on: DispatchQueue.main)
            .sink {[weak self] response in
                if (response == nil && self?.initialismTextField.text != "") {
                    self?.showErrorMessage(message: "No Data")
                    return
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @IBAction func onClickSubmitButton() {
        guard let initialism = initialismTextField.text, !initialism.isEmpty else {
            return
        }
        viewModel.fetchAcronyms(initialism: initialism)
    }
    
    private func showErrorMessage(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.acronyms?.lfs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.acronyms?.lfs[indexPath.row].lf ?? ""
        cell.contentConfiguration = content
        return cell
    }
}

