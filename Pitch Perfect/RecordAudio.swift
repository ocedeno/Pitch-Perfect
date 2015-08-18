//
//  RecordAudio.swift
//  Pitch Perfect
//
//  Created by Programming on 8/13/15.
//  Copyright © 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import Foundation

class RecordedAudio {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}