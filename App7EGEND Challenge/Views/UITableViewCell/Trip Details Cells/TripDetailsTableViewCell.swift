//
//  TripDetailsTableViewCell.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 07/11/2021.
//

import UIKit

class TripDetailsTableViewCell: UITableViewCell {
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.textColor = .black
        return textView
    }()
    
    var tripDescription: TripDescriptionModel? {
        didSet {
            guard let description = tripDescription else { return }
            setupTripModel(description)
        }
    }
    
    private func setupTripModel(_ description: TripDescriptionModel) {
        textView.attributedText = textAttributedString(description.title ?? "", description.description ?? "")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 250).isActive = true
        selectionStyle = .none
        initTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initTextView() {
        addSubview(textView)
        textView.anchor(top:      contentView.topAnchor,
                        leading:  contentView.leadingAnchor,
                        bottom:   contentView.bottomAnchor,
                        trailing: contentView.trailingAnchor,
                        padding:  UIEdgeInsets(top: 8, left: 16.0, bottom: -8.0, right: -16.0))
    }
    
    private func textAttributedString(_ title: String, _ description: String) -> NSAttributedString {
        let text = NSMutableAttributedString()
        
        var firstTextAttributes = [NSAttributedString.Key: AnyObject]()
        firstTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 19)
        firstTextAttributes[NSAttributedString.Key.foregroundColor] = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        var secoundTextAttributes = [NSAttributedString.Key: AnyObject]()
        firstTextAttributes[.font] = UIFont.systemFont(ofSize: 15)
        secoundTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.lightGray
        
        text.append(NSAttributedString(string: title+"\n" , attributes: firstTextAttributes))
        text.append(NSAttributedString(string: description , attributes: secoundTextAttributes))
        return text
    }
}
