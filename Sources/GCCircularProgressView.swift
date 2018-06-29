//
//  GCCircularProgressView.swift
//  CGCircularProgressView
//
//  Created by Giancarlo Diaz Cavalcante on 06/06/18.
//  Copyright © 2018 Giancarlo Diaz Cavalcante. All rights reserved.
//

import UIKit

@IBDesignable
open class GCCircularProgressView: UIView {
    
    // ==================================================
    //
    //  MARK: - Private Properties
    //
    // ==================================================
    
    private let mainCircularShapeLayer = CAShapeLayer()
    private let pathCircularShapeLayer = CAShapeLayer()
    private var centerLabel = UILabel()
    
    // ==================================================
    //
    //  MARK: - Line Properties
    //
    // ==================================================
    
    /**
     The color of the circular path that will be animated.
     
     The default value for this property is a black color.
     */
    @IBInspectable
    open var lineColor: UIColor = .black {
        didSet {
            guard self.lineColor != oldValue else { return }
            self.mainCircularShapeLayer.strokeColor = self.lineColor.cgColor
        }
    }
    
    /**
     Specifies the line width of the circular path that will be animated.
     
     The default value for this property is `10`.
     */
    @IBInspectable
    open var lineWidth: CGFloat = 10 {
        didSet {
            guard self.lineWidth != oldValue else { return }
            self.mainCircularShapeLayer.lineWidth = self.lineWidth
            self.pathCircularShapeLayer.lineWidth = self.lineWidth
        }
    }
    
    /**
     The duration of the animation.
     
     Specifies the basic duration of the animation, in seconds.
     
     The default value for this property is `2`.
     */
    @IBInspectable
    open var animationDuration: CFTimeInterval = 2
    
    // ==================================================
    //
    //  MARK: - Center Text Properties
    //
    // ==================================================
    
    /**
     The color of the label inscribed in the circular path.
     
     The default value for this property is a black color.
     */
    @IBInspectable
    open var centerLabelColor: UIColor = .black {
        didSet {
            guard self.centerLabelColor != oldValue else { return }
            self.centerLabel.textColor = self.centerLabelColor
        }
    }
    
    /**
     The font of the label inscribed in the circular path.
     
     The default value for this property is the system font with size `15`.
     */
    open var centerLabelFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            guard self.centerLabelFont != oldValue else { return }
            self.centerLabel.font = self.centerLabelFont
        }
    }
    
    /**
     The text of the label inscribed in the circular path.
     
     The default value for this property is nil.
     */
    @IBInspectable
    open var centerLabelText: String? {
        didSet {
            guard self.centerLabelText != nil else { return }
            self.centerLabel.text = self.centerLabelText
        }
    }
    
    /**
     The styled text of the label inscribed in the circular path.
     
     The default value for this property is nil.
     */
    @IBInspectable
    open var centerLabelAttributedText: NSAttributedString? {
        didSet {
            guard self.centerLabelAttributedText != nil else { return }
            self.centerLabel.attributedText = self.centerLabelAttributedText
        }
    }
    
    // ==================================================
    //
    //  MARK: - Initializers
    //
    // ==================================================
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCircularProgressLayer(with: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.setupCircularProgressLayer(with: self)
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupCircularProgressLayer(with: self)
    }
    
    // ==================================================
    //
    //  MARK: - Private Methods
    //
    // ==================================================
    
    private func setupCenterLabel(with view: UIView, circleRadius: CGFloat) {
        let frameSideSize = circleRadius * sqrt(2.0)
        self.centerLabel = UILabel(frame: CGRect(x: (view.frame.size.width / 2) - (frameSideSize / 2),
                                                 y: (view.frame.size.height / 2) - (frameSideSize / 2),
                                                 width: frameSideSize,
                                                 height: frameSideSize))
        self.centerLabel.backgroundColor = .clear
        self.centerLabel.numberOfLines = 0
        self.centerLabel.textAlignment = .center
        self.centerLabel.textColor = self.centerLabelColor
        self.centerLabel.font = self.centerLabelFont
        self.centerLabel.text = self.centerLabelText
        self.centerLabel.attributedText = self.centerLabelAttributedText
        view.addSubview(self.centerLabel)
    }
    
    private func setupCAShapeLayer(with view: UIView, shapeLayer: CAShapeLayer, strokeColor: CGColor, lineWidth: CGFloat, strokeEnd: CGFloat? = nil, hasCenterLabel: Bool = false) {
        let center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        let shortestViewSize = view.frame.size.width > view.frame.size.height ? view.frame.size.height : view.frame.size.width
        let circleRadius = shortestViewSize / 2.2
        let startAngle = -CGFloat.pi / 2
        let endAngle = 1.5 * CGFloat.pi
        let circularPath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        
        if let layerStrokeEnd = strokeEnd {
            shapeLayer.strokeEnd = layerStrokeEnd
        }
        
        view.layer.addSublayer(shapeLayer)
        
        if hasCenterLabel {
            self.setupCenterLabel(with: view, circleRadius: circleRadius)
        }
    }
    
    private func setupCircularProgressLayer(with view: UIView) {
        self.setupCAShapeLayer(with: view, shapeLayer: self.pathCircularShapeLayer, strokeColor: #colorLiteral(red: 0.0002570023353, green: 0, blue: 0, alpha: 0.4045093912).cgColor, lineWidth: self.lineWidth)
        self.setupCAShapeLayer(with: view, shapeLayer: self.mainCircularShapeLayer, strokeColor: self.lineColor.cgColor, lineWidth: self.lineWidth, strokeEnd: 0, hasCenterLabel: true)
    }
    
    // ==================================================
    //
    //  MARK: - Public Methods
    //
    // ==================================================
    
    /**
     Runs the circular path animation with the specified animationDuration.
     
     If the animationDuration property is zero or negative, the duration is changed to the default value of 0.25 seconds.
     */
    public func runAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = self.animationDuration
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        self.mainCircularShapeLayer.add(basicAnimation, forKey: "layerAnimation")
    }
    
    /**
     Runs the circular path animation with the specified animationDuration and completion handler.
     
     If the animationDuration property is zero or negative, the duration is changed to the default value of 0.25 seconds.
     */
    public func runAnimation(completion: @escaping () -> Void) {
        CATransaction.begin()
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = self.animationDuration
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        CATransaction.setCompletionBlock(completion)
        self.mainCircularShapeLayer.add(basicAnimation, forKey: "layerAnimation")
        CATransaction.commit()
    }
}
