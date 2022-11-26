//
//  AppConstants.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 20/01/22.
//

public struct AppConstants {
    struct Color {
        static let backgroundColor = 0xF7F7F7
        static let navBarColor = 0xAF2E33
        static let navBarColorClear = 0xBA4C50
        static let fontNunitoBlueColor = 0x596780
        static let searchButtonBorder = 0xD6B656
        static let searchButtonSelectedColor = 0xFFF2CC
        static let UnselectedFieldColor = 0xE8CCCC
    }
    
    struct ImgResource {
        static let iconImg = ["house", "magnifyingglass"]
    }
    
    struct Search {
        static let searchPlaceHolderText = "Search a movie"
        static let searchTypeText = "Use keyword"
    }
 
    struct API {
        static let baseURL = "https://api.themoviedb.org"
        
        static let trendingSection = ("Trending", "/3/trending/movie/day")
        static let nowPlayingSection = ("Now Playing", "/3/movie/now_playing")
        static let popularSection = ("Popular", "/3/movie/popular")
        static let topRatedSection = ("Top Rated", "/3/movie/top_rated")
        static let upcomingSection = ("Upcoming", "/3/movie/upcoming")
        
        static let sectionInfo = [
            trendingSection,
            nowPlayingSection,
            popularSection,
            topRatedSection,
            upcomingSection
        ]

        static let similarSection = ("Similar Movies", "/3/movie/%d/similar")
        static let recommendedSection = ("Recommended Movies", "/3/movie/%d/recommendations")
        static let creditsEndpoint = "/3/movie/%d/credits"
        static let reviewsSection = ("Reviews", "/3/movie/%d/reviews")
        
        static let keywordSearchEndpoint = "/3/search/keyword"
        static let keywordMoviesEndpoint = "/3/keyword/%d/movies"
        static let searchEndpoint = "/3/search/movie"
        static let movieEndpoint = "/3/movie/%d"
        
        struct params {
            static let apiKey = "api_key"
            static let apiKeyValue = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
            static let language = "language"
            static let region = "region"
            static let page = "page"
            static let query = "query"
        }
        
        static let jsonHeader = ["application/json": "Accept"]
        
        // NiceToHave: - get these values from calling API config endpoint
        static let imgBaseUrl = "http://image.tmdb.org/t/p/"
        
        struct backdropSizes {
            static let small = "w300"
            static let medium = "w780"
            static let large = "w1280"
            static let original = "original"
        }

        struct posterSizes {
            static let mini = "w92"
            static let xs = "w154"
            static let small = "w185"
            static let medium = "w342"
            static let large = "w500"
            static let xl = "w780"
            static let original = "original"
        }

    }
    
    static let segmentedControlItems = ["Cast", "Crew"]
}
