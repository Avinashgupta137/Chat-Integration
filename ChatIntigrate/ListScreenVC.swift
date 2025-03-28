//
//  ViewController.swift
//  ChatIntigrate
//
//  Created by Sanskar IOS Dev on 27/03/25.
//

import UIKit

class ListScreenVC: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel = ListViewModel()
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setupViewModel()
          viewModel.fetchChatStore()
      }
      
      func setupViewModel() {
          viewModel.onDataUpdated = { [weak self] in
              DispatchQueue.main.async {
                  self?.mainTableView.reloadData()
              }
          }
      }

}
extension ListScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.bookings.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? ListDetailViewCell else {
                return UITableViewCell()
            }
            let booking = viewModel.bookings[indexPath.row]
            cell.config(with: booking)
            return cell
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let chatViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController") as? chatViewController {
            let selectedBooking = viewModel.bookings[indexPath.row]
            chatViewController.booking = selectedBooking
            chatViewController.requestId = "\(selectedBooking.id ?? 0)"
            navigationController?.pushViewController(chatViewController, animated: true)
        }
    }
}

