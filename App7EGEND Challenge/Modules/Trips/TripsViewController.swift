//
//  TripsViewController.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import UIKit

class TripsViewController: UIViewController {
    
    private lazy var viewModel = TripsViewModel()
    private var heightForRow: CGFloat = 200.0
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.indicatorStyle = UIScrollView.IndicatorStyle.black
        tableView.estimatedRowHeight = 200.0
        tableView.backgroundColor = .white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "My Trips"
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        self.tableView.anchorToFill(view: view)
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(TripTableViewCell.self, forCellReuseIdentifier: TripTableViewCell.className)
    }
}

extension TripsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 60, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripTableViewCell.className, for: indexPath) as! TripTableViewCell
        let tripItem = viewModel.cellForRowAt(indexPath: indexPath)
        cell.trip = tripItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for cell in tableView.visibleCells {
            if cell is TripTableViewCell {
                if let selectedIndex = tableView.indexPath(for: cell), selectedIndex.row == indexPath.row {
                    let cell = cell as? TripTableViewCell
                    cell?.contentView.didSelectItemWithAnimate()
                    let tripItem = viewModel.cellForRowAt(indexPath: indexPath)
                    let vc = TripDetailsViewController(tripDescriptionModel: tripItem?.description, backgroundImage: tripItem?.imageURL ?? "")
                    present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
}

extension TripsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellsArray = self.tableView.visibleCells
        for cell in cellsArray where cell is TripTableViewCell {
            guard let cell = (cell as? TripTableViewCell) else { return }
            
            UIView.animate(withDuration: 0.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [], animations: {
                cell.containerView.layoutMargins = UIEdgeInsets(top: 8, left: 16.0, bottom: -70.0, right: -16.0)
                cell.layoutIfNeeded()
                
            }, completion: { (finished) in
                cell.layoutIfNeeded()
            })
        }}
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let cellsArray = self.tableView.visibleCells
        for cell in cellsArray where cell is TripTableViewCell {
            guard let cell = (cell as? TripTableViewCell) else { return }
            UIView.animate(withDuration: 0.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [], animations: {
            }, completion: { (finished) in
                cell.containerView.layoutMargins = UIEdgeInsets(top: 8, left: 16.0, bottom: -8.0, right: -16.0)
                cell.layoutIfNeeded()
            })
        }
    }
}
