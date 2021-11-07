//
//  TripDetailsViewController.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import UIKit

class TripDetailsViewController: ClippedViewController {
    
    private var viewModel = TripDetailsViewModel()
    private var heightForRow: CGFloat = 250.0
    private let initialHeight: CGFloat = 250.0 + App7EGENDSizes.safeAreaInsets.bottom
    private let screenSize = UIScreen.main.bounds
    private var tableView: UITableView!
    
    init(tripDescriptionModel: TripDescriptionModel?, backgroundImage: String) {
        super.init()
        super.yPadding = screenSize.height - initialHeight
        viewModel.tripDescription = tripDescriptionModel
        viewModel.backgroundImage = backgroundImage
    }
    
    override init() {
        super.init()
        super.yPadding = screenSize.height - initialHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(imagePath: viewModel.backgroundImage ?? "")
        initSubViews()
    }
    
    private func initSubViews() {
        initTableView()
    }
    
    private func initTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        addOnClippedView(tableView)
        tableView.anchor(top:       clippedView.topAnchor,
                         leading:   clippedView.leadingAnchor,
                         bottom:    clippedView.bottomAnchor,
                         trailing:  clippedView.trailingAnchor,
                         padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(TripDetailsTableViewCell.self, forCellReuseIdentifier: TripDetailsTableViewCell.className)
    }
    
    @objc private func closeButtonDidTapped() {
        clippedView.dismiss()
    }
}

extension TripDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TripDetailsTableViewCell.className, for: indexPath) as! TripDetailsTableViewCell
        cell.tripDescription = viewModel.tripDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return initialHeight - App7EGENDSizes.safeAreaInsets.bottom
    }
}
