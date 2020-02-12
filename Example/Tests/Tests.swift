import XCTest
@testable import TheMovieDatabase

class Tests: XCTestCase {
	
	var movieDB: TheMovieDatabase?
	var cache: NSCache<NSString, AnyObject>?
    
    override func setUp() {
        super.setUp()
		cache = NSCache<NSString, AnyObject>()
		movieDB = TheMovieDatabase(with: cache)
    }
    
    override func tearDown() {
        super.tearDown()
		movieDB = nil
		cache = nil
    }
    
    func testSearchForMovieNameThatExists() {
		movieDB?.searchFor(movieNamed: "harry potter") { (results) in
			XCTAssertNotNil(results)
		}
	}
    
    func testSearchForMovieNameThatDoesNotExist() {
		movieDB?.searchFor(movieNamed: "---------------") { (results) in
			XCTAssertNil(results)
		}
	}
    
    func testDownloadMoviePosterThatExists() {
		movieDB?.searchFor(movieNamed: "jaws") { (results) in
			
			guard let posterPath = results.first?.posterPath else {
				XCTFail()
				return
			}
			
			self.movieDB?.getImage(atPath: posterPath) { (moviePosterImage) in
				XCTAssertNotNil(moviePosterImage)
			}
		}
	}
    
    func testDownloadMoviePosterThatDoesNotExist() {
		
		self.movieDB?.getImage(atPath: "--------.png") { (moviePosterImage) in
			XCTAssertNotNil(moviePosterImage)
		}
	}
    
    func testMoviePosterIsCached() {
		
		movieDB?.searchFor(movieNamed: "jaws") { (results) in
			
			guard let posterPath = results.first?.posterPath else {
				XCTFail()
				return
			}
			
			self.movieDB?.getImage(atPath: posterPath) { (moviePosterImage) in
				XCTAssertNotNil(moviePosterImage)
				XCTAssertNotNil(self.cache?.object(forKey: posterPath as NSString))
			}
		}
	}
}
