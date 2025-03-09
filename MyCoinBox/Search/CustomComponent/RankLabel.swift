//
//  RankLabel.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/9/25.
//

import UIKit

final class RankLabel: UILabel {

    private var padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = .subText
        textAlignment = .center
        font = .systemFont(ofSize: 9, weight: .bold)
        layer.cornerRadius = 4
        layer.backgroundColor = UIColor.badgeBg.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
