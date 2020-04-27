//
//  ContentSizedTableView.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
