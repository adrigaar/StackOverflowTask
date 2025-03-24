
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var users: [User]!
    var networkHandler: NetworkHandling = NetworkHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController {
    fileprivate func getUsers() {
        networkHandler.getUsers { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let users):
                self.users = users
            case .failure(_):
                //handle failure to get users here
                break
            }
        }
    }
}

