//
//  TripTableViewCell.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var stackView: UIStackView!
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()
    
    var trip: TripItemModel? {
        didSet {
            guard let tripItem = trip else { return }
            setupTripModel(tripItem)
        }
    }
    
    private func setupTripModel(_ tripItem: TripItemModel) {
        titleLabel.text = tripItem.name
        dateLabel.text = tripItem.date
        imageIcon.setImage(urlStr: tripItem.imageURL, placeholder: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 200).isActive = true
        selectionStyle = .none
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initSubviews() {
        initContainerView()
        initImageView()
        initStackView()
    }
    
    private func initContainerView() {
        addSubview(containerView)
        containerView.anchor(top:      contentView.topAnchor,
                             leading:  contentView.leadingAnchor,
                             bottom:   contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: UIEdgeInsets(top: 8, left: 16.0, bottom: -8.0, right: -16.0))
    }
    
    private func initImageView() {
        containerView.addSubview(imageIcon)
        imageIcon.anchor(top:      containerView.topAnchor,
                         leading:  containerView.leadingAnchor,
                         bottom:   containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor)
    }
    
    private func initStackView() {
        stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        containerView.addSubview(stackView)
        stackView.anchor(top:      nil,
                         leading:  containerView.leadingAnchor,
                         bottom:   containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor,
                         padding: UIEdgeInsets(top: 0.0, left: 16.0, bottom: -16.0, right: -16.0),
                         size: CGSize(width: 0, height: 60))
    }
}
