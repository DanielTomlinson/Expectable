
public protocol Matcher {
  typealias T

  func matches(target: T) -> Bool 
}

public struct EquatableMatcher<T: Equatable>: Matcher {
  private let expectedResult: T

  public init(_ expectedResult: T) {
    self.expectedResult = expectedResult
  }

  public func matches(target: T) -> Bool {
    return expectedResult == target
  }
}

public struct InversionMatcher<M: Matcher>: Matcher {
  private let matcher: M

  public init(_ matcher: M) {
    self.matcher = matcher
  }

  public func matches(target: M.T) -> Bool {
    return !matcher.matches(target)
  }
}

public func equal<T: Equatable>(value: T) -> EquatableMatcher<T> {
  return EquatableMatcher(value)
}

public func not<M: Matcher>(matcher: M) -> InversionMatcher<M> {
  return InversionMatcher(matcher)
}

public func ==<T: Equatable>(lhs: Expectation<T>, rhs: T) throws {
  try lhs.to(equal(rhs))
}

public func !=<T: Equatable>(lhs: Expectation<T>, rhs: T) throws {
  try lhs.to(not(equal(rhs)))
}
