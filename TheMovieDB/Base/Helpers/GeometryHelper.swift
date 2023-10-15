//
//  GeometryHelper.swift
//  TheMovieDB
//
//  Created by Eric on 04/07/2023.
//

import SwiftUI

struct GeometryHelper {
    static func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    static func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        if offset > 0 {
            return -offset
        }
        return 0
    }
    
    static func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height
        
        if offset > 0 {
             return imageHeight + offset
        }
        
        return imageHeight
    }
}
