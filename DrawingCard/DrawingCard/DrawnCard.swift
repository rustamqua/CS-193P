//
//  DrawnCard.swift
//  DrawingCard
//
//  Created by Rustam-Deniz on 6/12/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import UIKit
@IBDesignable
class DrawnCard: UIView {
	@IBInspectable
	var rank: Int = 11 {didSet {
		setNeedsDisplay()
		setNeedsLayout()
		}}
	@IBInspectable
	var suit: String = "♠️" {didSet {
	setNeedsDisplay()
	setNeedsLayout()
	}}
	@IBInspectable
	var isFaceUp: Bool = true{didSet {
	setNeedsDisplay()
	setNeedsLayout()
	}}
	
	private var cornerString: NSAttributedString{
		return centeredAttributedString("\(rankString)\n\(suit)", fontSize: cornerFontSize)
	}

	private lazy var upperLeftCornerLabel = createCornerLabel()
	private lazy var lowerRightCornerLabel = createCornerLabel()
	
	private func createCornerLabel() -> UILabel {
		let label = UILabel()
		label.numberOfLines = 0
		addSubview(label)
		return label
	}

	private func centeredAttributedString(_ str: String, fontSize: CGFloat) -> NSAttributedString{
		var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
		font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		return NSAttributedString(string: str, attributes: [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		setNeedsDisplay()
		setNeedsLayout()
	}
	
	private func configureCornerLabel(_ label: UILabel){
		label.attributedText = cornerString
		label.frame.size = CGSize.zero
		label.sizeToFit()
		label.isHidden = !isFaceUp
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		configureCornerLabel(upperLeftCornerLabel)
		upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
		configureCornerLabel(lowerRightCornerLabel)
		lowerRightCornerLabel.transform = CGAffineTransform.identity.translatedBy(x: lowerRightCornerLabel.frame.size.width, y: frame.size.height).rotated(by: CGFloat.pi)
		lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
			.offsetBy(dx: -cornerOffset, dy: -cornerOffset)
			.offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
	}
	  
	override func draw(_ rect: CGRect) {
		let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
		UIColor.white.setFill()
		roundedRect.fill()
		if isFaceUp{
			if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
				faceCardImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
			}
		}
		else{
			if let cardBackImage = UIImage(named: "cardback"){
				cardBackImage.draw(in: bounds)
			}
		}
//		if let context = UIGraphicsGetCurrentContext(){
//			context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
//			context.setLineWidth(5.0)
//			UIColor.red.setFill()
//			UIColor.green.setStroke()
//			context.strokePath()
//			context.fillPath()
//		}
//		self.contentMode = .redraw
//		let path = UIBezierPath()
//		path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: CGFloat.pi, endAngle: CGFloat.pi*2, clockwise: false)
//		path.lineWidth = 5.0
//		UIColor.green.setStroke()
//		UIColor.green.setFill()
//		path.stroke()
//		path.fill()
	}
}
extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

extension DrawnCard {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    public var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    public var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    public var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    public var rankString: String {
        switch rank {
        case 1:
            return "A"
        case 2...10:
            return String(rank)
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        default:
            return "?"
        }
    }
}
