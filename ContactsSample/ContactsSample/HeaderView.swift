//
//  HeaderView.swift
//  ContactsSample
//
//  Created by Prasad.d on 09/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var labelGroupName: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        
        
    }
    
    override func awakeFromNib() {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: "EditName")
        textAttachment.bounds = CGRect.init(x: 10, y: 0, width: 15, height: 15)
        // Whatever you need to match your font
        
        let imageString = NSAttributedString(attachment: textAttachment)
        let labelString = NSMutableAttributedString(string: labelGroupName.text!)
        labelString.append(imageString)
        labelGroupName.attributedText = labelString
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//
//    
//    func initViews() -> HeaderView{
//        let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! UIView
//        return view as! HeaderView
//        
//    }

}
