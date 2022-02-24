//
//  API.Manager.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 05/07/2021.
//

import Foundation


struct APIManager {
    //MARK: Config
    struct Path {
        static let base_domain = "http://match.allfootballapp.com/"
        static let base_path = "app/oldMatchList"
        static let base_domain_match = "https://n.allfootballapp.com/"
        static let event_match_first = "api/data/event/match/"
        static let event_match_end = "?isJSON=true&language=en"
        static let search_suggest_first = "https://search.allfootballapp.com/app/search/suggest?q="
        static let search_suggest_end = "&l=en-GB&language=en-GB&app=af"
        static let search_normal_first = "https://search.allfootballapp.com/app/search/normal?q="
        static let search_normal_end = "&l=en-GB&language=en-GB&app=af"
        static let search_sample_first = "https://sport-data.allfootballapp.com/soccer/biz/af/team/sample/"
        static let search_sample_end = "?language=en-GB&app=af"
        static let search_info_first = "https://api.allfootballapp.com/data/detail/team/"
        static let search_info_end = "?language=en-GB&app=af"
        static let search_teamplayer_first = "https://sport-data.allfootballapp.com/soccer/biz/af/v1/team/member/"
        static let search_teamplayer_end = "?language=en-GB&app=af"
        static let search_teammatch_first = "https://api.allfootballapp.com/data/team/schedule/"
        static let search_teammatch_end = "?language=en-GB&app=af"
        static let tab_team_rank_first = "https://sport-data.allfootballapp.com/soccer/biz/data/seasons?competition_id="
        static let tab_team_rank_end = "&app=af&version=270&platform=ios&language=en-GB"
        static let matchsk_domain = "https://n.allfootballapp.com/v2/overview?matchId="
    }
    
    //MARK: - Domain
    struct FootBall {
        
    }
    
    struct Downloader {}
}
