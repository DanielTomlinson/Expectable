import FailureType

public struct Expectation<T> {
  var target: T
}

public extension Expectation {
  func to<M: Matcher where M.T == T>(matcher: M, function: String = __FUNCTION__, file: String = __FILE__, line: UInt = __LINE__) throws {
    if !matcher.matches(target) {
      throw Failure(reason: "\(target) did not meet expectation: \(matcher)", function: function, file: file, line: line)
    }
  }
}

