//
//  DashboardViewController.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import UIKit

import UIKit

class DashboardViewController: UITableViewController {
    
    private let user: UserEntity?
    private let menuItems = ["Lista de Personajes"]
    private let menuIcons = ["rick"]
    
    init(user: UserEntity) {
        self.user = user
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inicio"
        view.backgroundColor = UIColor(red: 0.941, green: 0.949, blue: 0.945, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupFooterButton()
    }
    
    private func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let greeting: String
        switch hour {
        case 6..<12: greeting = "Buenos días"
        case 12..<19: greeting = "Buenas tardes"
        default: greeting = "Buenas noches"
        }
        return "\(greeting), \(user?.name.capitalized ?? "")"
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.accessoryType = .none
        cell.imageView?.image = UIImage(named: menuIcons[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        
        let greetingLabel = UILabel()
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.text = greetingMessage()
        greetingLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        greetingLabel.textColor = .white
        greetingLabel.textAlignment = .center
        greetingLabel.numberOfLines = 0
        greetingLabel.layer.cornerRadius = 4
        greetingLabel.clipsToBounds = true
        greetingLabel.backgroundColor = .gray
        
        
        headerView.addSubview(greetingLabel)
        
        NSLayoutConstraint.activate([
            greetingLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            greetingLabel.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 16),
            greetingLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16)
        ])
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Aquí iría la navegación a la lista de personajes
    }
    
    private func setupFooterButton() {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        
        let logoutButton = UIButton(type: .system)
        logoutButton.backgroundColor = .systemRed
        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.layer.cornerRadius = 4
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        footerView.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
        
        tableView.tableFooterView = footerView
    }
    
    @objc private func logoutTapped() {
        print("Cerrar sesión pulsado")
        // Aquí implementa la lógica de logout y transición a pantalla login
    }
}
