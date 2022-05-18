func oaoi(of arr: [Int]?) -> Int { return arr?.randomElement() ?? Int.random(in: 1...100) }
oaoi(of: [1,2,3])
