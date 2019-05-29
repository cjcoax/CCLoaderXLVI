//
//  SquareLoader.swift
//  LoaderXLVI
//
//  Created by Amir REZVANI on 5/28/19.
//  Copyright © 2019 Amir REZVANI. All rights reserved.
//

import UIKit

public class SquareLoader: UIView {
    
    enum Position: Int {
        case topLeft
        case bottomLeft
        case bottomRight
        case topRight
    }
    
    // MARK: - private properties
    
    private var squares = [MiniSquare]()
    private var first: MiniSquare?
    private var isFirstLoad = true
    private var squareBorderWidth: CGFloat = 11
    private var activeCorner: Position!
    private var shouldStop: Bool = false
    private var side: CGFloat {
        return bounds.width/2.0 - squareBorderWidth/2.0
    }
    
    // MARK: - initializer[s]
    
    public init(frame: CGRect, squareBorderwidth: CGFloat) {
        super.init(frame: frame)
        
        self.squareBorderWidth = squareBorderwidth
        addSquares()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSquares()
    }
    
    // MARK: - lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard isFirstLoad else {
            return
        }
        isFirstLoad = false
        
        squares.forEach { [weak self] square in
            guard let self = self else {
                return
            }
            
            self.configureSquareFrameAndCenter(square)
        }
    }
    
    // MARK: - methods
    
    public func beginLoader() {
        let nullableActiveSquare = squares.first { [weak self] (ms) -> Bool in
            guard let self = self else {
                return false
            }
            return ms.position == self.activeCorner
        }
        
        guard let activeSquare = nullableActiveSquare else {
            return
        }
        let oldActiveCorner = activeCorner
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        guard let self = self else {
                            return
                        }
                        let position = activeSquare.position!
                        switch position {
                        case .topLeft:
                            activeSquare.frame.size.width = self.bounds.width
                        case .topRight:
                            activeSquare.frame.size.height = self.bounds.height
                        case .bottomRight:
                            activeSquare.frame.origin.x = 0
                            activeSquare.frame.size.width = self.bounds.width
                        case .bottomLeft:
                            activeSquare.frame.origin.y = 0
                            activeSquare.frame.size.height = self.bounds.height
                        }
        }) { (completed) in
            let position = activeSquare.position!
            
            switch position {
            case .topLeft:
                activeSquare.position = .topRight
            case .topRight:
                activeSquare.position = .bottomRight
            case .bottomRight:
                activeSquare.position = .bottomLeft
            case .bottomLeft:
                activeSquare.position = .topLeft
            }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveEaseOut,
                           animations: { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.configureSquareFrameAndCenter(activeSquare)
            }, completion: { [weak self] (completed) in
                guard let self = self,
                    let newActiveCorner = Position(rawValue: (oldActiveCorner!.rawValue + 1)%4),
                    !self.shouldStop else {
                    return
                }
                self.activeCorner = newActiveCorner
                self.beginLoader()
            })
        }
    }
    
    public func stopLoader() {
        shouldStop = true
    }
    
    // MARK: - private methods
    
    private func configureSquareFrameAndCenter(_ square: MiniSquare) {
        let position = square.position!
        
        let side = bounds.width/2.0 - squareBorderWidth/2.0
        let offsetToCenter = side/2.0 + squareBorderWidth/2.0
        square.frame = CGRect(x: 0, y: 0, width: side, height: side)
        let center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        
        switch position {
        case .topLeft:
            square.center = CGPoint(x: center.x - offsetToCenter, y: center.y - offsetToCenter)
        case .topRight:
            square.center = CGPoint(x: center.x + offsetToCenter, y: center.y - offsetToCenter)
        case .bottomRight:
            square.center = CGPoint(x: center.x + offsetToCenter, y: center.y + offsetToCenter)
        case .bottomLeft:
            square.center = CGPoint(x: center.x - offsetToCenter, y: center.y + offsetToCenter)
        }
    }
    
    private func addSquares() {
        addSquare(.topLeft)
        addSquare(.bottomLeft)
        addSquare(.bottomRight)
        
        activeCorner = .topLeft
    }
    
    private func addSquare(_ at: Position) {
        let square = MiniSquare(frame: .zero, position: at, width: squareBorderWidth)
        squares.append(square)
        addSubview(square)
    }
    
}

class MiniSquare: UIView {
    
    // MARK: - internal properties
    
    var position: SquareLoader.Position!
    
    init(frame: CGRect,
         position: SquareLoader.Position,
         width: CGFloat) {
        super.init(frame: frame)

        self.position = position
        
        layer.borderWidth = width
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
}
