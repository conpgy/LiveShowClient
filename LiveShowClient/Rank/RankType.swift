//
//  RankType.swift
//  LiveShowClient
//
//  Created by penggenyong on 2016/12/13.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import Foundation

enum RankType: CustomStringConvertible {

    case Star(TimeRankType)
    case Wealth(TimeRankType)
    case Popularity(TimeRankType)
    case Week(WeekRankType)
    
    var description: String {
        switch self {
        case .Star:
            return "明星榜"
        case .Wealth:
            return "富豪榜"
        case .Popularity:
            return "人气榜"
        case .Week:
            return "周星榜"
        }
    }
    
    var title: String {
        switch self {
        case .Star:
            return "rankStar"
        case .Wealth:
            return "rankWealth"
        case .Popularity:
            return "rankPopularity"
        case .Week:
            return "weekStar"
        }
    }
    
}

extension RankType {
    static func parse(with index: Int) -> RankType? {
        
        var rankType: RankType?
        
        switch index {
        case (0..<12):
            let timeRankType = TimeRankType(rawValue: index % 4 + 1)!
            
            let type = index / 4 + 1
            
            switch type {
            case 1:
                rankType = RankType.Star(timeRankType)
            case 2:
                rankType = RankType.Wealth(timeRankType)
            case 3:
                rankType = RankType.Popularity(timeRankType)
            default:
                break
            }
        case 12:
            rankType = RankType.Week(WeekRankType.This)
        case 13:
            rankType = RankType.Week(WeekRankType.Last)
        default:
            break;
        }
        
        return rankType
    }
    
    var subRankDescription: String {
        switch self {
        case let .Star(subRank):
            return subRank.description
        case let .Wealth(subRank):
            return subRank.description
        case let .Popularity(subRank):
            return subRank.description
        case let .Week(subRank):
            return subRank.description
        }
    }
}


enum TimeRankType: Int, CustomStringConvertible {
    case Day = 1
    case Weak = 2
    case Month = 3
    case All = 4
    
    var description: String {
        var desc: String
        
        switch self {
        case .Day:
            desc = "日"
        case .Weak:
            desc = "周"
        case .Month:
            desc = "月"
        case .All:
            desc = "总"
        }
        return desc
    }
}

enum WeekRankType: Int, CustomStringConvertible {
    case This = 0
    case Last = 1
    
    var description: String {
        switch self {
        case .This:
            return "本周"
        case .Last:
            return "上周"
        }
    }
}
