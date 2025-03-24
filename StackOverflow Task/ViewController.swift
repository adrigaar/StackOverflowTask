
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var users: [User]?
    var networkHandler: NetworkHandling = NetworkHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        userTableView.dataSource = self
        userTableView.delegate = self
        getUsers()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell, let user = users?[indexPath.row] else {
            return UITableViewCell()
        }
        networkHandler.getImage(from: user.pfpUrl) { result in
            DispatchQueue.main.async {
                if case .success(let image) = result {
                    cell.setup(fromUser: user, withImage: image)
                } else {
                    cell.setup(fromUser: user)
                }
            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
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
                DispatchQueue.main.async {
                    self.userTableView.reloadData()
                }
            case .failure(_):
                //handle failure to get users here
                break
            }
        }
    }
}

